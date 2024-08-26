import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatlistScreen extends StatefulWidget {
  const ChatlistScreen({super.key});

  @override
  State<ChatlistScreen> createState() => _ChatlistScreenState();
}

class _ChatlistScreenState extends State<ChatlistScreen> {
  logout()async{
    await FirebaseAuth.instance.signOut();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat List'),),
      body: FloatingActionButton(onPressed: (){
        logout();
      }),
    );
  }
}