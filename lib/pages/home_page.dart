
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_provider.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';


const kHeadingTextStyle = TextStyle(
  color: Color(0xff6c40ff),
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final taskProvider=Provider.of<TaskProvider>(context,listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Text(
                'Tasks',
              ),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            elevation: 6,
          ),
      ),
      body: ListView.builder(
        itemCount: taskProvider.totalTasks,
        itemBuilder: (context,index){
          return CircularBorderCardWidget(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            elevation: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${taskProvider.tasks[index].taskTitle}',
                      style: TextStyle(
                          color: Color(0xff6c40ff),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "We've created a college application timeline just for international students. Know what to do the year before you apply to college, while applying, and the summer before college begins.",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    maxLines: 4,
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }
}


// children: [
//           CircularBorderCardWidget(
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//             elevation: 3,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Text(
//                       'My Admissions',
//                       style: TextStyle(
//                           color: Color(0xff6c40ff),
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Text(
//                     "We've created a college application timeline just for international students. Know what to do the year before you apply to college, while applying, and the summer before college begins.",
//                     style: TextStyle(
//                       fontSize: 10,
//                     ),
//                     maxLines: 4,
//                   )
//                 ],
//               ),
//             ),
//           ),

