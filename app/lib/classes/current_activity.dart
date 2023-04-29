import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';

class CurrentSet {
  final List<ActivityMeasurementType> activityMeasurementTypes;
  final Map<ActivityMeasurementType, FocusNode> focusNodes;
  final Map<ActivityMeasurementType, TextEditingController>
      textEditingControllers;

  CurrentSet({
    required this.activityMeasurementTypes,
    required this.focusNodes,
    required this.textEditingControllers,
  });

  factory CurrentSet.fromPreviousSet(
      List<ActivityMeasurementType> activityMeasurementTypes, Set previousSet) {
    return CurrentSet(
      activityMeasurementTypes: activityMeasurementTypes,
      focusNodes: activityMeasurementTypes.asMap().map(
            (index, measurementType) => MapEntry(
              measurementType,
              FocusNode(),
            ),
          ),
      textEditingControllers: activityMeasurementTypes.asMap().map(
            (index, measurementType) => MapEntry(
              measurementType,
              TextEditingController(
                text: previousSet.measurements[measurementType].toString(),
              ),
            ),
          ),
    );
  }

  factory CurrentSet.empty(
      List<ActivityMeasurementType> activityMeasurementTypes) {
    return CurrentSet(
      activityMeasurementTypes: activityMeasurementTypes,
      focusNodes: activityMeasurementTypes.asMap().map(
            (index, measurementType) => MapEntry(
              measurementType,
              FocusNode(),
            ),
          ),
      textEditingControllers: activityMeasurementTypes.asMap().map(
            (index, measurementType) => MapEntry(
              measurementType,
              TextEditingController(
                text: "0",
              ),
            ),
          ),
    );
  }
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
                .map(
                  (previousSet) => CurrentSet.fromPreviousSet(
                    activityType.measurementTypes,
                    previousSet,
                  ),
                )
                .toList() ??
            [CurrentSet.empty(activityType.measurementTypes)];

  void addSet() {
    sets.add(CurrentSet.empty(activityType.measurementTypes));
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    for (var set in sets) {
      for (var focusNode in set.focusNodes.values) {
        focusNode.dispose();
      }
      for (var textEditingController in set.textEditingControllers.values) {
        textEditingController.dispose();
      }
    }
  }
}
