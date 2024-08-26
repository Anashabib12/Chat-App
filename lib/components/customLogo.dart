import 'package:flutter/material.dart';

class Customlogo extends StatelessWidget {
  final BoxConstraints constraints;
  const Customlogo({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;
    return Positioned(
      top: height * 0.1,
      left: width * 0.267,
      child: Column(
        children: [
          Image.asset('assets/logo/logo2.png'),
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            'Deliver Favourite Food',
            style: TextStyle(
                fontSize: width * 0.045,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
