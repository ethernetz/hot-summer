import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Row(
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
        const SizedBox(width: 16),
        Column(
          children: [
            Row(
              children: [
                Text(
                  hotuser.daysRemaining?.toString() ?? '?',
                  style: GoogleFonts.kumbhSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
                const Image(
                  image: AssetImage("assets/calendar_3d.png"),
                  height: 40,
                  width: 40,
                ),
              ],
            ),
            Text(
              'Days remaining',
              style: GoogleFonts.kumbhSans(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            Row(
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
      ],
    );
  }
}
