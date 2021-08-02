
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> _tasks=[
    Task(taskTitle: 'Drink Water',taskDescription: "We've created a college application timeline just for international students. Know what to do the year before you apply to college, while applying, and the summer before college begins."),
    Task(taskTitle: 'Drink Milk'),
    Task(taskTitle: 'Drink Colddrink Drink ColddrinkDrink ColddrinkDrink ColddrinkDrink Colddrink'),
  ];
  List<Task> _bookmarkedTasks=[
    Task(taskTitle: 'eat food'),
    Task(taskTitle: 'eat chips'),
  ];
  List<Task> _taskHistory=[
    Task(taskTitle: 'Drink Water'),
    Task(taskTitle: 'Drink Milk'),
    Task(taskTitle: 'Drink Colddrink'),
    
  ];

  UnmodifiableListView<Task> get getTasks {
    return UnmodifiableListView(_tasks);
  }
  UnmodifiableListView<Task> get getBookMarkedTasks{
    return UnmodifiableListView(_bookmarkedTasks);
  }
  UnmodifiableListView<Task> get getTasksHistory {
    return UnmodifiableListView(_taskHistory);
  }

  int get totalTasks{
    return _tasks.length;
  }
  int get totalBookmarkedTasks {
    return _bookmarkedTasks.length;
  }
  int get totalTasksHistory {
    return _taskHistory.length;
  }

  void addTask(Task task){
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    _bookmarkedTasks.remove(task);
    notifyListeners();
  }

  void addToBookmark(Task task) {
    task.isBookmared=true;
    _bookmarkedTasks.add(task);
    notifyListeners();
  }
  void markAsDone(Task task) {
    task.isDone=true;
    _taskHistory.add(task);
    _tasks.remove(task);
    _bookmarkedTasks.remove(task);
    notifyListeners();
  }

  // void addTask(Task task) {
  //   _tasks.add(task);
  //   notifyListeners();
  // }
  
}