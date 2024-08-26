import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final BoxConstraints constraints;
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  const Custombutton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onPressed,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffEC2578),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: constraints.maxWidth * 0.04),
          )),
    );
  }
}
