import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddeliveryapp/core/services/database.dart';

class ManageUsersProvider extends ChangeNotifier {
  Stream<QuerySnapshot>? users;
  bool isLoading = true;
  String? error;

  Future<void> loadUsers() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      users = await DataBaseMethods().getAllUsers();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
