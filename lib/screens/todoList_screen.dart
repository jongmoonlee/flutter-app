import 'package:flutter/material.dart';
import 'task_screen.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/models/task_data.dart';

class TodoListScreen extends StatelessWidget {
  static const String id = 'todoList_screen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
