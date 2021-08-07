import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/db/tasks_db.dart';
import 'package:todo_app/models/dialog_model.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_provider.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TextEditingController _taskTitleController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // late List<Task> tasks;
  // bool isLoading=false;
  // @override
  // void initState() {
  //   super.initState();
  //   refreshTasks();
  // }

  // @override
  // void dispose() {
  //   TasksDB.instance.close();
  //   super.dispose();
  // }

  // Future refreshTasks() async{
  //   setState(() {
  //     isLoading=true;
  //   });
  //   this.tasks=await TasksDB.instance.readAllTasks();
  //   setState(() {
  //     isLoading=false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
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
            itemCount: taskProvider.totalTasks,
            itemBuilder: (context, index) {
              final tasks = taskProvider.getTasks;
              return CircularBorderCardWidget(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    print('show task');
                    DialogModel.buildTaskViewerDialog(
                      context: context,
                      task: tasks[index],
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
                                  '${tasks[index].taskTitle}',
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
                                    onTap: () async {
                                      _taskTitleController.text =
                                          tasks[index].taskTitle;
                                      _taskDescriptionController.text =
                                          tasks[index].taskDescription ==
                                                  'No description'
                                              ? ''
                                              : tasks[index].taskDescription!;

                                      await DialogModel.buildTaskEditingDialog(
                                          context: context,
                                          taskProvider: taskProvider,
                                          formKey: _formKey,
                                          taskTitleController:
                                              _taskTitleController,
                                          taskDescriptionController:
                                              _taskDescriptionController,
                                          editTask: true,
                                          index: index,
                                          setState: () {
                                            setState(() {});
                                          },
                                          time: DateTime.now(),
                                          );
                                      _taskTitleController.clear();
                                      _taskDescriptionController.clear();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.edit, size: kIconSize),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
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
                                                taskProvider.markTaskAsDone(
                                                    tasks[index]);
                                                setState(() {});
                                                return;
                                              }
                                            case 1:
                                              if (tasks[index].isBookmared ==
                                                  true) {
                                                taskProvider.deleteBookmark(
                                                    tasks[index]);
                                                setState(() {});
                                              } else {
                                                taskProvider
                                                    .addBookmark(tasks[index]);
                                                setState(() {});
                                              }
                                              return;
                                            case 2:
                                              {
                                                taskProvider
                                                    .deleteTask(tasks[index]);
                                                setState(() {});
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
                                            iconWidget:
                                                tasks[index].isBookmared == true
                                                    ? Icon(
                                                        Icons
                                                            .bookmark_remove_outlined,
                                                        size: kIconSize,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .bookmark_add_outlined,
                                                        size: kIconSize,
                                                      ),
                                            textWidget: tasks[index]
                                                        .isBookmared ==
                                                    true
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
                          tasks[index].taskDescription ?? 'No description.',
                          style: kTaskDescriptionTextStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            tasks[index].isBookmared
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
                              '${minuteHour(tasks[index].time)}',
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
                // currentTime();
                await DialogModel.buildTaskEditingDialog(
                    context: context,
                    taskProvider: taskProvider,
                    formKey: _formKey,
                    taskTitleController: _taskTitleController,
                    taskDescriptionController: _taskDescriptionController,
                    time:DateTime.now(),
                    setState: () {
                      setState(() {});
                    },
                    );
                _taskTitleController.clear();
                _taskDescriptionController.clear();
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

  String minuteHour(DateTime time) {
    String hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    String minute=time.minute<10 ? '0${time.minute}' : '${time.minute}';
    // print('$hour:$minute');
    return '$hour:$minute';
  }

  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
