import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';

import 'screens/chat_screen.dart';
import 'screens/about_screen.dart';
import 'screens/play_screen.dart';
import 'screens/profile_screen.dart';

import 'screens/ante_chatroom_screen.dart';
import 'screens/ante_quizroom_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/skillList_screen.dart';


void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          AboutScreen.id: (context) => AboutScreen(),
          PlayScreen.id: (context) => PlayScreen(),
          QuizScreen.id: (context) => QuizScreen(),
          SkillListScreen.id: (context) => SkillListScreen(),
          AnteChatroomScreen.id: (context) => AnteChatroomScreen(),
          AnteQuizroomScreen.id: (context) => AnteQuizroomScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
        });
  }
}
