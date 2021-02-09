import 'package:chat_app_final/Pages/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  signOut() async {
    try {
      return await _auth.signOut().then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          GestureDetector(
            onTap: signOut,
            child: Container(
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
    );
  }
}
