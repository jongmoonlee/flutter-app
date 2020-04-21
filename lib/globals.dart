library flash_chat.globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool isLoggedIn = false;
bool currentUserImageUrlExists = false;
FirebaseUser loggedInUser;
String currentUserImgUrl;
String currentUserEmail;
String downloadUrl;

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

void getCurrentUser() async {
  final user = await _auth.currentUser();
  loggedInUser = user;
  currentUserEmail= loggedInUser.email;
  print (currentUserEmail);
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