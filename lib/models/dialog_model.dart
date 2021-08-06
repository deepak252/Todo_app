
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'task.dart';
import 'task_provider.dart';

class DialogModel{

    //**************EDIT TASK DIALOG*********************/

  static Future buildTaskEditingDialog({
    required BuildContext context,
    required TaskProvider taskProvider,
    required GlobalKey<FormState> formKey,
    required TextEditingController taskTitleController,
    required TextEditingController taskDescriptionController,
    required Function setState,
    required DateTime time,
    bool? editTask,
    int? index,
  }) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  // scrollable: true,
                  contentPadding:
                      EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
                  content: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Task title is required';
                          }
                        },
                        controller: taskTitleController,
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
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: taskDescriptionController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Description",
                            isCollapsed: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6),
                            // counterText: '${taskDescriptionController.text.length}'
                          ),
                          // inputFormatters: [
                          //   LengthLimitingTextInputFormatter(100),
                          // ],
                          
                        ),
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
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              taskTitleController.clear();
                              taskDescriptionController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(0),
                            splashRadius: 20,
                            icon: Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                            onPressed: () async {
                              try {
                                if (formKey.currentState!.validate()) {
                                  final task = Task(
                                    taskTitle: taskTitleController.text,
                                    taskDescription:
                                        taskDescriptionController.text == ''
                                            ? 'No description'
                                            : taskDescriptionController.text,
                                    time: time,
                                  );
                                  editTask == true
                                      ? taskProvider.editTask(task, index!)
                                      : taskProvider.addTask(task);
                                  setState();
                                  // setState(() {});
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
              ),
            ),
          );
        });
  }
    //**************VIEW TASK DIALOG*********************/
  static Future buildTaskViewerDialog({
    required BuildContext context, 
    required Task task}) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            scrollable: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  task.taskDescription ?? 'No Description',
                  style: TextStyle(
                    color: Color(0xff32374f),
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

}