
import 'package:flutter/foundation.dart';

import 'package:fooddeliveryapp/core/services/shared_pref.dart';
import 'package:fooddeliveryapp/core/services/profile_image_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileImageService _imageService =
  ProfileImageService();

  String? name;
  String? email;
  String? profileImageUrl;

  bool isLoading = true;
  bool isUploadingImage = false;

  String? error;

  Future<void> loadProfile() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      name = await SharedpreferenceHelper.getUserName();
      email = await SharedpreferenceHelper.getUserEmail();

      profileImageUrl =
      await _imageService.getProfileImage();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changeProfileImage() async {
    if (isUploadingImage) return false;

    isUploadingImage = true;
    error = null;
    notifyListeners();

    try {
      final url =
      await _imageService.uploadProfileImage();

      if (url == null) return false;

      profileImageUrl = url;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isUploadingImage = false;
      notifyListeners();
    }
  }
}
