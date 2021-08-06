import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_provider.dart';
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
          itemCount: taskProvider.totalTasksHistory,
          itemBuilder: (context, index) {
            final history = taskProvider.getTasksHistory;
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
                          '${history[index].taskTitle}',
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
                        taskProvider.unduDoneTask(history[index]);
                        setState(() {
                          
                        });
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
                        await buildConfirmDeleteDialog(
                          context: context,
                          task: history[index],
                          taskProvider: taskProvider
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  
  Future buildConfirmDeleteDialog({
    required BuildContext context,
    required TaskProvider taskProvider,
    required Task task}) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            scrollable: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [                
                Text(
                  'Delete!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Task: ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '${task.taskTitle}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ]
                    ),
                  )
                ),
                SizedBox(
                  height: 12,
                ), 
                Row(
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text('Cancel'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black54,
                        primary: Colors.white,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        taskProvider.deleteHistory(task);
                        setState(() {
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        primary: Colors.white,
                      ),
                    ),
                  ],
                )               
                
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
