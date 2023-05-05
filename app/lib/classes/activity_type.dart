enum ActivityMeasurementType {
  reps("Reps"),
  pounds("lbs"),
  assistedPounds("-lbs"),
  additionalPounds("+lbs"),
  time("Time"),
  miles("Miles");

  const ActivityMeasurementType(this.displayName);
  final String displayName;
}

class ActivityType {
  final String name;
  final String displayName;
  final List<ActivityMeasurementType> measurementTypes;

  ActivityType({
    required this.name,
    required this.displayName,
    required this.measurementTypes,
  });
}

final List<ActivityType> activities = [
  ActivityType(
    name: "pushups",
    displayName: "Pushups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    name: "pullups",
    displayName: "Pullups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    name: "squats",
    displayName: "Squats",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    name: "dips",
    displayName: "Dips",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    name: "situps",
    displayName: "Situps",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    name: "plank",
    displayName: "Plank",
    measurementTypes: [
      ActivityMeasurementType.time,
    ],
  ),
];

final Map<String, ActivityType> activityMap = {
  for (var activity in activities) activity.name: activity
};
