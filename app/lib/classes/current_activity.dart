import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';

class CurrentSet {
  final TextEditingController weightController = TextEditingController();
  final FocusNode weightFocusNode = FocusNode();
  final TextEditingController repsController = TextEditingController();
  final FocusNode repsFocusNode = FocusNode();
}

class CurrentActivity extends ChangeNotifier {
  final UniqueKey uniqueKey;
  final ActivityType activityType;
  List<CurrentSet> sets = [CurrentSet()];

  CurrentActivity({required this.uniqueKey, required this.activityType});

  void addSet() {
    sets.add(CurrentSet());
    notifyListeners();
  }
}
