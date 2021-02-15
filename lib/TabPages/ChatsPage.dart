import 'package:chat_app_final/Pages/Conversations.dart';
import 'package:chat_app_final/Services/DatabaseMethods.dart';
import 'package:chat_app_final/Services/SharedPreferenceHelper.dart';
import 'package:chat_app_final/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController _textEditingController = TextEditingController();
  String myName, myProfilePic, myUsername, myEmail;

  getMyInfowithSharedPreference() async {
    // current user's info with sharedpreference

    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUsername = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(1, 8).codeUnitAt(6) > b.substring(1, 8).codeUnitAt(6)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchButtonClicked() async {
    setState(() {});

    await DatabaseMethods().getUserNamefromDB(_textEditingController.text);
  }

  Widget searchUsersListTile(String imgUrl, name, email, username) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomId(myUsername, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUsername, username]
        };
        DatabaseMethods().generateChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Conversations(username, name, imgUrl)));
      },
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imgUrl,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(email),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }

  Widget ListofChats() {}

  Widget searchUsersList() {
    return FutureBuilder(
        future:
            DatabaseMethods().getUserNamefromDB(_textEditingController.text),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return searchUsersListTile(
                        ds["imgUrl"], ds["name"], ds["email"], ds["username"]);

                    /*Image.network(
                      ds["imgUrl"],
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.height * 0.04,
                    );*/
                  },
                )
              : Container(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator());
        });
  }

  @override
  void initState() {
    getMyInfowithSharedPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  decoration: textFieldInputDecoration("search users"),
                )),
                GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {
                    if (_textEditingController.text != "") {
                      onSearchButtonClicked();
                    }
                  },
                ),
              ],
            ),
            searchUsersList(),
          ],
        ),
      ),
    );
  }
}
