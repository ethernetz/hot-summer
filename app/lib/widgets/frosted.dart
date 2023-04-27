import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Frosted extends StatelessWidget {
  final Widget child;

  const Frosted({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: child,
      ),
    );
  }
}
