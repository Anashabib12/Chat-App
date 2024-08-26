import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80); // Start from the bottom left corner

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 80);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0); // Move to the top right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
