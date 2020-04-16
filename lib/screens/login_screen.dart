import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/ante_chatroom_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo2',
                  child: Container(
                    height: 145.0,
                    child: Image.asset('images/logo2.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onChanged: (value) {
                          email = value;
                        },
                        onSaved: (value) => email = value,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email')),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        validator: (value) =>
                            value.isEmpty ? 'Password can\'t be empty' : null,
                        onChanged: (value) {
                          password = value;
                        },
                        onSaved: (value) => password = value,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                buttonTitle: 'Log In',
                onPressed: () async {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(_auth.currentUser());
                      if (_auth.currentUser() != null) {
                        Navigator.pushNamed(context, AnteChatroomScreen.id);
                        form.save();
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    print('invalid');
                  }
                },
                buttonColour: Colors.lightBlueAccent,
              ),
              RoundedButton(
                buttonTitle: 'Not a member ? Register',
                buttonColour: Colors.blueGrey,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
