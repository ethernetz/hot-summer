import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';

class CurrentSetProvider extends ChangeNotifier {
  final List<ActivityMeasurementType> activityMeasurementTypes;
  final Map<ActivityMeasurementType, FocusNode> focusNodes;
  final Map<ActivityMeasurementType, TextEditingController>
      textEditingControllers;
  final Set? previousSet;

  CurrentSetProvider({
    required this.activityMeasurementTypes,
    required this.focusNodes,
    required this.textEditingControllers,
    this.previousSet,
  });

  factory CurrentSetProvider.fromPreviousSet(
      List<ActivityMeasurementType> activityMeasurementTypes, Set previousSet) {
    return CurrentSetProvider(
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
      previousSet: previousSet,
    );
  }

  factory CurrentSetProvider.empty(
      List<ActivityMeasurementType> activityMeasurementTypes) {
    return CurrentSetProvider(
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
