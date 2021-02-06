import 'package:chat_app_final/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SignUp.dart';
import 'Tabs.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print("User is signed in!");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    try {
      UserCredential firebaseUser = await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text("Login Successful!")),
            content: SizedBox(
                child: Icon(
              Icons.done,
              size: 50,
              color: Colors.green,
            )),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back")),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Tabs()));
                  },
                  child: Text("Chats")),
            ],
          ),
        );
        /*Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));*/
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  goSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Messenger App",
          style: GoogleFonts.lobster(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.94,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.height * 0.33,
                      color: Colors.indigo,
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(input)
                          ? null
                          : "Please provide a valid e-mail!";
                    },
                    decoration: textFieldInputDecoration("e-mail"),
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Provide Minimum 6 character';
                      }
                    },
                    obscureText: true,
                    decoration: textFieldInputDecoration("password"),
                    onSaved: (input) => _password = input,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.01,
                          vertical: MediaQuery.of(context).size.width * 0.02),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                          MediaQuery.of(context).size.width * 0.07),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                        onPressed: login,
                        highlightColor: Colors.indigo,
                        color: Colors.indigo,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                          MediaQuery.of(context).size.width * 0.07),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Sign In with Google",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.001,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: goSignUp,
                        child: Text(
                          "Register now!",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
