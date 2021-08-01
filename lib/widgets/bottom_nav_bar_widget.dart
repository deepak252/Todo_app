
import 'package:flutter/material.dart';
import 'package:todo_app/pages/history_page.dart';
import 'package:todo_app/pages/bookmark_page.dart';

import 'package:todo_app/pages/home_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({ Key? key }) : super(key: key);

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(      

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(20)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _index,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Bookmarks',   
                       
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
          
            ],
            onTap: (int index){
              setState(() {
                _index=index;
              });
            },
          ),
        ),
      ),
      body: selectedPage(),
      
    );
  }

  Widget selectedPage() {
    switch (_index) {
      case 0:
        return HomePage();
      case 1:
        return BookmarkPage();
      case 2:
        return HistoryPage();
      

      default:
        return Container();
    }
  }
}