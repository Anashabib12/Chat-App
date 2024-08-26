import 'package:flutter/material.dart';

class Ontext1 extends StatelessWidget {
  final BoxConstraints constraints;
  final String text;
  const Ontext1({super.key, required this.text, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: constraints.maxWidth * 0.064, fontWeight: FontWeight.w700),
    );
  }
}
