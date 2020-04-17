import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnteQuizroomScreen extends StatefulWidget {
  static const String id = 'anteQuizroom_screen';
  @override
  _AnteQuizroomScreenState createState() => _AnteQuizroomScreenState();
}

class _AnteQuizroomScreenState extends State<AnteQuizroomScreen> {

  File _imageFile;
  bool _uploaded = false;
  String _downloadUrl;

  StorageReference _reference = FirebaseStorage.instance.ref().child('yumtomi@email.com.jpg');

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
      print('uploade?:$_uploaded');
    });
  }

  Future downloadImage() async{
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }

  Future getImage (bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
    });
  }

  String id = 'anteQuizroom_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestroagetest')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('camera'),
                onPressed: (){
                  getImage(true);
                }),
            SizedBox(height: 10.0,),
            RaisedButton(
                child: Text('Gallery'),
                onPressed: (){
                  getImage(false);
                }),
            _imageFile == null ? Container() : Image.file(_imageFile,height: 300.0, width: 300,),
            _imageFile == null ? Container() : RaisedButton(
          child: Text('Upload to Storage'),
          onPressed: (){
            uploadImage();
          }),
            _uploaded == false ? Container() : RaisedButton(
              child: Text('download'),
              onPressed: (){
                downloadImage();
              },
            ),
            _downloadUrl == null ? Container() : Image.network(_downloadUrl,height: 300, width: 300,)
          ],
        ),
      )
    );
  }
}
