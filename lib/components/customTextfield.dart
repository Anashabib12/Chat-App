import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final double Width;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final Color? color;
  final String text;
  final bool? filled;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final EdgeInsetsGeometry contentPadding;
  final String? initialValue;
  const Customtextfield({
    super.key,
    this.color,
    required this.text,
    this.filled,
    this.suffixIcon,
    required this.prefixIcon,
    this.validator,
    this.controller,
    required this.Width,
    required this.contentPadding,
    this.initialValue,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    // final double height = screenSize.height;

    return SizedBox(
        width: Width,
        child: TextFormField(
          onSaved: onSaved,
          initialValue: initialValue,
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
            contentPadding: contentPadding,
          ),
        ));
  }
}
