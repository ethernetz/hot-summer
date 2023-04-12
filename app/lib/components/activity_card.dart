import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/current_activity.dart';
import 'package:workspaces/widgets/number_field.dart';

class ActivityCard extends StatelessWidget {
  final void Function() onClosePressed;
  const ActivityCard({
    required this.onClosePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<CurrentActivity>();
    return KeyboardActions(
      autoScroll: false,
      config: _buildKeyboardActionsConfig(activity),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    activity.activityType.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClosePressed,
                ),
              ],
            ),
            DefaultTextStyle(
              style: GoogleFonts.kumbhSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(40),
                  1: IntrinsicColumnWidth(flex: 2),
                  2: IntrinsicColumnWidth(flex: 1),
                  3: IntrinsicColumnWidth(flex: 1),
                },
                children: [
                  const TableRow(
                    children: [
                      Text('Set'),
                      Text('Previous'),
                      Text('lbs'),
                      Text('Reps'),
                    ],
                  ),
                  for (int i = 0; i < activity.sets.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            (i + 1).toString(),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: (() {
                            final previousActivitySets =
                                activity.previousActivity?.sets;
                            if (previousActivitySets == null ||
                                previousActivitySets.length <= i) {
                              return Container();
                            }
                            return Text(
                              '${previousActivitySets[i].weight}lb x ${previousActivitySets[i].reps}',
                              style: const TextStyle(
                                color: Colors.white60,
                              ),
                            );
                          }()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: NumberField(
                            controller: activity.sets[i].weightController,
                            focusNode: activity.sets[i].weightFocusNode,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: NumberField(
                            controller: activity.sets[i].repsController,
                            focusNode: activity.sets[i].repsFocusNode,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 125,
                child: GestureDetector(
                  onTap: () => activity.addSet(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        "Add set",
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(CurrentActivity activity) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[900],
      nextFocus: true,
      actions: [
        for (var set in activity.sets) ...[
          KeyboardActionsItem(
            focusNode: set.weightFocusNode,
          ),
          KeyboardActionsItem(
            focusNode: set.repsFocusNode,
          )
        ],
      ],
    );
  }
}
