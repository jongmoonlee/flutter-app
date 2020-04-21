import 'package:flutter/foundation.dart';
import 'package:flash_chat/models/skill.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Walk '),
    Task(name: 'Chew '),
//    Task(name: 'Dance'),
    Task(name: 'Spin'),
    Task(name: 'Clean dishes'),
    Task(name: 'Socialise'),
    Task(name: 'Swim'),
    Task(name: 'Watch TV'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  String getCurrentTask(int){
    return _tasks[int].name;
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
