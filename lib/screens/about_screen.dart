import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/screens/todoList_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/quiz_screen.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 180.0,
              child: CircleAvatar(
                radius: 180.0, //
                backgroundColor: Colors.black54,
                child: Image.asset('images/about_page.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Profile',
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Tricks',
                    onPressed: () {
                      Navigator.pushNamed(context, TodoListScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Quiz',
                    onPressed: () {
                      Navigator.pushNamed(context, QuizScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
