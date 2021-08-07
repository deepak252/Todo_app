import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/models/dialog_model.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_provider.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';

const kHeadingTextStyle = TextStyle(
  color: Color(0xff6c40ff),
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {

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
              'Bookmarks',
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
          itemCount: taskProvider.totalBookmarkedTasks,
          itemBuilder: (context, index) {
            final bookmarks = taskProvider.getBookMarkedTasks;
            return CircularBorderCardWidget(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              elevation: 3,
              child: InkWell(
                onTap: () {
                  DialogModel.buildTaskViewerDialog(
                    context: context, 
                    task: bookmarks[index],
                  );
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
                                '${bookmarks[index].taskTitle}',
                                style: kTaskTitleTextStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(5, -5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              
                              child: Material(
                                child: PopupMenuButton(
                                  onSelected: (value) {
                                    switch (value) {
                                      case 0:
                                        {
                                          taskProvider.deleteTask(bookmarks[index]);
                                          setState(() {});
                                          return;
                                        }
                                      case 1:
                                        {
                                          print('bookmarked');
                                          return;
                                        }
                                      case 2:
                                        {
                                          taskProvider.deleteTask(bookmarks[index]);
                                          setState(() {});
                                          return;
                                        }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: kIconSize+2,
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
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    buildPopupMenuItem(
                                      value: 1,
                                      iconWidget: Icon(
                                        Icons.bookmark_outline,
                                        size: kIconSize,
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
                                        size: kIconSize,
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
                          ),
                        ],
                      ),
                      Text(
                        bookmarks[index].taskDescription ?? 'No description.',
                        style: kTaskDescriptionTextStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          bookmarks[index].isBookmared
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
                            '${bookmarks[index].time}',
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

  
  void buildToast({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
