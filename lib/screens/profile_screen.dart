import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'profile_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 180.0,
              child: CircleAvatar(
                radius: 180.0, //
                backgroundColor: Colors.black54,
                child: Image.asset('images/about_page.png'),
              ),
            ),
            Text('data')
          ],
        ),
      ),
    );
  }
}
