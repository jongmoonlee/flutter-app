library flash_chat.globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

bool isLoggedIn;
bool currentUserImageUrlExists = false;
FirebaseUser loggedInUser;
String currentUserImgUrl;
String currentUserEmail;
String downloadUrl;

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;




class Globals {

  void getCurrentUser() async {


    try{
      final user = await _auth.currentUser();
      loggedInUser = user;
      print(loggedInUser);
      print('exe:${loggedInUser.email}');
      loggedInUser.email != null ? isLoggedIn = true : isLoggedIn = false;
      isLoggedIn ? currentUserEmail = loggedInUser.email : currentUserEmail =
      null;
      print('isloggedin: $isLoggedIn');
    }catch(e){
      isLoggedIn = false;
    }
  }

   bool get isUserLoggedIn {
    getCurrentUser();
    print(isLoggedIn);
    if (isLoggedIn !=null){
      return isLoggedIn;
    }else{
      return false;
    }

    }
   }



getCurrentUserImage() async{
  try{
    StorageReference _reference = FirebaseStorage.instance.ref().child('$currentUserImgUrl.jpg');
    downloadUrl = await _reference.getDownloadURL();
    currentUserImgUrl = downloadUrl;
    print('url: $downloadUrl');


  }
  catch (e){
    currentUserImageUrlExists = false;

  }}