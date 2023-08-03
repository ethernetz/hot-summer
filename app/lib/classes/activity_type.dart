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
    id: "barbellRows",
    displayName: "Barbell Rows",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "benchPress",
    displayName: "Bench Press",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "bentOverRows",
    displayName: "Bent Over Rows",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "bicepCurls",
    displayName: "Bicep Curls",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "cableCrossovers",
    displayName: "Cable Crossovers",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "calfRaises",
    displayName: "Calf Raises",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "deadlift",
    displayName: "Deadlift",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
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
    id: "dumbbellFlyes",
    displayName: "Dumbbell Flyes",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "frontSquats",
    displayName: "Front Squats",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "hammerCurls",
    displayName: "Hammer Curls",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "hipThrusts",
    displayName: "Hip Thrusts",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "inclineBenchPress",
    displayName: "Incline Bench Press",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "latPulldowns",
    displayName: "Lat Pulldowns",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "legCurls",
    displayName: "Leg Curls",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "legExtensions",
    displayName: "Leg Extensions",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "legPress",
    displayName: "Leg Press",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "lunges",
    displayName: "Lunges",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "overheadPress",
    displayName: "Overhead Press",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "preacherCurls",
    displayName: "Preacher Curls",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "pullUps",
    displayName: "Pull-Ups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "pushUps",
    displayName: "Push-Ups",
    measurementTypes: [
      ActivityMeasurementType.reps,
    ],
  ),
  ActivityType(
    id: "romanianDeadlifts",
    displayName: "Romanian Deadlifts",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "seatedRow",
    displayName: "Seated Row",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "seatedShoulderPress",
    displayName: "Seated Shoulder Press",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "shrugs",
    displayName: "Shrugs",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "squats",
    displayName: "Squats",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "sumoDeadlift",
    displayName: "Sumo Deadlift",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "tricepPushdown",
    displayName: "Tricep Pushdown",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
  ActivityType(
    id: "lyingTricepExtensions",
    displayName: "Lying Tricep Extensions",
    measurementTypes: [
      ActivityMeasurementType.reps,
      ActivityMeasurementType.pounds,
    ],
  ),
];

final Map<String, ActivityType> activityMap = {
  for (var activity in activities) activity.id: activity
};
