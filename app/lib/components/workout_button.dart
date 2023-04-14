import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const WorkoutButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'workout_button',
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () => onTap(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Material(
                type: MaterialType.transparency,
                child: Theme(
                  data: Theme.of(context),
                  child: Container(
                    height: 50,
                    // width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade800.withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage(
                                "assets/flexed_biceps_3d_default.png"),
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Flexible(
                            child: Text(
                              text,
                              key: ValueKey<String>(text),
                              style: GoogleFonts.kumbhSans(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
