import 'package:flutter/material.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';

class AnteChatroomScreen extends StatelessWidget {
  static const String id = 'anteChatroom_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top:0),
              child: SizedBox(
                height: 250.0,
                child: CircleAvatar(
                  radius: 150.0, //
                  backgroundColor: Colors.yellow,
                  child: Image.asset('images/about_page.png'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                RoundedButton(
            buttonColour: Colors.blueAccent,
              buttonTitle: 'Join',
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              }),
                RoundedButton(
                  buttonColour: Colors.blue,
                  buttonTitle: 'Make a new',
                  onPressed: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                ),
                RoundedButton(
                  buttonColour: Colors.blue,
                  buttonTitle: 'Search',
                  onPressed: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                ),],
              ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                IconBtn(
                    size: 30,
                    iconColor: Colors.black,
                    bgColor: Colors.yellow,
                    icon: Icon(Icons.person_outline),
                    onPressed:(){}
                ),
                IconBtn(
                    size: 30,
                    iconColor: Colors.black,
                    bgColor: Colors.yellow,
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed:(){}
                ),
                IconBtn(
                    size: 30,
                    iconColor: Colors.black,
                    bgColor: Colors.yellow,
                    icon: Icon(Icons.search),
                    onPressed:(){}
                ),

                IconBtn(
                    size: 25,
                    iconColor: Colors.black,
                    bgColor: Colors.yellow,
                    icon: Icon(Icons.settings),
                    onPressed:(){
                      Navigator.pushNamed(context,ProfileScreen.id );
                    }
                ),
              ]
            ),
                      ],
        ),
      ),
    );
  }
}
