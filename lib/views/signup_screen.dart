import 'package:chat_app/components/clipper.dart';
import 'package:chat_app/components/customButton.dart';
import 'package:chat_app/components/customLogo.dart';
import 'package:chat_app/components/customTextfield.dart';
import 'package:chat_app/views/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.offAll(Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error!',
        e.code,
        backgroundColor: Colors.white.withOpacity(0.9), // Background color
        colorText: Colors.black, // Text color
        snackPosition: SnackPosition.TOP, // Position
        borderRadius: 8, // Border radius
        margin: const EdgeInsets.all(16), // Margin
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
        duration: const Duration(seconds: 8), // Duration
        borderColor: Colors.black.withOpacity(0.25), // Border color
        borderWidth: 1, // Border width
      );
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
        backgroundColor: const Color(0xffEC2578), // Background color
        colorText: Colors.white, // Text color
        snackPosition: SnackPosition.BOTTOM, // Position
        borderRadius: 8, // Border radius
        margin: const EdgeInsets.all(16), // Margin
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
        duration: const Duration(seconds: 3), // Duration
        borderColor: Colors.black.withOpacity(0.25), // Border color
        borderWidth: 1, // Border width
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Container(
          height:
              height, // Ensure the Stack takes the full height of the screen
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: height * 0.6,
                  color: const Color(0xffEC2578),
                ),
              ),
              Customlogo(
                  constraints:
                      BoxConstraints(maxWidth: width, maxHeight: height)),
              Positioned(
                top: height * 0.33,
                left: width * 0.12,
                child: Container(
                  height: height * 0.51,
                  width: width * 0.76,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.025),
                    border: Border.all(
                        color: const Color(0xff000000).withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.13), // Shadow color
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: const Offset(0, 8)),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Customtextfield(
                          constraints: BoxConstraints(
                              maxWidth: width, maxHeight: height),
                          filled: true,
                          color: const Color(0xffEDEDED),
                          text: 'Name',
                          suffixIcon: null,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: FaIcon(
                              FontAwesomeIcons.userLarge,
                              size: width * 0.043,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Customtextfield(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          filled: true,
                          color: const Color(0xffEDEDED),
                          constraints: BoxConstraints(
                              maxWidth: width, maxHeight: height),
                          text: 'Email',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: FaIcon(
                              FontAwesomeIcons.solidEnvelope,
                              size: width * 0.043,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Customtextfield(
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          filled: true,
                          color: const Color(0xffEDEDED),
                          constraints: BoxConstraints(
                              maxWidth: width, maxHeight: height),
                          text: 'Password',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: FaIcon(
                              FontAwesomeIcons.solidEye,
                              size: width * 0.04,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: FaIcon(
                              FontAwesomeIcons.lock,
                              size: width * 0.043,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.011,
                        ),
                        SizedBox(
                          height: height * 0.028,
                        ),
                        Custombutton(
                            width: width * 0.66,
                            height: height * 0.051,
                            text: 'Create Account',
                            onPressed: () {
                              signup();
                            },
                            constraints: BoxConstraints(
                                maxWidth: width, maxHeight: height)),
                        SizedBox(
                          height: height * 0.013,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: height * 0.87,
                  left: width * 0.3,
                  child: Column(
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.038),
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: const Color(0xffEC2578),
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.05),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
