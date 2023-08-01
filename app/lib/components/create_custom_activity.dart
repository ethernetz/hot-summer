import 'package:flutter/cupertino.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/widgets/cupertino_choice_chip.dart';
import 'package:uuid/uuid.dart';

const List<List<ActivityMeasurementType>> commonMeasurementTypeCombinations = [
  [ActivityMeasurementType.reps, ActivityMeasurementType.pounds],
  [ActivityMeasurementType.time, ActivityMeasurementType.miles],
];

class CreateCustomActivity extends StatefulWidget {
  const CreateCustomActivity({Key? key}) : super(key: key);

  @override
  State<CreateCustomActivity> createState() => _CreateCustomActivityState();
}

class _CreateCustomActivityState extends State<CreateCustomActivity> {
  final TextEditingController _activityNameController = TextEditingController();
  final Map<int, bool> commonMeasurementTypeMap = {
    for (int i = 0; i < commonMeasurementTypeCombinations.length; i++)
      i: i == 0,
  };
  bool showMoreOptions = false;
  final Map<String, bool> measurementTypeSelectionMap = {
    for (int i = 0; i < ActivityMeasurementType.values.length; i++)
      ActivityMeasurementType.values[i].id:
          ActivityMeasurementType.values[i].id ==
                  ActivityMeasurementType.reps.id ||
              ActivityMeasurementType.values[i].id ==
                  ActivityMeasurementType.pounds.id,
  };
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Text(
                    'Name your activity',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CupertinoTextField(
                    controller: _activityNameController,
                    placeholder: 'eg. Bench Press',
                    placeholderStyle: TextStyle(
                      color: CupertinoColors.black.withOpacity(0.9),
                    ),
                    style: const TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 20.0,
                    ),
                    cursorColor: CupertinoColors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'How should we measure it?',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0, // gap between adjacent chips
                      runSpacing: 10.0, // gap between lines
                      children: showMoreOptions
                          ? measurementTypeSelectionMap.entries
                              .map((entry) => CupertinoChoiceChip(
                                    label: ActivityMeasurementType
                                        .map[entry.key]!.displayName
                                        .toLowerCase(),
                                    isSelected: entry.value,
                                    onSelected: (selected) {
                                      setState(() {
                                        measurementTypeSelectionMap[entry.key] =
                                            selected;
                                      });
                                    },
                                  ))
                              .toList()
                          : commonMeasurementTypeMap.entries
                              .map((entry) => CupertinoChoiceChip(
                                    label: commonMeasurementTypeCombinations[
                                            entry.key]
                                        .map((e) => e.displayName)
                                        .join(' x ')
                                        .toLowerCase(),
                                    isSelected: entry.value,
                                    onSelected: (selected) {
                                      setState(() {
                                        commonMeasurementTypeMap
                                            .forEach((key, value) {
                                          commonMeasurementTypeMap[key] =
                                              key == entry.key;
                                        });
                                        measurementTypeSelectionMap
                                            .forEach((key, value) {
                                          measurementTypeSelectionMap[key] =
                                              commonMeasurementTypeCombinations[
                                                      entry.key]
                                                  .any((e) => e.id == key);
                                        });
                                      });
                                    },
                                  ))
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMoreOptions = !showMoreOptions;
                      });
                    },
                    child: Text(
                      showMoreOptions
                          ? 'show less options'
                          : 'show more options',
                      style: TextStyle(
                        color: CupertinoColors.white.withOpacity(0.9),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  CupertinoButton.filled(
                    onPressed: _activityNameController.text.isNotEmpty
                        ? () {
                            final measurementTypes = !showMoreOptions
                                ? commonMeasurementTypeCombinations[
                                    commonMeasurementTypeMap.entries
                                        .firstWhere((entry) => entry.value)
                                        .key]
                                : measurementTypeSelectionMap.entries
                                    .where((entry) => entry.value)
                                    .map((entry) =>
                                        ActivityMeasurementType.map[entry.key]!)
                                    .toList();

                            Navigator.pop<ActivityType>(
                              context,
                              ActivityType(
                                id: const Uuid().v4(),
                                displayName: _activityNameController.text,
                                measurementTypes: measurementTypes,
                              ),
                            );
                          }
                        : null,
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
