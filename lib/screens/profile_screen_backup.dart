import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flash_chat/services/getCurrentUser.dart';
import 'package:catcher/catcher_plugin.dart';


final _firestore = Firestore.instance;
final messageTextController = TextEditingController();
final _auth = FirebaseAuth.instance;

File _imageFile;
FirebaseUser loggedInUser;
bool _usrImageExists = false;
bool _uploaded = false;
String _downloadUrl;
Select _selection;

StorageReference _reference = FirebaseStorage.instance.ref().child('');

enum Select { camera, gallery}


class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

@override

void aa() async{
  var b = await _firestore.collection('users').getDocuments();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamBuilder _widget;

  @override

  List<Users> listUser= [];
  List<String> emailList =[];

  void initState(){
    super.initState();
    getCurrentUser();
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
//        print ('ulogged in user: $loggedInUserEmail');
//        print ('lix:$emailList');

//        print(emailList.indexOf(loggedInUserEmail));
        if (emailList.indexOf(loggedInUserEmail) == -1){
          _usrImageExists = false;
        } else {
          _usrImageExists = true;
          getCurrentUserImage();
        }
        return Image.network(
            _downloadUrl,width: 150,height: 150, fit: BoxFit.cover);
      },
    );
//    print('xxxxxxx');
  }

  String loggedInUserEmail;

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    loggedInUser = user;
    loggedInUserEmail= loggedInUser.email;
    print (loggedInUserEmail);
  }

  getCurrentUserImage() async{
    try{
      StorageReference _reference = FirebaseStorage.instance.ref().child('$loggedInUserEmail.jpg');
      _downloadUrl = await _reference.getDownloadURL();
      setState(() {
        _usrImageExists = true;
      });

    }
    catch (e){
      setState(() {
        _usrImageExists = false;
      });
    }}


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
//    return _widget;
//    initState();
    return Scaffold(
//      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Center(
                child: Stack(
                    children:<Widget> [
                      ClipOval(
                          child: _usrImageExists? Image.network(
                              _downloadUrl,width: 150,height: 150, fit: BoxFit.cover)
                              : Icon(Icons.person_outline,size: 100.0,)
                      ),

                      Positioned(
                        top: 50.0,left:75.0,
                        child: Padding(

                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardColor: Colors.white,

                            ),
                            child: PopupMenuButton<Select>(
                              padding: EdgeInsets.all(8),
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
                      ),
                    ]
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }


}

class Users{
  Users({this.email, this.hasAvatar, this.isLoggedIn});
  final String email;
  final bool hasAvatar;
  final bool isLoggedIn;
}
