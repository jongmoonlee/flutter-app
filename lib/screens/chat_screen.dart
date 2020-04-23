import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/components/message_stream.dart';

final _firestore = Firestore.instance;
final messageTextController = TextEditingController();
final _auth = FirebaseAuth.instance;
String downloadUrl;
String tempFileName;
bool uploaded = false;


enum Select { camera, gallery}

FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String messageText;
  File _imageFile;
  bool _uploaded = false;
  bool _usrImageExists;
  String _fileName;
  Select _selection;

  StorageReference _reference = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
      else{
        Navigator.pushNamed(context, LoginScreen.id);
      }
    } catch (e) {
      Navigator.pushNamed(context, LoginScreen.id);
    }
  }

  Future downloadImage(String fileName) async{
    String downloadAddress = await _reference.child('$fileName').getDownloadURL();
    setState(() {
      downloadUrl = downloadAddress;
      print ('DwnExe: $downloadUrl');
      uploaded = true;
    });
  }

  Future uploadImage (String fileName) async{
    try {
      StorageUploadTask uploadTask = _reference.child('$fileName').putFile(_imageFile);
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
      downloadImage(tempFileName);
    });
  }


  Future getImage (bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print('gallery is seledted');
      uploadImage(DateTime.now().toIso8601String());
    }
    setState(() {
      _imageFile = image;
      tempFileName = DateTime.now().toIso8601String();
      uploadImage(tempFileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: SizedBox(
          child: TypewriterAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: ["Tomichat"],
              textStyle: TextStyle(
                fontSize: 15.0,
                fontFamily: "RockSalt",
                color: Colors.orangeAccent,
              ),
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
        ), //,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children:<Widget> [Positioned(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: Colors.white,
                        ),
                        child: PopupMenuButton<Select>(
                          onSelected: (Select result){
                            setState(() {
                              _selection = result;
                              print(_selection);
                              _selection == Select.camera ? getImage(true): getImage(false);
                            });
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<Select>>[

                            const PopupMenuItem<Select>(
                                value: Select.camera,
                                height: 15,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt,color: Colors.black,size: 35,),
                                )
                            ),
                            const PopupMenuItem<Select>(
                                value: Select.gallery,
                                child: IconButton(
                                  icon: Icon(Icons.collections,color: Colors.black,size: 35),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    ]
                  ),
                  uploaded? CircularProgressIndicator(
                      strokeWidth: 1,
                      value: 1):Container(),
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': DateTime.now(),
                        'isImg':uploaded,
                        'downloadUrl':downloadUrl
                      });
                      uploaded = false;
                      print('uploaded: $uploaded');
                      setState(() {
                        MessagesStream().scrollController.animateTo(0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300));
                        MessagesStream();
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
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





//TODO
//