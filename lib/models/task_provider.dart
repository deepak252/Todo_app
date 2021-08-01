
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> _tasks=[
    Task(taskTitle: 'Drink Water'),
    Task(taskTitle: 'Drink Milk'),
    Task(taskTitle: 'Drink Colddrink'),
  ];
  List<Task> _bookmarkedTasks=[
    Task(taskTitle: 'Drink Water'),
    Task(taskTitle: 'Drink Milk'),
    Task(taskTitle: 'Drink Colddrink'),
  ];
  List<Task> _taskHistory=[
    Task(taskTitle: 'Drink Water'),
    Task(taskTitle: 'Drink Milk'),
    Task(taskTitle: 'Drink Colddrink'),
    
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get totalTasks{
    return _tasks.length;
  }

  void addTask(Task task){
    _tasks.add(task);
    notifyListeners();
  }
  
}