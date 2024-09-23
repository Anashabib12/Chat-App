import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/api.dart';
import 'package:chat_app/components/customSnackbar.dart';
import 'package:chat_app/components/customTextfield.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  void _showBottomSheet(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.05),
          children: [
            Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.045, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        fixedSize: Size(width * 0.3, height * 0.15)),
                    onPressed: () async {
                      //pick from gallery
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        print('imagePAth: ${image.path}');
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset('assets/images/add_image.png')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        fixedSize: Size(width * 0.3, height * 0.15)),
                    onPressed: () async {
                      //pick from gallery
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        print('imagePAth: ${image.path}');
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset('assets/images/camera.png'))
              ],
            )
          ],
        );
      },
    );
  }

  bool isLoading = false;
  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate back to login screen or any other desired screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      // Handle errors if sign out fails
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign out failed: $e'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Color(0xffEC2578),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  title: const Text(
                    'Profile Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              _image != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.2),
                                      child: Image.file(
                                        File(_image!),
                                        height: height * 0.25,
                                        width: width * 0.5,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(height * 0.2),
                                      child: CachedNetworkImage(
                                        height: height * 0.25,
                                        width: width * 0.5,
                                        fit: BoxFit.cover,
                                        imageUrl: widget.user.image,
                                        // placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                                child: Icon(Icons.person)),
                                      ),
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: MaterialButton(
                                  elevation: 1,
                                  color: Colors.white,
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.purple,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          widget.user.emai,
                          style: TextStyle(
                              fontSize: width * 0.043, color: Colors.black54),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Customtextfield(
                            onSaved: (val) => APIs.me.name = val ?? '',
                            initialValue: widget.user.name,
                            validator: (val) => val != null && val.isNotEmpty
                                ? null
                                : 'Required Field',
                            filled: true,
                            color: Color(0xffEDEDED),
                            text: 'Name ...',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: FaIcon(
                                FontAwesomeIcons.userLarge,
                                size: width * 0.048,
                              ),
                            ),
                            Width: width * 0.85,
                            contentPadding: EdgeInsets.all(17)),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Customtextfield(
                            onSaved: (val) => APIs.me.about = val ?? '',
                            initialValue: widget.user.about,
                            validator: (val) => val != null && val.isNotEmpty
                                ? null
                                : 'Required Field',
                            filled: true,
                            color: Color(0xffEDEDED),
                            text: 'About ...',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: FaIcon(
                                FontAwesomeIcons.circleInfo,
                                size: width * 0.05,
                              ),
                            ),
                            Width: width * 0.85,
                            contentPadding: EdgeInsets.all(17)),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          width: width * 0.3,
                          height: height * 0.05,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  APIs.updateUserInfo().then((value) {
                                    Customsnackbar(
                                            text:
                                                'Profile Updated Successfully!')
                                        .showCustomSnackbar(context);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffEC2578),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.05),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton.extended(
                              backgroundColor: Color(0xffEC2578),
                              onPressed: () async {
                                await logout();
                              },
                              icon: Icon(Icons.logout_rounded,
                                  color: Colors.white),
                              label: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
