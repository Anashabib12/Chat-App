import 'package:flutter/material.dart';

class Ontext2 extends StatelessWidget {
  final BoxConstraints constraints;
  final String text;
  const Ontext2({super.key, required this.text, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: constraints.maxWidth * 0.031,
          color: const Color(0xff646464)),
    );
  }
}
