import 'package:chat_app_final/Services/SharedPreferenceHelper.dart';
import 'package:flutter/material.dart';

class Conversations extends StatefulWidget {
  String username, name, imgUrl;
  Conversations(this.username, this.name, this.imgUrl);
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  String chatRoomId, messageId;
  String myName, myProfilePic, myUsername, myEmail;
  TextEditingController _textEditingController = TextEditingController();

  getMyInfowithSharedPreference() async {
    // current user's info with sharedpreference

    myName = await SharedPreferenceHelper.displayNameKey;
    myProfilePic = await SharedPreferenceHelper.userProfilePicKey;
    myUsername = await SharedPreferenceHelper.userNameKey;
    myEmail = await SharedPreferenceHelper.userEmailKey;

    chatRoomId = getChatRoomId(widget.username, myUsername);
  }

  //init state threw exception when trying to async, so used another async method
  loadOnLaunchforInitState() async {
    await getMyInfowithSharedPreference();
    getandSetMessage();
  }

  @override
  void initState() {
    loadOnLaunchforInitState();
    super.initState();
  }

  //chatroomıd can be a_b or b_a but it doesn't matter

  getChatRoomId(String a, String b) {
    if (int.parse(a) > int.parse(b)) {
      return "$b'_'$a";
    } else {
      return "$a'_'$b";
    }
  }

  getandSetMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.imgUrl,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(widget.name),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.indigo,
                        child: Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          Expanded(
                              child: TextField(
                            controller: _textEditingController,
                            style: TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "write a message",
                                hintStyle: TextStyle(color: Colors.white70)),
                          )),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
