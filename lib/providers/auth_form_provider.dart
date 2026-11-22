import 'package:flutter/foundation.dart';

/// Password field visibility, independent of Firebase authentication.
class AuthFormProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }
}
