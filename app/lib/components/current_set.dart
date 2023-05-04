import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/current_activity_provider.dart';
import 'package:workspaces/widgets/number_field.dart';

class CurrentSet extends StatelessWidget {
  const CurrentSet({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final set = context.watch<CurrentSetProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                "${index + 1}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (() {
                final previousSet = set.previousSet;
                if (previousSet == null) return Container();
                return Text(
                  previousSet.displayMeasurements,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                );
              }()),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                for (var measurementType in set.activityMeasurementTypes)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: NumberField(
                        focusNode: set.focusNodes[measurementType]!,
                        controller:
                            set.textEditingControllers[measurementType]!,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
