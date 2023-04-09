import 'package:flutter/material.dart';

class Set {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
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
