import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final int? initialValue;
  const NumberInput({super.key, this.initialValue});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: () => _controller.selection = TextSelection(
          baseOffset: 0, extentOffset: _controller.value.text.length),
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
