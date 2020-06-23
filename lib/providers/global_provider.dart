import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    // constructor
    init();
  }

  bool _loader = false;
  bool get loader => _loader;
  set loader(bool value) {
    this._loader = value;
    notify();
  }

  init() async {}
  notify() {
    try {
      notifyListeners();
    } catch (e) {}
  }
}
