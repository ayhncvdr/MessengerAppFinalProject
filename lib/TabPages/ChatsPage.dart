import 'package:chat_app_final/Services/DatabaseMethods.dart';
import 'package:chat_app_final/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController _textEditingController = TextEditingController();

  Stream usersSearchedStream;

  onSearchButtonClicked() async {
    setState(() {});
    usersSearchedStream =
        await DatabaseMethods().getUserNamefromDB(_textEditingController.text);
  }

  Widget searchUsersList() {
    return StreamBuilder(
        stream: usersSearchedStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Image.network(ds["imgUrl"]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 500),
              child: Row(
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
            ),
            searchUsersList(),
          ],
        ),
      ),
    );
  }
}
