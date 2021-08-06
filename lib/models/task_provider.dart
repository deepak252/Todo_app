import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
        taskTitle: 'Complete the app',
        taskDescription:
            "We've created a college application timeline just for international students. Know what to do the year before you apply to college, while applying, and the summer before college begins.",
            time:DateTime.now()),
    Task(taskTitle: 'Drink water', taskDescription: "time: 4:00pm",time: DateTime.now()),
    Task(taskTitle: 'Go to shop', time: DateTime.now()),
  ];
  List<Task> _bookmarkedTasks = [];
  List<Task> _taskHistory = [
    Task(taskTitle: 'Bath',time:DateTime.now()),
    Task(taskTitle: 'Call Dad', time: DateTime.now()),
  ];

  UnmodifiableListView<Task> get getTasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Task> get getBookMarkedTasks {
    return UnmodifiableListView(_bookmarkedTasks);
  }

  UnmodifiableListView<Task> get getTasksHistory {
    return UnmodifiableListView(_taskHistory);
  }

  int get totalTasks {
    return _tasks.length;
  }

  int get totalBookmarkedTasks {
    return _bookmarkedTasks.length;
  }

  int get totalTasksHistory {
    return _taskHistory.length;
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
  void editTask(Task task,int index) {
    _tasks[index]=task;
    notifyListeners();
  }
  void deleteTask(Task task) {
    _tasks.remove(task);
    _bookmarkedTasks.remove(task);
    notifyListeners();
  }

  void deleteHistory(Task task) {
    _taskHistory.remove(task);
    notifyListeners();
  }

  void addBookmark(Task task) {
    task.isBookmared = true;
    _bookmarkedTasks.add(task);
    notifyListeners();
  }
  void deleteBookmark(Task task) {
    task.isBookmared = false;
    _bookmarkedTasks.remove(task);
    notifyListeners();
  }

  void markTaskAsDone(Task task) {
    task.isDone = true;
    _taskHistory.add(task);
    _tasks.remove(task);
    _bookmarkedTasks.remove(task);
    notifyListeners();
  }

  void unduDoneTask(Task task) {
    task.isDone = false;
    _taskHistory.remove(task);
    _tasks.add(task);
    notifyListeners();
  }

}
