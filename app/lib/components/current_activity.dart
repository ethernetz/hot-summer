import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/current_activity_provider.dart';

class CurrentActivity extends StatefulWidget {
  final void Function() onClosePressed;
  const CurrentActivity({
    required this.onClosePressed,
    super.key,
  });

  @override
  State<CurrentActivity> createState() => _CurrentActivityState();
}

class _CurrentActivityState extends State<CurrentActivity> {
  GlobalKey<AnimatedListState> setsListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    setsListKey = GlobalKey<AnimatedListState>();
    context.read<CurrentActivityProvider>().setSetsListKey(setsListKey);
  }

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<CurrentActivityProvider>();
    return KeyboardActions(
      autoScroll: false,
      config: _buildKeyboardActionsConfig(activity),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  onPressed: widget.onClosePressed,
                  color: Colors.white,
                ),
              ],
            ),
            DefaultTextStyle(
              style: GoogleFonts.kumbhSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        "Set",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Previous",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        for (var measurementType
                            in activity.activityType.measurementTypes)
                          Expanded(
                            child: Center(
                              child: Text(
                                measurementType.displayName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.kumbhSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
              child: AnimatedList(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                key: setsListKey,
                initialItemCount: activity.sets.length,
                itemBuilder: (context, index, animation) {
                  return activity.buildCurrentSetWithAnimation(
                      index, animation);
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
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

  KeyboardActionsConfig _buildKeyboardActionsConfig(
      CurrentActivityProvider activity) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[900],
      nextFocus: true,
      actions: [
        for (var set in activity.sets) ...[
          for (var focusNode in set.focusNodes.entries)
            KeyboardActionsItem(
              focusNode: focusNode.value,
            ),
        ],
      ],
    );
  }
}
