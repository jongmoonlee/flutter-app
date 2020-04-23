
import 'package:flash_chat/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'ante_chatroom_screen.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/globals.dart';



class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;  const StatefulWrapper({@required this.onInit, @required this.child});  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}class _StatefulWrapperState extends State<StatefulWrapper> {@override
void initState() {
  if(widget.onInit != null) {
    widget.onInit();
  }
  super.initState();
}  @override
Widget build(BuildContext context) {
  return widget.child;
}
}


class StartupCaller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        _getThingsOnStartup().then((value) {
          print('Async done');
        });
      },
      child: Container(),
    );
  }  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
}






class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
      return StatefulWrapper(
        onInit: () {
          Globals().isUserLoggedIn;

          _getThingsOnStartup().then((value) {
            print('Async done');
          });
        },
        child: Scaffold(
          backgroundColor: Colors.black54,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                          child: Image.asset('images/logo2.png'),
                          height: 150.0,
                          padding: EdgeInsets.all(3)),
                    ),
                    Center(
                      child: TextLiquidFill(
                        text: 'Tomichat',
//                    boxBackgroundColor: Colors.white,
                        waveColor: Colors.yellow,
                        textStyle: TextStyle(
                            fontSize: 45.0,
                            fontFamily: "PermanentMarker",
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent),
                        boxHeight: 100.0,
                        boxWidth: 250,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconBtn(
                            bgColor: Colors.yellow,
                            iconColor: Colors.black,
                            size: 40,
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: (){
                              print('xxx');
                              print( Globals().isUserLoggedIn);
                              Globals().isUserLoggedIn
                                ? Navigator.pushNamed(context, AnteChatroomScreen.id)
                                : Navigator.pushNamed(
                                context, LoginScreen.id);}
                        ),
                          IconBtn(
                              iconColor: Colors.blue,
                              bgColor: Colors.white,
                              size: 40,
                              icon: Icon(Icons.pets),
                              onPressed: (){
                                Navigator.pushNamed(context, AboutScreen.id);
                              }),],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
}




