import 'package:flutter/material.dart';
import 'package:rdcciappointment/models/branch.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    // constructor
    init();
  }

  Branch _selectedBranch;

  Branch get selectedBranch => _selectedBranch;

  set selectedBranch(Branch data) {
    _selectedBranch = data;
    notify();
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
