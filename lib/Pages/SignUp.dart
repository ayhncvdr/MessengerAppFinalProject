import 'package:chat_app_final/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SignIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    try {
      UserCredential firebaseUser = await _auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      });
      if (firebaseUser != null) {
        await _auth.currentUser.updateProfile(displayName: _username);
      }
    } catch (e) {
      print(e);
    }
  }

  goSignIn() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
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
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.1,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty)
                        return "Enter a username";
                      else if (input.length < 6)
                        return "Provide minimum 6 character";
                    },
                    onSaved: (input) => _username = input,
                    decoration: textFieldInputDecoration("username"),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty)
                        return "Enter an email address";
                      else if (input.length < 6)
                        return "Provide minimum 6 character";
                    },
                    onSaved: (input) => _email = input,
                    decoration: textFieldInputDecoration("e-mail"),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty)
                        return "Enter a password";
                      else if (input.length < 6)
                        return "Provide minimum 6 character";
                    },
                    obscureText: true,
                    onSaved: (input) => _password = input,
                    decoration: textFieldInputDecoration("password"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
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
                        onPressed: signUp,
                        highlightColor: Colors.indigo,
                        color: Colors.indigo,
                        child: Text(
                          "Sign Up",
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
                        color: Colors.white70,
                        child: Text(
                          "Sign Up with Google",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: goSignIn,
                        child: Text(
                          "Sign in now!",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
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
