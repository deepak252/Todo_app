import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/db/tasks_db.dart';
import 'package:todo_app/models/dialog_model.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';


const kHeadingTextStyle = TextStyle(
  color: Color(0xff6c40ff),
  fontWeight: FontWeight.bold,
  fontSize: 14,
);

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  List<Task> tasksDone = [];
  @override
  void initState() {
    super.initState();
    refreshTasks();
  }

  Future refreshTasks() async {
    print('Refreshing tasks');
    try {
      final allBookmarkedTasks = await TasksDB.instance.getTasksAllDone();

      tasksDone = allBookmarkedTasks ?? [];
    } catch (e) {
      print('Exception while refresh tasks: $e');
    }
    setState(() {});
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
              'History',
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
          itemCount: tasksDone.length,
          itemBuilder: (context, index) {
            final history = tasksDone[index];
            return CircularBorderCardWidget(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${history.taskTitle}',
                          style: TextStyle(
                              color: Color(0xff6c40ff),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      splashRadius: 20,
                      icon: Icon(
                        Icons.restore,
                        color: Colors.green,
                        size: kIconSize+5,
                      ),
                      onPressed: () {
                        Task task=history.copy(
                          isDone: false,
                        );
                        TasksDB.instance.update(task);
                        refreshTasks();
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      splashRadius: 20,
                      icon: Icon(
                        Icons.delete,
                        size: kIconSize+5,
                        color: Colors.red,
                      ),
                      onPressed: () async  {                        
                        await DialogModel.buildConfirmDeleteDialog(
                          context: context,
                          task: history,                         
                        );
                        refreshTasks();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  
  
  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
