import 'package:flutter/foundation.dart';


class UiRefreshProvider extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
