class ActivityMeasurementType {
  final String id;
  final String displayName;

  const ActivityMeasurementType(this.id, this.displayName);

  static Map<String, dynamic> toMap(ActivityMeasurementType type) {
    return {
      'id': type.id,
      'displayName': type.displayName,
    };
  }

  static ActivityMeasurementType fromMap(Map<String, dynamic> map) {
    return ActivityMeasurementType(
      map['id'],
      map['displayName'],
    );
  }

  static const ActivityMeasurementType reps =
      ActivityMeasurementType('reps', 'Reps');
  static const ActivityMeasurementType pounds =
      ActivityMeasurementType('pounds', 'lbs');
  static const ActivityMeasurementType assistedPounds =
      ActivityMeasurementType('assistedPounds', '-lbs');
  static const ActivityMeasurementType additionalPounds =
      ActivityMeasurementType('additionalPounds', '+lbs');
  static const ActivityMeasurementType time =
      ActivityMeasurementType('time', 'Time');
  static const ActivityMeasurementType miles =
      ActivityMeasurementType('miles', 'Miles');

  static const List<ActivityMeasurementType> values = [
    reps,
    pounds,
    assistedPounds,
    additionalPounds,
    time,
    miles,
  ];

  static final Map<String, ActivityMeasurementType> map = {
    for (var measurementType in ActivityMeasurementType.values)
      measurementType.id: measurementType
  };
}

class ActivityType {
  final String id;
  final String displayName;
  final List<ActivityMeasurementType> measurementTypes;

  ActivityType({
    required this.id,
    required this.displayName,
    required this.measurementTypes,
  });

  static ActivityType fromMap(Map<String, dynamic> map) {
    return ActivityType(
      id: map['id'],
      displayName: map['displayName'],
      measurementTypes: map['measurementTypes'] != null
          ? List<ActivityMeasurementType>.from(
              map['measurementTypes'].map(
                (x) => ActivityMeasurementType.fromMap(x),
              ),
            )
          : [],
    );
  }
}

final List<ActivityType> activities = [
  ActivityType(
    id: "pushups",
    displayName: "Pushups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "pullups",
    displayName: "Pullups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "squats",
    displayName: "Squats",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "dips",
    displayName: "Dips",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "situps",
    displayName: "Situps",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "plank",
    displayName: "Plank",
    measurementTypes: [
      ActivityMeasurementType.time,
    ],
  ),
];

final Map<String, ActivityType> activityMap = {
  for (var activity in activities) activity.id: activity
};
