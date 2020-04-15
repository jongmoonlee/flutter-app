import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';

class AnteChatroomScreen extends StatelessWidget {
  static const String id = 'anteChatroom_screen';
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
                    buttonColour: Colors.blueAccent,
                    buttonTitle: 'Join the chat room',
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Make a chat room',
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
                  ),
                  RoundedButton(
                    buttonColour: Colors.blue,
                    buttonTitle: 'Find',
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
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
