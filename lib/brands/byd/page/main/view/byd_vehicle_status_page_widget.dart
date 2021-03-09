
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class MoreStatusTextWidget extends StatefulWidget {
  final String leftTextString;
  final String rightTextString;
  MoreStatusTextWidget({this.leftTextString,this.rightTextString});
  @override
  _MoreStatusTextWidgetState createState() => _MoreStatusTextWidgetState();
}

class _MoreStatusTextWidgetState extends State<MoreStatusTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 40,padding: EdgeInsets.symmetric(horizontal: 15),child: Row(
      children: [
        Text(widget.leftTextString),
        Expanded(child: SizedBox()),
        Text(widget.rightTextString,style: TextStyle(
          color: BYDColor.bydTextColor3
        ),),
      ],
    ),);
  }
}
