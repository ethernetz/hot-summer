import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  const NumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () => controller.selection = TextSelection(
          baseOffset: 0, extentOffset: controller.value.text.length),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      maxLength: 4,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[700]!,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[700]!,
            width: 2,
          ),
        ),
      ),
    );
  }
}
