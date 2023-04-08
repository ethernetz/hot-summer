import 'package:flutter/material.dart';

class CurrentWorkoutProvider extends ChangeNotifier {
  bool _isWorkingOut = false;
  bool get isWorkingOut => _isWorkingOut;

  void startWorkout() {
    _isWorkingOut = true;

    notifyListeners();
  }

  void endWorkout() {
    _isWorkingOut = false;
    notifyListeners();
  }
}
