import 'package:flutter/foundation.dart';

/// Screen-local UI state; existing data, Firebase and payment logic remain unchanged.
class FoodDeliveryProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void selectTab(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    notifyListeners();
  }

  /// Rebuilds dependent widgets after their existing local data changes.
  void refresh() => notifyListeners();
}
