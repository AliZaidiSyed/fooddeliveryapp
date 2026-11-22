
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fooddeliveryapp/core/services/shared_pref.dart';

class ProfileImageService {
  final _supabase = Supabase.instance.client;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _picker = ImagePicker();

  static const bucket = 'profile-images';

  // Get image URL from Firestore
  Future<String?> getProfileImage() async {
    final userId = await SharedpreferenceHelper.getUserId();

    if (_auth.currentUser == null || userId == null) {
      return null;
    }

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    return doc.data()?['ProfileImageUrl'] as String?;
  }

  // Pick image, upload to Supabase and save URL
  Future<String?> uploadProfileImage() async {
    final user = _auth.currentUser;
    final userId = await SharedpreferenceHelper.getUserId();

    if (user == null || userId == null) {
      throw Exception('User not logged in');
    }

    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1024,
    );

    if (image == null) return null;

    final decoded = img.decodeImage(
      await image.readAsBytes(),
    );

    if (decoded == null) {
      throw Exception('Invalid image');
    }

    final Uint8List bytes = Uint8List.fromList(
      img.encodeJpg(decoded, quality: 80),
    );

    if (bytes.length > 2 * 1024 * 1024) {
      throw Exception('Image is too large');
    }

    // Unique file name for each upload
    final path =
        '${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await _supabase.storage.from(bucket).uploadBinary(
      path,
      bytes,
      fileOptions: const FileOptions(
        contentType: 'image/jpeg',
      ),
    );

    final imageUrl =
    _supabase.storage.from(bucket).getPublicUrl(path);

    await _firestore.collection('users').doc(userId).update({
      'ProfileImageUrl': imageUrl,
    });

    await SharedpreferenceHelper.saveUserImage(imageUrl);

    return imageUrl;
  }
}
