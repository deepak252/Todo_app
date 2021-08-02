import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_provider.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';

const kHeadingTextStyle = TextStyle(
  color: Color(0xff6c40ff),
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TextEditingController _taskTitleController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _taskTitle;
  String? _taskDescription;

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Tasks',
            ),
          ),
          centerTitle: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
          elevation: 6,
        ),
      ),
      body: ListView.builder(
          itemCount: taskProvider.totalTasks,          
          itemBuilder: (context, index) {
            final tasks = taskProvider.getTasks;
            return CircularBorderCardWidget(
              padding: EdgeInsets.only(left: 10,right:10,top:10),
              elevation: 3,
              child: InkWell(
                onTap: () {
                  print('show task');
                  buildTaskViewerDialog(context, tasks[index]);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '${tasks[index].taskTitle}',
                                style: TextStyle(
                                    color: Color(0xff6c40ff),
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(5, -5),
                            child: PopupMenuButton(
                              onSelected: (value) {
                                switch (value) {
                                  case 0:
                                    {
                                      taskProvider.markTaskAsDone(tasks[index]);
                                      setState(() {});
                                      return;
                                    }
                                  case 1:
                                    {
                                      print('bookmarked');
                                      taskProvider.addToBookmark(tasks[index]);
                                      setState(() {});
                                      return;
                                    }
                                  case 2:
                                    {
                                      taskProvider.deleteTask(tasks[index]);
                                      setState(() {});
                                      return;
                                    }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 14,
                                ),
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                buildPopupMenuItem(
                                  value: 0,
                                  iconWidget: Icon(
                                    Icons.done,
                                    size: 14,
                                  ),
                                  textWidget: Text(
                                    'Mark as Done',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                buildPopupMenuItem(
                                  value: 1,
                                  iconWidget: Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 14,
                                  ),
                                  textWidget: Text(
                                    'Bookmark',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                buildPopupMenuItem(
                                  value: 2,
                                  iconWidget: Icon(
                                    Icons.delete_outlined,
                                    size: 14,
                                  ),
                                  textWidget: Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        tasks[index].taskDescription ?? 'No description.',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      tasks[index].isBookmared!
                      ? Align(
                        alignment: Alignment.bottomRight,
                        child: Transform.translate(
                          offset: Offset(5,20),
                          child: Icon(
                              Icons.bookmark,
                              color: Colors.orange,
                              size: 20,
                            ),
                        ),
                      )
                      : Container(),

                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildAddTaskDialog(context, taskProvider);
        },
        child: Icon(
          Icons.add,
          size: 26,
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> buildPopupMenuItem(
      {final iconWidget, final textWidget, required final value}) {
    return PopupMenuItem(
      value: value,
      height: 40,
      child: Container(
          padding: EdgeInsets.all(0),
          child: Row(children: [
            iconWidget,
            SizedBox(
              width: 16,
            ),
            textWidget
          ])),
    );
  }

  Future buildAddTaskDialog(
    BuildContext context, TaskProvider taskProvider) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              scrollable: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              content: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Task title is required';
                      }
                    },
                    controller: _taskTitleController,
                    onChanged: (value) {
                      _taskTitle = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54
                        ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                        controller: _taskDescriptionController,
                        onChanged: (value) {
                          _taskDescription = value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: "Description",
                            isCollapsed: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6)),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        splashRadius: 20,
                        icon: Icon(Icons.close,
                          color: Colors.red,
                        ),
                          onPressed: () async {
                            _taskTitleController.clear();
                            _taskDescriptionController.clear();
                            Navigator.of(context).pop();
                          },
                          
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        splashRadius: 20,
                        icon: Icon(
                          Icons.done,
                          color: Colors.green,),
                          onPressed: () async {
                            try {
                              if (_formKey.currentState!.validate()) {
                                print(_taskTitle);
                                print(_taskDescription);

                                taskProvider.addTask(Task(
                                    taskTitle: _taskTitle!,
                                    taskDescription: _taskDescription));
                                setState(() {});
                                _taskTitleController.clear();
                                _taskDescriptionController.clear();
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              print(e);
                              _taskTitleController.clear();
                              _taskDescriptionController.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future buildTaskViewerDialog( BuildContext context, Task task) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))
            ),
            scrollable: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(                    
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                ),
                Text(
                  task.taskTitle,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                
                
                SizedBox(
                  height: 12,
                ),
                Text(
                  task.taskDescription??'No Description',
                  style: TextStyle(
                    color: Colors.black54,

                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                
              ],
            ),
          );
        });
  }

  

  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

// RawMaterialButton(
//                   onPressed: () {},
//                   constraints: BoxConstraints(
//                     minWidth: 20,
//                     minHeight: 20,
//                   ),
//                 ),
