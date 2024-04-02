import 'package:flutter/material.dart';

class BorderTextField extends StatelessWidget {
  final double width;
  final double? height;
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  const BorderTextField(
      {super.key,
      required this.width,
      this.height,
      this.controller,
      required this.hintText,
      this.labelText,
      this.prefixIcon,
      this.sufixIcon,
      this.onChanged,
      this.onFieldSubmitted,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
