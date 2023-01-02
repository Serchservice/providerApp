import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class AuthenticationProvider extends ChangeNotifier{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FbAuth authenticate = FbAuth();

  setLoading() {
    _isLoading =true;
    notifyListeners();
  }

  setNotLoading() {
    _isLoading =false;
    notifyListeners();
  }
}