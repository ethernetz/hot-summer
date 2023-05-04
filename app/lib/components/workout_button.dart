import 'package:flutter/material.dart';

class HeroWorkoutButton extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const HeroWorkoutButton({
    super.key,
    required this.child,
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
        final fromWidget = fromHeroContext
            .findAncestorWidgetOfExactType<HeroWorkoutButton>()!
            .child;
        final toWidget = toHeroContext
            .findAncestorWidgetOfExactType<HeroWorkoutButton>()!
            .child;

        final ValueNotifier<Widget> textNotifier = ValueNotifier(fromWidget);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          textNotifier.value = toWidget;
        });

        return WorkoutButton(
          onTap: onTap,
          child: child,
        );
      },
      child: WorkoutButton(onTap: onTap, child: child),
    );
  }
}

class WorkoutButton extends StatelessWidget {
  const WorkoutButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  final Function onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: Theme.of(context),
          child: IntrinsicWidth(
            child: Container(
              height: 60,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
