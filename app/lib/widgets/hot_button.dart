// create custom button based on stateful widget
import 'package:flutter/material.dart';

class HotButton extends StatefulWidget {
  final Widget child;
  final void Function()? onPressed;

  const HotButton({super.key, required this.child, this.onPressed});

  @override
  State<HotButton> createState() => _HotButtonState();
}

class _HotButtonState extends State<HotButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    reverseDuration: const Duration(milliseconds: 100),
    value: 1.0,
    upperBound: 1.0,
    lowerBound: 0.8,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutQuad,
  );

  @override
  void initState() {
    super.initState();

    _animation;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.reverse().then((_) {
      _controller.forward();
    });
  }

  void _onTapUp(TapUpDetails details) {
    widget.onPressed?.call();
    _controller.forward();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTapCancel: _onTapCancel,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffED6F00),
                Color(0xffAF0BE6),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
