import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';

class Set {
  final TextEditingController weightController = TextEditingController();
  final FocusNode weightFocusNode = FocusNode();
  final TextEditingController repsController = TextEditingController();
  final FocusNode repsFocusNode = FocusNode();
}

class Activity extends ChangeNotifier {
  final UniqueKey uniqueKey;
  final ActivityType activityType;
  List<Set> sets = [Set()];

  Activity({required this.uniqueKey, required this.activityType});

  void addSet() {
    sets.add(Set());
    notifyListeners();
  }
}
