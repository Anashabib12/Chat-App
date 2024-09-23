import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/api.dart';
import 'package:chat_app/components/message_card.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];
  final _textController = TextEditingController();
  bool _showEmoji = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height*0.09),
          child: AppBar(
            backgroundColor: Color(0xffEC2578),
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xffEC2578),
              statusBarIconBrightness: Brightness.light, // For Android
              statusBarBrightness: Brightness.dark, // For iOS
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: SizedBox());
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data?.docs;
                    _list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];
                  }
      
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            // _isSearching ? _searchList.length :
                            _list.length,
                        padding: EdgeInsets.only(top: height * 0.015),
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: _list[index],
                          );
                        });
                  } else {
                    return Center(
                        child: Text(
                      'Say Hii! 👋',
                      style: TextStyle(fontSize: 20),
                    ));
                  }
                },
              ),
            ),
            _chatInput(),
      
            //show emojis on keyboard emoji button click & vice versa
            // if (_showEmoji)
            //   SizedBox(
            //     height: height * .35,
            //     child: EmojiPicker(
            //       textEditingController: _textController,
            //       config: Config(
            //         bgColor: Color.fromARGB(255, 234, 248, 255),
            //         columns: 8,
            //         emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return InkWell(
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          ClipRRect(
            borderRadius: BorderRadius.circular(height * 0.3),
            child: CachedNetworkImage(
              height: height * 0.045,
              width: width * 0.099,
              fit: BoxFit.cover,
              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          SizedBox(
            width: width * 0.025,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.041,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Last seen not available',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: width * 0.03,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _chatInput() {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.025, vertical: height * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _showEmoji = !_showEmoji;
                  //       });
                  //     },
                  //     icon: Icon(
                  //       Icons.emoji_emotions,
                  //       color: Colors.blueAccent,
                  //       size: width * 0.08,
                  //     )),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '    Send message...',
                          hintStyle: TextStyle(color: Color(0xff646464))),
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.image,
                  //       color: Colors.blueAccent,
                  //       size: width * 0.08,
                  //     )),
                  // IconButton(
                  //     padding: EdgeInsets.only(right: 8),
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.camera_alt_rounded,
                  //       color: Colors.blueAccent,
                  //       size: width * 0.08,
                  //     ))
                ],
              ),
            ),
          ),
          SizedBox(width: width*0.02,),
          MaterialButton(
            padding: EdgeInsets.only(top: 15, bottom: 15, right: 8, left: 11),
            minWidth: 0,
            shape: CircleBorder(),
            color: Color(0xffEC2578),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text);
                _textController.text = '';
              }
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: width * 0.067,
            ),
          )
        ],
      ),
    );
  }
}
