import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddeliveryapp/core/services/database.dart';

class AdminOrdersProvider extends ChangeNotifier {
  Stream<QuerySnapshot>? orders;
  bool isLoading = true;
  String? error;

  Future<void> loadOrders() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      orders = await DataBaseMethods().getAdminOrders();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
