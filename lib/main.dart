import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/SignIn.dart';
import 'Pages/Tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return Tabs();
          else
            return SignIn();
        },
      ),
    );
  }
}
