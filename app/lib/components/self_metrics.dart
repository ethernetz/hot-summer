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
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotuser.streak.toString(),
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Image(
                        image: AssetImage("assets/fire_3d.png"),
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                  Text(
                    'Streak',
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotuser.streak.toString(),
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Image(
                        image: AssetImage("assets/star_3d.png"),
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                  Text(
                    'Stars',
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotuser.medals.toString(),
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Image(
                        image: AssetImage("assets/1st_place_medal_3d.png"),
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                  Text(
                    'Medals',
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
