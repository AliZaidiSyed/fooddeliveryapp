import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddeliveryapp/core/services/database.dart';
import 'package:fooddeliveryapp/core/services/shared_pref.dart';

class WalletProvider extends ChangeNotifier {
  String? email;
  String? userId;
  String? wallet;
  Stream<QuerySnapshot>? transactions;
  bool isLoading = true;
  bool isProcessingPayment = false;
  String? error;

  Future<void> loadWallet() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final loadedEmail = await SharedpreferenceHelper.getUserEmail();
      final loadedId = await SharedpreferenceHelper.getUserId();
      if (loadedEmail == null || loadedId == null) {
        throw StateError('Wallet user details are unavailable');
      }
      final loadedTransactions = await DataBaseMethods.getUsersTransactions(loadedId);
      final result = await DataBaseMethods().getUserWalletbyemail(loadedEmail);
      if (result.docs.isEmpty) throw StateError('Wallet account not found');
      email = loadedEmail;
      userId = loadedId;
      transactions = loadedTransactions;
      wallet = '${result.docs.first['Wallet']}';
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProcessingPayment(bool value) {
    if (isProcessingPayment == value) return;
    isProcessingPayment = value;
    notifyListeners();
  }
}
