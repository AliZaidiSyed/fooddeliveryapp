import 'package:flutter/foundation.dart';

/// Food selection and search UI state. Does not own catalog data or Firebase calls.
class CatalogProvider extends ChangeNotifier {
  String _selectedCategory = '0';
  String _query = '';
  List<dynamic> _results = [];

  String get selectedCategory => _selectedCategory;
  String get query => _query;
  List<dynamic> get results => List.unmodifiable(_results);
  bool get isSearching => _query.isNotEmpty;

  void selectCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void search(String query, List<dynamic> foods) {
    _query = query;
    if (query.isEmpty) {
      _results = [];
    } else {
      final term = query.toLowerCase();
      _results = foods.where((food) =>
          (food.name ?? '').toString().toLowerCase().contains(term)).toList();
    }
    notifyListeners();
  }
}
