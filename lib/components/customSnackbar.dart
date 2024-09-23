import 'package:flutter/material.dart';

class Customsnackbar extends StatelessWidget {
  final String text;
  const Customsnackbar({super.key, required this.text});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            Color(0xffEC2578), // You can customize the appearance here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox
        .shrink(); // Return an empty widget since this widget's purpose is to display a SnackBar
  }
}
