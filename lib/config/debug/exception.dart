import 'package:provide/lib.dart';

class SException implements Exception{
  String message;
  String? code;

  SException(this.message, {this.code}) {
    debugShow(toString());
  }

  @override
  String toString() {
    return "Custom Exception: $message";
  }
}