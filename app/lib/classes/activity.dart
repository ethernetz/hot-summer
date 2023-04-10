import 'package:flutter/material.dart';

class Set {
  final TextEditingController weightController = TextEditingController();
  final FocusNode weightFocusNode = FocusNode();
  final TextEditingController repsController = TextEditingController();
  final FocusNode repsFocusNode = FocusNode();
}

class Activity extends ChangeNotifier {
  final UniqueKey uniqueKey;
  List<Set> sets = [Set()];

  Activity({required this.uniqueKey});

  void addSet() {
    sets.add(Set());
    notifyListeners();
  }
}
