import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
                    ),]
                  ),
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
                      setState(() {
                        MessagesStream()._scrollController.animateTo(0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300));
                        uploaded = false;

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

class MessagesStream extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;

        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageTime = message.data['time'];
          final currentUser = loggedInUser.email;
          final isImgAttached = message.data['isImg'];
          final downloadUrl = message.data['downloadUrl'];
          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
              isImgAttached:isImgAttached,
              time: messageTime.toDate(),
              downloadUrl:downloadUrl);

          messageBubbles.add(messageBubble);
        }

        messageBubbles.sort(
            (MessageBubble b, MessageBubble a) => a.time.compareTo(b.time));

        return Expanded(
          child: ListView(
            reverse: true,
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.time, this.isMe, this.isImgAttached, this.downloadUrl});
  final String sender;
  final String text;
  final String downloadUrl;
  final DateTime time;
  final bool isMe;
  bool isImgAttached = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender:',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                  elevation: 5.0,
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${time.toIso8601String().substring(11, 16)}',
                  style: TextStyle(color: Colors.white30, fontSize: 8.0),
                ),
                isImgAttached ?  Image.network(downloadUrl,height: 100, width: 100,):Container()
             ]),


        ],
      ),
    );
  }
}

//TODO
//Load associated image