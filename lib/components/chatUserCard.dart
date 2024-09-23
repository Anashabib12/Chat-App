import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/api.dart';
import 'package:chat_app/helper/my_date.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:flutter/material.dart';

class Chatusercard extends StatefulWidget {
  final ChatUser user;
  const Chatusercard({super.key, required this.user});

  @override
  State<Chatusercard> createState() => _ChatusercardState();
}

class _ChatusercardState extends State<Chatusercard> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                user: widget.user,
              ),
            ),
          );
        },
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) _message = list[0];
            return Container(
              // Increase the height of the container
              height: height * 0.12, // Adjust height as needed
              // decoration: BoxDecoration(color: Colors.amberAccent),
              child: Row(
                children: [
                  // Profile picture
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.032),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(height * 0.05),
                      child: CachedNetworkImage(
                        height:
                            height * 0.07, // Adjust the profile picture size
                        width: height *
                            0.07, // Use height for both dimensions for a square shape
                        fit: BoxFit.cover,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) =>
                            CircleAvatar(child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  // Name, last message, and trailing widget
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.user.name,
                          style: TextStyle(fontSize: width * 0.049, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                            height:
                                5), // Add some space between name and subtitle
                        Text(
                          _message != null ? _message!.msg : widget.user.about,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: width * 0.034,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_message != null)
                    _message!.read.isEmpty && _message!.fromId != APIs.user.uid
                        ? Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                        : Text(
                            MyDate.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: width * 0.03, fontWeight: FontWeight.w600),
                          ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
