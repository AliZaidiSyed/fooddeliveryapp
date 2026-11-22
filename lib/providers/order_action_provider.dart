import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddeliveryapp/core/services/database.dart';
import 'package:fooddeliveryapp/core/services/shared_pref.dart';

/// Order screen state. Firestore cancellation/refund operations stay in the screen.
class OrderActionProvider extends ChangeNotifier {
  Stream<QuerySnapshot>? ordersStream;
  String? userId;
  bool isLoading = true;
  String? error;
  bool _disposed = false;
  bool _isCancelling = false;
  bool get isCancelling => _isCancelling;

  Future<void> loadOrders() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final id = await SharedpreferenceHelper.getUserId();
      if (id == null) throw StateError('User ID unavailable');
      final stream = await DataBaseMethods.getUserOrders(id);
      if (_disposed) return;
      userId = id;
      ordersStream = stream;
    } catch (e) {
      if (_disposed) return;
      error = e.toString();
    } finally {
      if (!_disposed) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void setCancelling(bool value) {
    if (_isCancelling == value) return;
    _isCancelling = value;
    notifyListeners();
  }
}
