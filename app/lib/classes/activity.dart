import 'package:flutter/material.dart';

class Activity {
  final UniqueKey uniqueKey;
  final TextEditingController weightController;
  final TextEditingController repsController;

  Activity({required this.uniqueKey})
      : weightController = TextEditingController(),
        repsController = TextEditingController();
}
