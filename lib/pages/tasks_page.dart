import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/db/tasks_db.dart';
import 'package:todo_app/models/dialog_model.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TextEditingController _taskTitleController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Task> tasks = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // refreshTasks().whenComplete(() {
    //   setState(() {});
    // });
    refreshTasks();
  }

  // @override
  // void dispose() {
  //   TasksDB.instance.close();
  //   super.dispose();
  // }

  Future refreshTasks() async {
    print('Refreshing tasks');    
    try{
      final allTasks = await TasksDB.instance.readTasks();
      
      tasks=allTasks??[];     

    }catch(e){
      print('Exception while refresh tasks: $e');
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color(0xffddebe9),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
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
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CircularBorderCardWidget(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    print('show task');
                    DialogModel.buildTaskViewerDialog(
                      context: context,
                      task: task,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
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
                                  '${task.taskTitle}',
                                  style: kTaskTitleTextStyle,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.edit, size: kIconSize),
                                    ),
                                    onTap: () async {
                                      _taskTitleController.text =
                                          task.taskTitle;
                                      _taskDescriptionController.text =
                                          task.taskDescription ==
                                                  'No description'
                                              ? ''
                                              : task.taskDescription!;

                                      await DialogModel.buildTaskEditorDialog(
                                        context: context,
                                        formKey: _formKey,
                                        taskTitleController:
                                            _taskTitleController,
                                        taskDescriptionController:
                                            _taskDescriptionController,
                                        editTask: true,
                                        time: DateTime.now(),
                                        taskCopy: task
                                      );
                                      _taskTitleController.clear();
                                      _taskDescriptionController.clear();
                                      refreshTasks();
                                    },
                                    
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: PopupMenuButton(
                                        onSelected: (value) async {
                                          switch (value) {
                                            case 0:
                                              {
                                                Task markDone= task.copy(
                                                  isDone: true,
                                                );
                                                TasksDB.instance.update(markDone);
                                                refreshTasks();
                                                return;
                                              }
                                            case 1:
                                              if (task.isBookmared == true) {
                                                Task deleteBookmark= task.copy(
                                                  isBookmared: false,
                                                );
                                                TasksDB.instance.update(deleteBookmark);
                                                refreshTasks();
                                              } else {
                                                Task addBookmark= task.copy(
                                                  isBookmared: true,
                                                );
                                                TasksDB.instance.update(addBookmark);
                                                refreshTasks();                                              
                                              }
                                              return;
                                            case 2:
                                              {
                                                await DialogModel.buildConfirmDeleteDialog(
                                                  context: context, 
                                                  task: task
                                                );
                                                refreshTasks();
                                                return;
                                              }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.more_vert,
                                            size: kIconSize + 2,
                                          ),
                                        ),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry>[
                                          buildPopupMenuItem(
                                            value: 0,
                                            iconWidget: Icon(
                                              Icons.done,
                                              size: kIconSize,
                                            ),
                                            textWidget: Text(
                                              'Done',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          buildPopupMenuItem(
                                            value: 1,
                                            iconWidget: task.isBookmared == true
                                                ? Icon(
                                                    Icons
                                                        .bookmark_remove_outlined,
                                                    size: kIconSize,
                                                  )
                                                : Icon(
                                                    Icons.bookmark_add_outlined,
                                                    size: kIconSize,
                                                  ),
                                            textWidget: task.isBookmared == true
                                                ? Text(
                                                    'Delete Bookmark',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                : Text(
                                                    'Bookmark',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                          ),
                                          buildPopupMenuItem(
                                            value: 2,
                                            iconWidget: Icon(
                                              Icons.delete_outlined,
                                              size: kIconSize,
                                            ),
                                            textWidget: Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 14),
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
                          task.taskDescription ?? 'No description.',
                          style: kTaskDescriptionTextStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            task.isBookmared
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: kIconSize,
                                    ),
                                  )
                                : Container(),
                            Text(
                              '${timeFormat(task.createdTime)}',
                              style: TextStyle(
                                fontSize: ktimeTextSize,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: Container(
            height: 65,
            width: 65,
            child: RawMaterialButton(
              fillColor: Colors.indigo,
              shape: CircleBorder(),
              elevation: 4,
              onPressed: () async {
                await DialogModel.buildTaskEditorDialog(
                  context: context,
                  formKey: _formKey,
                  taskTitleController: _taskTitleController,
                  taskDescriptionController: _taskDescriptionController,
                  time: DateTime.now(),                  
                );
                _taskTitleController.clear();
                _taskDescriptionController.clear();
                refreshTasks();
              
              },
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )));
  }

  PopupMenuItem<dynamic> buildPopupMenuItem(
      {final iconWidget, final textWidget, required final value}) {
    return PopupMenuItem(
      value: value,
      height: 50,
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

  String timeFormat(DateTime time) {
  
    String formattedDate = DateFormat('MMM d y– kk:mm').format(time);
    return formattedDate;
  }

  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
