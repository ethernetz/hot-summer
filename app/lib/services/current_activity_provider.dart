import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';
import 'package:workspaces/components/current_set.dart';
import 'package:workspaces/services/current_set_provider.dart';

class CurrentActivityProvider extends ChangeNotifier {
  final UniqueKey uniqueKey;
  final ActivityType activityType;
  final Activity? previousActivity;
  final List<CurrentSetProvider> sets;

  GlobalKey<AnimatedListState>? _setsListKey;

  CurrentActivityProvider({
    required this.uniqueKey,
    required this.activityType,
    this.previousActivity,
  }) : sets = previousActivity?.sets
                .map(
                  (previousSet) => CurrentSetProvider.fromPreviousSet(
                    activityType.measurementTypes,
                    previousSet,
                  ),
                )
                .toList() ??
            [CurrentSetProvider.empty(activityType.measurementTypes)];

  void addSet() {
    sets.add(CurrentSetProvider.empty(activityType.measurementTypes));
    _setsListKey?.currentState?.insertItem(
      sets.length - 1,
      duration: const Duration(milliseconds: 100),
    );
    notifyListeners();
  }

  void setSetsListKey(GlobalKey<AnimatedListState> setsListKey) {
    _setsListKey = setsListKey;
  }

  Widget buildCurrentSetWithAnimation(int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: _getCurvedAnimation(animation),
      child: _buildCurrentSet(index),
    );
  }

  Widget _buildCurrentSet(int index) {
    final set = sets[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ChangeNotifierProvider<CurrentSetProvider>.value(
        value: set,
        child: CurrentSet(
          index: index,
        ),
      ),
    );
  }

  CurvedAnimation _getCurvedAnimation(Animation<double> animation) {
    return CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );
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
