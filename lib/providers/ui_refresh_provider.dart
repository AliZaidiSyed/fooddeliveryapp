import 'package:flutter/foundation.dart';

/// Triggers a Consumer rebuild while keeping each screen's existing logic intact.
class UiRefreshProvider extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
