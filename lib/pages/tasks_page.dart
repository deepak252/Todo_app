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
  // String? _taskTitle;
  // String? _taskDescription;

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffddebe9),
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
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: ()async {
                                    _taskTitleController.text=tasks[index].taskTitle;
                                    _taskDescriptionController.text=tasks[index].taskDescription=='No description'
                                      ? ''
                                      : tasks[index].taskDescription!;
                                    await buildTaskEditingDialog(
                                      context:context, 
                                      taskProvider:taskProvider,
                                      editTask: true,
                                      index: index
                                    );
                                    _taskTitleController.clear();
                                    _taskDescriptionController.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(Icons.edit,size:12),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Material(
                                    color: Colors.transparent,
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
                                            if(tasks[index].isBookmared==true){
                                              taskProvider.deleteBookmark(tasks[index]);
                                              setState(() {});
                                            }else{
                                              taskProvider.addBookmark(tasks[index]);
                                              setState(() {});
                                            }
                                            return;
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
                                          iconWidget: tasks[index].isBookmared==true
                                            ? Icon(
                                                Icons.bookmark_remove_outlined,
                                                size: 14,
                                              )
                                            : Icon(
                                                  Icons.bookmark_add_outlined,
                                                  size: 14,
                                            ),
                                          textWidget:tasks[index].isBookmared==true
                                            ? Text(
                                                'Delete Bookmark',
                                                style: TextStyle(fontSize: 12),
                                              )
                                            :  Text(
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
        onPressed: ()async {
          await buildTaskEditingDialog(context:context, taskProvider:taskProvider);
          _taskTitleController.clear();
          _taskDescriptionController.clear();
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

  Future buildTaskEditingDialog({
    required BuildContext context,
    required  TaskProvider taskProvider,
    bool? editTask,int ? index,
    }) async {
    // editTask!=null ? _taskTitleController.value=taskProvider. : ;
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                final task=Task(
                                  taskTitle: _taskTitleController.text,
                                  taskDescription:_taskDescriptionController.text==''
                                                ? 'No description' 
                                                : _taskDescriptionController.text 
                                );    
                                editTask==true ? taskProvider.editTask(task,index!)
                                              : taskProvider.addTask(task);                     
                                
                                setState(() {});                                
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              print('error2: $e');                              
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      child: InkWell(                    
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      ),
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

