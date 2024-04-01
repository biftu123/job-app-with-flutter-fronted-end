import 'package:flutter/material.dart';

class OnbordNotifier extends ChangeNotifier {
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;
  set isLastPage(bool lastPage) {
    _isLastPage = lastPage;
    notifyListeners();
  }
}
