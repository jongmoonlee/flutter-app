import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flash_chat/services/getCurrentUser.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum Select { camera, gallery}

class _ProfileScreenState extends State<ProfileScreen>{
  File _imageFile;
  bool _uploaded = false;
  bool _usrImageExists;
  String _downloadUrl;
  String _fileName;
  Select _selection;
  StorageReference _reference = FirebaseStorage.instance.ref().child('');

  //get user info
  setFileName (){
    User().getCurrentUser().then((var result){
      _fileName = result;
      _reference = FirebaseStorage.instance.ref().child('$_fileName.jpg');
//      print('eamil:$_fileName');
    });
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

  getCurrentUserImage() async{
    try{
      StorageReference _reference = FirebaseStorage.instance.ref().child('$_fileName.jpg');
      _downloadUrl = await _reference.getDownloadURL();
      setState(() {
        _usrImageExists = true;
      });
//      print('no error');
//      print('_userImageExiste?: $_usrImageExists');
    }
    catch (e){
      setState(() {
        _usrImageExists = false;
      });
      print ('error:$e');
    }
  }

//    StorageReference _reference = FirebaseStorage.instance.ref().child('myimage.jpg');

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
    setFileName();
    getCurrentUserImage();

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 150.0,
                child: Stack(
                  children:<Widget> [ClipOval(

                    child: _usrImageExists? Image.network(_downloadUrl,width: 100,
                        height: 100,
                        fit: BoxFit.cover) :Image.asset('images/about_page.png')
//                    ,
                  ),
                   Positioned(top: 50.0, left: 65.0,
                   child: IconButton(
                    icon: Icon(Icons.camera_alt),
                  color: Colors.yellowAccent,
                  onPressed: (){
                    print('pressed');
                  },
                ),
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
                    )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
