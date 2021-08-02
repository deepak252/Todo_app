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


// void buildBottomSheet(BuildContext context) async {
//   await showModalBottomSheet(
//     context: context,
//     builder: (builder) {
//       return DraggableScrollableSheet(
//         expand: true,
//         initialChildSize: 0.5,
//         maxChildSize: 0.9,
//         minChildSize: 0.5,
//         builder: (_, controller) => InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12),
//             // height: 50,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 )),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 8.0),
//                     height: 4,
//                     width: 40,
//                     decoration: BoxDecoration(
//                         color: Colors.black87,
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView(
//                     controller: controller,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         // controller: controller,
//                         children: [
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             'CATEGORY',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           // FilterJobCategories(),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             'TYPES',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           // FilterJobCategories(),

//                           // filterButton(context),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//       // return Container();
//     },
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//   );
// }
