import 'package:chat_app_final/Services/DatabaseMethods.dart';
import 'package:chat_app_final/Services/SharedPreferenceHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Conversations extends StatefulWidget {
  String username, name, imgUrl;
  Conversations(this.username, this.name, this.imgUrl);
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  String chatRoomId, messageId = "";
  String myName, myProfilePic, myUsername, myEmail;
  TextEditingController _textEditingController = TextEditingController();

  getMyInfowithSharedPreference() async {
    // current user's info with sharedpreference

    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUsername = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomId(myUsername, widget.username);
  }

  //init state threw exception when trying to async, so used another async method
  loadOnLaunchforInitState() async {
    await getMyInfowithSharedPreference();
    // getandSetMessage();
  }

  @override
  void initState() {
    loadOnLaunchforInitState();
    super.initState();
  }

  //chatroomıd can be a_b or b_a but it doesn't matter

  getChatRoomId(String a, String b) {
    if (a.substring(1, 8).codeUnitAt(6) > b.substring(1, 8).codeUnitAt(6)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool isSendClicked) {
    if (_textEditingController.text != "") {
      String message = _textEditingController.text;
      var lastMessageSend = DateTime.now();

      Map<String, dynamic> messageInfo = {
        "message": message,
        "whoSend": myUsername,
        "time": lastMessageSend,
      };
      if (messageId == "") {
        messageId = randomAlphaNumeric(7);
      }
      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfo)
          .then((value) {
        Map<String, dynamic> lastMessageInfo = {
          "lastMessage": message,
          "lastMessageTime": lastMessageSend,
          "lastMessageSendWho": myUsername,
        };
        DatabaseMethods().updateLastMessage(chatRoomId, lastMessageInfo);

        if (isSendClicked) {
          //clear message
          _textEditingController.text = "";

          messageId = "";
        }
      });
    }
  }

  Widget chatsTileUI(String message, bool isSendByMe) {
    return Row(
      mainAxisAlignment:
          isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isSendByMe ? Colors.indigo : Colors.grey,
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget chats() {
    return FutureBuilder(
      future: DatabaseMethods().getMessagesFromChatromm(chatRoomId),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: 15, bottom: 70),
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return chatsTileUI(
                      ds["message"], myUsername == ds["whoSend"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*getandSetMessage() async {
    await DatabaseMethods().getMessagesFromChatromm(chatRoomId);
  }*/

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
              chats(),
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
                            onChanged: (value) {
                              addMessage(false);
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "write a message",
                                hintStyle: TextStyle(color: Colors.white70)),
                          )),
                          GestureDetector(
                            onTap: addMessage(true),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
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
