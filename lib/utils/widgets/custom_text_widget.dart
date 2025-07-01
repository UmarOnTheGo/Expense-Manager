import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required TextEditingController controller,
    this.textInputType = TextInputType.text,
  }) : _controller = controller;

  final TextEditingController _controller;
  final TextInputType textInputType;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        controller: _controller,
        keyboardType: textInputType,
        inputFormatters: textInputType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
      ),
    );
  }
}
