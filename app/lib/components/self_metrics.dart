import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/widgets/progress_bar.dart';

class SelfMetrics extends StatelessWidget {
  const SelfMetrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var hotuser = context.watch<HotUser?>();
    if (hotuser == null) {
      return const SizedBox();
    }
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotuser.streak.toString(),
                        style: GoogleFonts.kumbhSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                      const Image(
                        image: AssetImage("assets/fire_3d.png"),
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                  Text(
                    'Streak',
                    style: GoogleFonts.kumbhSans(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotuser.medals.toString(),
                        style: GoogleFonts.kumbhSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                      const Image(
                        image: AssetImage("assets/1st_place_medal_3d.png"),
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                  Text(
                    'Medals',
                    style: GoogleFonts.kumbhSans(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            const SizedBox(
              width: 275,
              child: ProgressBar(
                currentValue: 2,
                maxValue: 3,
              ),
            ),
            Text(
              'Sessions left this week',
              style: GoogleFonts.kumbhSans(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        )
      ],
    );
  }
}
