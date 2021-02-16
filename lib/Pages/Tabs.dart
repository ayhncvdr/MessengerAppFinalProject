import 'dart:io';

import 'package:chat_app_final/Pages/SignIn.dart';
import 'package:chat_app_final/TabPages/CallsPage.dart';
import 'package:chat_app_final/TabPages/CameraPage.dart';
import 'package:chat_app_final/TabPages/ChatsPage.dart';
import 'package:chat_app_final/TabPages/StatusPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController tabController;

  File _image;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  void initState() {
    tabController = TabController(initialIndex: 1, length: 4, vsync: this);

    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  signOut() async {
    try {
      /* SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();*/
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
        backgroundColor: Colors.indigo,
        title: Text(
          "MessengerApp",
          style: GoogleFonts.getFont("Lobster"),
        ),
        actions: [
          GestureDetector(
            onTap: signOut,
            child: Container(
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: GestureDetector(
                  onTap: () {
                    getImage();
                    if (_image == null) {
                      return "no image selected";
                    } else {
                      return Image.file(_image);
                    }
                  },
                  child: Icon(Icons.camera_alt)),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [CameraPage(), ChatsPage(), StatusPage(), CallsPage()],
      ),
    );
  }
}
