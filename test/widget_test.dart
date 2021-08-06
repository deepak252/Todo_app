// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// Future buildTaskEditingDialog({
  //   required BuildContext context,
  //   required  TaskProvider taskProvider,
  //   bool? editTask,int ? index,
  //   }) async {
  //   int descriptionTextCount=0;
  //   return await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Form(
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //           key: _formKey,
  //           child: Center(
  //             child: SingleChildScrollView(
  //               child: AlertDialog(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(16.0))
  //                 ),
  //                 // scrollable: true,
  //                 contentPadding:
  //                     EdgeInsets.only(left: 12,right:12,top:16,bottom: 8),
  //                 content: Column(
  //                   children: [
  //                     TextFormField(
  //                       validator: (value) {
  //                         if (value == null || value == '') {
  //                           return 'Task title is required';
  //                         }
  //                       },
  //                       controller: _taskTitleController,
  //                       decoration: InputDecoration(
  //                         hintText: 'Title',
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 12,
  //                     ),
  //                     Container(
  //                       padding: EdgeInsets.all(0),
  //                       height: 140,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.black54
  //                           ),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: TextField(
  //                           controller: _taskDescriptionController,
  //                           maxLines: null,
  //                           keyboardType: TextInputType.multiline,
  //                           decoration: InputDecoration(
  //                               hintText: "Description",
  //                               isCollapsed: true,
  //                               border: InputBorder.none,
  //                               contentPadding: EdgeInsets.all(6),
  //                               // counterText: '${_taskDescriptionController.text.length}'
  //                           ),
  //                           inputFormatters: [
  //                             LengthLimitingTextInputFormatter(100),
  //                           ],
  //                           onChanged: (value){
  //                             setState(() {
  //                               print(value.length);
  //                               descriptionTextCount = value.length;
  //                             });
  //                           },
  //                         ),
  //                     ),

  //                     SizedBox(
  //                       height: 12,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         IconButton(
  //                           padding: EdgeInsets.all(0),
  //                           splashRadius: 20,
  //                           icon: Icon(Icons.close,
  //                             color: Colors.red,
  //                           ),
  //                             onPressed: () async {
  //                               _taskTitleController.clear();
  //                               _taskDescriptionController.clear();
  //                               Navigator.of(context).pop();
  //                             },

  //                         ),
  //                         IconButton(
  //                           padding: EdgeInsets.all(0),
  //                           splashRadius: 20,
  //                           icon: Icon(
  //                             Icons.done,
  //                             color: Colors.green,),
  //                             onPressed: () async {
  //                               try {
  //                                 if (_formKey.currentState!.validate()) {
  //                                   final task=Task(
  //                                     taskTitle: _taskTitleController.text,
  //                                     taskDescription:_taskDescriptionController.text==''
  //                                                   ? 'No description'
  //                                                   : _taskDescriptionController.text,
  //                                     time: '12:40',
  //                                   );
  //                                   editTask==true ? taskProvider.editTask(task,index!)
  //                                                 : taskProvider.addTask(task);

  //                                   setState(() {});
  //                                   Navigator.of(context).pop();
  //                                 }
  //                               } catch (e) {
  //                                 print('error2: $e');
  //                                 Navigator.of(context).pop();
  //                               }
  //                             },

  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }