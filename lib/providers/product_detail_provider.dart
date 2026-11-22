import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddeliveryapp/core/services/database.dart';
import 'package:fooddeliveryapp/core/services/shared_pref.dart';

/// Quantity, price and checkout information for a single food detail screen.
class ProductDetailProvider extends ChangeNotifier {
  final int unitPrice;
  ProductDetailProvider(this.unitPrice);

  int _quantity = 1;
  int get quantity => _quantity;
  int get totalPrice => _quantity * unitPrice;
  String? name, id, email, address, wallet;
  bool isLoading = true;
  String? error;
  bool _disposed = false;

  void increment() { _quantity++; notifyListeners(); }
  void decrement() {
    if (_quantity <= 1) return;
    _quantity--;
    notifyListeners();
  }

  Future<void> loadCheckoutDetails() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final loadedName = await SharedpreferenceHelper.getUserName();
      final loadedId = await SharedpreferenceHelper.getUserId();
      final loadedEmail = await SharedpreferenceHelper.getUserEmail();
      final loadedAddress = await SharedpreferenceHelper.getUserAddress();
      if (loadedEmail == null) throw StateError('User email unavailable');
      final QuerySnapshot result =
          await DataBaseMethods().getUserWalletbyemail(loadedEmail);
      if (result.docs.isEmpty) throw StateError('Wallet not found');
      if (_disposed) return;
      name = loadedName;
      id = loadedId;
      email = loadedEmail;
      address = loadedAddress;
      wallet = '${result.docs.first['Wallet']}';
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

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updateWallet(int newWallet) {
    wallet = newWallet.toString();
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
