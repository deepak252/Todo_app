import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_provider.dart';
import 'package:todo_app/widgets/bottom_nav_bar_widget.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>TaskProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education',
      theme: ThemeData(
        
        primarySwatch: Colors.indigo,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    
          unselectedItemColor: Colors.indigoAccent[100],
          unselectedLabelStyle: TextStyle(
            color: Color(0xff6c40ff),
            fontSize: 12.0
          ),
          selectedLabelStyle: TextStyle(
            color: Color(0xff6c40ff),
            fontSize: 12.0
          ),
          selectedItemColor: Colors.indigo,
        )
      ),
      
      home: BottomNavBarWidget(),
      
    );
  }
}



