import 'package:firebase_auth/firebase_auth.dart';

//TODO:cleanup this code



class User{
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser();
  FirebaseUser loggedInUser;
  bool isLoggedIn;
  String email = '';

  Future getCurrentUser() async {
    final loggedInUser = await _auth.currentUser();
    if (loggedInUser == null) {
      return (loggedInUser.email).toString();
    } else {
      email = loggedInUser.email.toString();
      return email;
    }
    //      print (loggedInUser.email);
  }

  Future isUserLoggedIn() async {
    final isUserLoggedIn = await _auth.currentUser();
    final result = isUserLoggedIn == null ?  false:  true;
    print('result:$result');
    return result;
}


}

