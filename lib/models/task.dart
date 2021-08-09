final String tableTasks='tasks';

class Task{
  final int? id;
  final String taskTitle;
  final String? taskDescription;
  final DateTime createdTime;
  bool isDone;
  bool isBookmared;

  Task({
    this.id,
    required this.taskTitle,
    this.taskDescription= 'No description',
    required this.createdTime,
    this.isDone=false,
    this.isBookmared=false,
  });

  Map<String,Object?> toJson()=>{
    TaskFields.id: id,
    TaskFields.taskTitle: taskTitle,
    TaskFields.taskDescription: taskDescription,
    TaskFields.time: createdTime.toIso8601String(),
    TaskFields.isDone: isDone ? 1: 0,
    TaskFields.isBookmarked: isBookmared ? 1: 0,
  };

  static Task fromJson(Map<String,Object?> json)=>Task(
    id: json[TaskFields.id] as int?,
    taskTitle: json[TaskFields.taskTitle] as String, 
    taskDescription: json[TaskFields.taskDescription] as String, 
    createdTime: DateTime.parse(json[TaskFields.time] as String),
    isDone: json[TaskFields.isDone]==1,
    isBookmared: json[TaskFields.isBookmarked]==1,
  );

  Task copy({
    int? id,
    String? taskTitle,
    String? taskDescription,
    DateTime? time,
    bool? isDone,
    bool? isBookmared,
  })=> Task(
    id: id ?? this.id,
    taskTitle: taskTitle ?? this.taskTitle,
    taskDescription:  taskDescription ?? this.taskDescription,
    createdTime: time?? this.createdTime,
    isDone: isDone?? this.isDone,
    isBookmared:  isBookmared ?? this.isBookmared,
  );
}

class TaskFields{
  static final String id='id';
  static final String taskTitle='taskTitle';
  static final String taskDescription='taskDescription';
  static final String time='time';
  static final String isDone = 'isDone';
  static final String isBookmarked = 'isBookmarked';

  static final List<String> values=[
    id,taskTitle,taskDescription,time,isDone,isBookmarked
  ];

}
