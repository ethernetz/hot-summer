import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspaces/classes/activity.dart';
import 'package:workspaces/widgets/number_field.dart';

class ActivityCard extends StatelessWidget {
  final void Function() onClosePressed;
  final Activity activity;
  const ActivityCard({
    required this.onClosePressed,
    required this.activity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(activity.toString()),
                  ),
                  const TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text('---'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: NumberField(
                      controller: activity.weightController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: NumberField(
                      controller: activity.repsController,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
