import 'package:chat_app/api/api.dart';
import 'package:chat_app/components/chatUserCard.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';

class ChatlistScreen extends StatefulWidget {
  const ChatlistScreen({super.key});

  @override
  State<ChatlistScreen> createState() => _ChatlistScreenState();
}

class _ChatlistScreenState extends State<ChatlistScreen> {
  List<ChatUser> _list = [];
  List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Calling getselfinfo function
    APIs.getSelfInfo();
  }

  Future<void> logout() async {
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate back to login screen or any other desired screen
      Navigator.push(
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
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.077),
            child: AppBar(
              backgroundColor: Color(0xffEC2578),
              leading: Icon(Iconsax.home, color: Colors.white,),
              titleSpacing: 0,
              title: Text(
                'WeChat',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.07),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  user: APIs.me,
                                )));
                  },
                  icon: Icon(Icons.more_vert),
                  color: Colors.white,
                )
              ],
            ),
          ),
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(
          //     right: 10,
          //     bottom: 40,
          //   ),
          //   child: FloatingActionButton(
          //     backgroundColor: Color(0xffEC2578),
          //     onPressed: () async {
          //       await logout();
          //     },
          //     child: Icon(Icons.add_comment_rounded, color: Colors.white),
          //   ),
          // ),
          body: Column(
            children: [
              // Search Field
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.03,
                    right: width * 0.03),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Search Name or Email...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
                  ),
                  onChanged: (value) {
                    // Search logic
                    _searchList.clear();
                    if (value.isNotEmpty) {
                      for (var i in _list) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.emai
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                        }
                      }
                    }
                    setState(() {
                      _isSearching = value.isNotEmpty;
                    });
                  },
                ),
              ),
              // Chat List
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllUsers(),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      _list = data
                              ?.map((e) => ChatUser.fromJson(e.data()))
                              .toList() ??
                          [];
                    }

                    // Display filtered search results or all results
                    final displayList = _isSearching ? _searchList : _list;

                    if (displayList.isNotEmpty) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: displayList.length,
                        padding: EdgeInsets.only(top: height * 0.015),
                        itemBuilder: (context, index) {
                          return Chatusercard(
                            user: displayList[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          _isSearching
                              ? 'No user found'
                              : 'No connection found',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
