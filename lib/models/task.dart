
class Task{
  String taskTitle;
  String? taskDescription;
  DateTime time;
  bool? isDone;
  bool? isBookmared;

  Task({
    required this.taskTitle,
    required this.time,
    this.taskDescription= 'No description',
    this.isDone=false,
    this.isBookmared=false,
  });
}

// class Description{
//   static String? getDescription(String? value){
//     if(value==null ||value=='') 
//       return 'No description';
//   }
// }
