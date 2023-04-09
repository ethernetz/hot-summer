import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/activity.dart';
import 'package:workspaces/widgets/button.dart';
import 'package:workspaces/widgets/number_field.dart';

class ActivityCard extends StatelessWidget {
  final void Function() onClosePressed;
  const ActivityCard({
    required this.onClosePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<Activity>();
    return Container(
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
              Text(
                "Arnold Press",
                style: GoogleFonts.kumbhSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
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
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(75),
                1: IntrinsicColumnWidth(flex: 1),
                2: FixedColumnWidth(75),
                3: FixedColumnWidth(75),
              },
              children: [
                const TableRow(
                  children: [
                    Text(
                      'Set',
                    ),
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
                        child: Text((i + 1).toString()),
                      ),
                      const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text('---'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: NumberField(
                          controller: activity.sets[i].weightController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: NumberField(
                          controller: activity.sets[i].repsController,
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
              child: Button(
                onPressed: () => activity.addSet(),
                color: const Color(0xFFC32B9C),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      "Add set",
                      style: GoogleFonts.kumbhSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
