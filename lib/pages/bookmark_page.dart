import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.indigo[400],
            title: Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Text(
                'Bookmarks',
                // style: TextStyle(color: Colors.black87),
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
      body: Center(
        child: Text('bookmarks'),
      )
    );
  }
}