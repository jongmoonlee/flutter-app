import 'package:flutter/material.dart';


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
            '$sender:${time.toIso8601String().substring(11, 16)}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          Column(
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
                Row(
                  mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget> [
                    isImgAttached ?  Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Image.network(downloadUrl,height: 150, width: 200,),
                    ):Container(),
                  ],
                )]),
        ],
      ),
    );
  }
}