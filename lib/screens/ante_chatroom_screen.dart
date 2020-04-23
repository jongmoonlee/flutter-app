import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/globals.dart' as globals;


final _firestore = Firestore.instance;
File _imageFile;

bool _usrImageExists = false;
bool _uploaded = false;
String _downloadUrl;

StorageReference _reference = FirebaseStorage.instance.ref().child('');

class AnteChatroomScreen extends StatefulWidget {
  static const String id = 'anteChatroom_screen';
  @override
  _AnteChatroomScreenState createState() => _AnteChatroomScreenState();
}


class _AnteChatroomScreenState extends State<AnteChatroomScreen> {

  StreamBuilder _widget;

  @override

  List<Users> listUser= [];
  List<String> emailList =[];

  void initState(){
    super.initState();
    globals.Globals();
    globals.getCurrentUserImage();

    _widget =
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {

            final messages = snapshot.data.documents;

            for (var message in messages) {
              final email = message.data['email'];
              final hasAvatar = message.data['hasAvatar'];
              final isLoggedIn = message.data['isLoggedIn'];
              final user = Users(
                  email: email,
                  hasAvatar: hasAvatar,
                  isLoggedIn: isLoggedIn
              );
              listUser.add(user);
              emailList.add(email);
            }
            print ('ulogged in user: ${globals.currentUserEmail}');
            print ('lix:$emailList');

            print(emailList.indexOf(globals.currentUserEmail));
            if (emailList.indexOf(globals.currentUserEmail) == -1){
              _usrImageExists = false;

            } else {
              _usrImageExists = true;
              print('usrImg:$_usrImageExists');
              globals.getCurrentUserImage();
            }
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.yellow,
                bottomNavigationBar: menu(),


                body:

                TabBarView(
                    children:<Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          height: 50.0,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Friends',
                                style: TextStyle(fontSize: 25.0,color: Colors.black),
                              ),
                              CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: Colors.yellow,
                              child: Image.asset('images/about_page.png',width: 100,),
                            ),]
                          ),
                        ),
                      ),
                      IconBtn(
                          size: 30,
                          iconColor: Colors.black,
                          bgColor: Colors.yellow,
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed:(){
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
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
              ),
            );

            },
        );
  }

  Widget menu() {
    return Container(
      child: TabBar(
        indicatorColor: Colors.black,
        tabs: [
          Tab(
            icon: Icon(Icons.person_outline,color: Colors.black,),
          ),
          Tab(
            icon:  Icon(Icons.chat_bubble_outline,color: Colors.black,)),
          Tab(
               icon: Icon(Icons.search,color: Colors.black,),
          ),
          Tab(
            icon: Icon(Icons.settings,color: Colors.black,),
            ),
        ],
      ),
    );
  }








  Future uploadImage () async{
    try {
      StorageUploadTask uploadTask = _reference.putFile(_imageFile);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      _uploaded = uploadTask.isComplete;
    }
    catch (e){
      print (e);
    }
    setState(() {
      _uploaded: true;
      _usrImageExists = true;
      print('uploade?:$_uploaded');
    });
  }

  Future getImage (bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      uploadImage();
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print('gallery is seledted');
      uploadImage();
    }
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}
class Users{
  Users({this.email, this.hasAvatar, this.isLoggedIn});
  final String email;
  final bool hasAvatar;
  final bool isLoggedIn;

}

