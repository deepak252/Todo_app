import 'package:flutter/material.dart';

class CircularBorderCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double ? radius;
  const CircularBorderCardWidget({ 
    Key? key ,
    required  this.child, 
    this.padding,
    this.elevation,
    this.radius  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      // height:200,
      child: Card(
          elevation: elevation,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 14),
          ),
          child: child),
    );
  }
}