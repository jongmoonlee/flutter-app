import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/components/message_bubble.dart';

final _firestore = Firestore.instance;
final messageTextController = TextEditingController();
final _auth = FirebaseAuth.instance;
String downloadUrl;
String tempFileName;
bool uploaded = false;


enum Select { camera, gallery}
FirebaseUser loggedInUser;


class MessagesStream extends StatelessWidget {
  ScrollController scrollController = new ScrollController();
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
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}