
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/circular_border_card_widget.dart';

const kHeadingTextStyle = TextStyle(
  color: Color(0xff6c40ff),
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

final List<String> carouselItems = [
  'assets/images/carousels/carousel1.jpg',
  'assets/images/carousels/carousel2.jpg',
  'assets/images/carousels/carousel3.jpg',
  'assets/images/carousels/carousel4.jpg',
];


class _HistoryPageState extends State<HistoryPage> {

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
                'History',
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
      body: ListView(
        children: [
        
          CircularBorderCardWidget(
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
                      'My Admissions',
                      style: TextStyle(
                          color: Color(0xff6c40ff), fontWeight: FontWeight.bold),
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
          ),
          
          Padding(
            padding: const EdgeInsets.only(left:12.0,right: 12.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Blogs for you',
                  style: kHeadingTextStyle,
                ),
                InkWell(
                  child: Text(
                    'View more',
                    style: kHeadingTextStyle,
                  ),
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget buildCardWidget({required String img, double? radius,double? height}) {
    return ClipRRect(
      child: Image.asset(
        img,
        fit: BoxFit.cover,
        height: height,
      ),
      borderRadius: BorderRadius.circular(radius?? 14),
    );
  }

  
}
