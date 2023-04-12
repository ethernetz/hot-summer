import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';

class CurrentSet {
  final TextEditingController weightController;
  final FocusNode weightFocusNode = FocusNode();
  final TextEditingController repsController;
  final FocusNode repsFocusNode = FocusNode();

  CurrentSet({num? weight, num? reps})
      : weightController =
            TextEditingController(text: weight?.toString() ?? '0'),
        repsController = TextEditingController(text: reps?.toString() ?? '0');
}

class CurrentActivity extends ChangeNotifier {
  final UniqueKey uniqueKey;
  final ActivityType activityType;
  final Activity? previousActivity;
  final List<CurrentSet> sets;

  CurrentActivity({
    required this.uniqueKey,
    required this.activityType,
    this.previousActivity,
  }) : sets = previousActivity?.sets
                .map((set) => CurrentSet(
                      weight: set.weight,
                      reps: set.reps,
                    ))
                .toList() ??
            [CurrentSet()];

  void addSet() {
    sets.add(CurrentSet());
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    for (var set in sets) {
      set.weightController.dispose();
      set.weightFocusNode.dispose();
      set.repsController.dispose();
      set.repsFocusNode.dispose();
    }
  }
}
