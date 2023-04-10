import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspaces/classes/activity_type.dart';

class SelectActivity extends StatelessWidget {
  const SelectActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Text(
            'Select Activity',
            style: GoogleFonts.kumbhSans(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: ActivityType.values.length,
                itemBuilder: (BuildContext context, int index) {
                  var value = ActivityType.values[index];
                  return ListTile(
                    title: Text(
                      value.displayName,
                      style: GoogleFonts.kumbhSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, value);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
