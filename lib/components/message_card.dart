import 'package:chat_app/api/api.dart';
import 'package:chat_app/helper/my_date.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _pinkMessage()
        : _greyMessage();
  }

  //sender or another user message
  Widget _greyMessage() {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: Color(0xffEDEDED),
                border: Border.all(color: Colors.grey, width: 0.6),
                //making borders curved
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                    bottomRight: Radius.circular(26))),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: width * .03),
          child: Text(
            MyDate.getFormattedTime(
                context: context, time: widget.message.sent),
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        )
      ],
    );
  }

  //our or user message
  Widget _pinkMessage() {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.025,
            ),
            if (widget.message.read.isNotEmpty)
              // Icon(
              //   Icons.done_all_rounded,
              //   size: 20,
              // ),
            SizedBox(
              width: width * 0.005,
            ),
            Text(
              MyDate.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: Color(0xffEC2578),
                border: Border.all(color: Color(0xffEC2578), width: 0.6),
                //making borders curved
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                    bottomLeft: Radius.circular(26))),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
