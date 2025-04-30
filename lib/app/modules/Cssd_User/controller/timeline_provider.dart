import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimelineController extends ChangeNotifier {
  DateTime _currentDateTime = DateTime.now();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TimelineController() {
    refreshDateTime();
  }

  DateTime get currentDateTime => _currentDateTime;

  void refreshDateTime() {
    _currentDateTime = DateTime.now();
    notifyListeners();
    if (kDebugMode) {
      print(_currentDateTime);
    }
  }

  
}
