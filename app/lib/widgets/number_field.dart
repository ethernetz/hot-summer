import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const NumberField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onTap: () => controller.selection = TextSelection(
          baseOffset: 0, extentOffset: controller.value.text.length),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      maxLength: 3,
      style: DefaultTextStyle.of(context).style,
      decoration: const InputDecoration(
        counterText: "",
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC32B9C),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC32B9C),
          ),
        ),
      ),
    );
  }
}
