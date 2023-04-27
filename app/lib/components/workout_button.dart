import 'package:flutter/material.dart';

class HeroWorkoutButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const HeroWorkoutButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'workout_button',
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final fromText = fromHeroContext
            .findAncestorWidgetOfExactType<HeroWorkoutButton>()!
            .text;
        final toText = toHeroContext
            .findAncestorWidgetOfExactType<HeroWorkoutButton>()!
            .text;

        final ValueNotifier<String> textNotifier = ValueNotifier(fromText);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          textNotifier.value = toText;
        });

        return WorkoutButton(
          onTap: onTap,
          textWidget: ValueListenableBuilder(
            valueListenable: textNotifier,
            builder: (_, text, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutCubic,
                child: Text(
                  text.split('').join('\u200B'),
                  key: ValueKey<String>(text),
                  style: Theme.of(context).textTheme.displayMedium,
                  maxLines: 1,
                ),
              );
            },
          ),
        );
      },
      child: WorkoutButton(
        onTap: onTap,
        textWidget: Text(
          text,
          key: ValueKey<String>(text),
          style: Theme.of(context).textTheme.displayMedium,
          maxLines: 1,
        ),
      ),
    );
  }
}

class WorkoutButton extends StatelessWidget {
  const WorkoutButton({
    super.key,
    required this.onTap,
    required this.textWidget,
  });

  final Function onTap;
  final Widget textWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: Theme.of(context),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xffFF00CD),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffFF00CD).withOpacity(0.8),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Image(
                  //   image: AssetImage("assets/flexed_biceps_3d_default.png"),
                  //   height: 30,
                  //   width: 30,
                  // ),
                  // const SizedBox(
                  //   width: 6,
                  // ),
                  Flexible(
                    child: textWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
