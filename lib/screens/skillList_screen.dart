import 'package:flutter/material.dart';
import 'skill_screen.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/models/skill_data.dart';

class SkillListScreen extends StatelessWidget {
  static const String id = 'skillList_screen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TaskData(),
      child: MaterialApp(
        home: SkillScreen(),
      ),
    );
  }
}
