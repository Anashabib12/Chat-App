// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'dart:io';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/components/clipper.dart';
import 'package:chat_app/components/customButton.dart';
import 'package:chat_app/components/customLogo.dart';
import 'package:chat_app/components/customTextfield.dart';
import 'package:chat_app/views/chatlist_screen.dart';
import 'package:chat_app/views/forgotPass_screen.dart';
import 'package:chat_app/views/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
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
    }
    setState(() {
      isLoading = false;
    });
  }

  _handleGoogleBtnClick() async {
    setState(() {
      isLoading = true;
    });

    await _signInWithGoogle().then((user) async {
      if (user != null) {
        print("\nUser: ${user.user}");
        print('\nUser: ${user.additionalUserInfo}');
        if ((await APIs.isUserExist())) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatlistScreen()));
        } else {
          await APIs.createUser().then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatlistScreen())));
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('\n_signInWithGoogle: $e');
      Get.snackbar(
        'Error!',
        e.toString(),
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                        height: height * 0.52,
                        width: width * 0.76,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(height * 0.025),
                          border: Border.all(
                              color: const Color(0xff000000).withOpacity(0.25)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.13), // Shadow color
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: width * 0.06,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Customtextfield(
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    final emailRegex =
                                        RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  text: 'Email',
                                  suffixIcon: null,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: FaIcon(
                                      FontAwesomeIcons.userLarge,
                                      size: width * 0.043,
                                    ),
                                  ),
                                  Width: width * 0.66,
                                  contentPadding: EdgeInsets.all(13),
                                ),
                                SizedBox(
                                  height: height * 0.025,
                                ),
                                Customtextfield(
                                  Width: width * 0.66,
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
                                  contentPadding: EdgeInsets.all(13),
                                ),
                                SizedBox(
                                  height: height * 0.011,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: width * 0.047),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ForgotPasswordScreen()));
                                          },
                                          child: Text('Forget Password?'))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Stack(
                                  children: [
                                    Custombutton(
                                        width: width * 0.66,
                                        height: height * 0.051,
                                        text: 'Login',
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            login();
                                          }
                                        },
                                        constraints: BoxConstraints(
                                            maxWidth: width,
                                            maxHeight: height)),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.013,
                                ),
                                const Text(
                                  'Or',
                                  style: TextStyle(color: Color(0xffEC2578)),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(7, 0),
                                      child: InkWell(
                                        onTap: () {
                                          _handleGoogleBtnClick();
                                        },
                                        child: Image.asset(
                                          'assets/logo/google.png',
                                          height: height * 0.05,
                                          width: width * 0.15,
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(-6, 0),
                                      child: Image.asset(
                                        'assets/logo/fb.png',
                                        height: height * 0.035,
                                        width: width * 0.15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                              'Don’t have an account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.038),
                            ),
                            SizedBox(
                              height: height * 0.007,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()));
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: const Color(0xffEC2578),
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.05),
                              ),
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
