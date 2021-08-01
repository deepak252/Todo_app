
class Task{
  String taskTitle;
  String? taskDescription;
  bool? isDone;
  bool? isBookmared;

  Task({
    required this.taskTitle,
    this.taskDescription,
    this.isDone=false,
    this.isBookmared=false,
  });
}