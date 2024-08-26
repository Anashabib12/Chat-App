import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final BoxConstraints constraints;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final Color? color;
  final String text;
  final bool? filled;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  const Customtextfield(
      {super.key,
      required this.constraints,
      this.color,
      required this.text,
      this.filled,
      this.suffixIcon,
      required this.prefixIcon, this.validator, this.controller,});

  @override
  Widget build(BuildContext context) {
    final double width = constraints.maxWidth;
    // final double height = constraints.maxHeight;
    return SizedBox(
      width: width * 0.66,
      child: TextFormField(
        controller: controller,
        validator: validator,
          decoration: InputDecoration(
        filled: filled,
        fillColor: color,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: text,
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
            borderSide: const BorderSide(color: Color(0xffEDEDED))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
            borderSide: const BorderSide(color: Color(0xffEDEDED))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
            borderSide: const BorderSide(color: Color(0xffEDEDED))),
            contentPadding: EdgeInsets.all(13)
      ),
      ),
    );
  }
}
