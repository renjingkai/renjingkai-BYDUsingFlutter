import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class BYDLocationSearchPageHistoryResultCell extends StatelessWidget {
   final poi;
   BYDLocationSearchPageHistoryResultCell({
    this.poi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(poi.title,style: TextStyle(
              color: BYDColor.bydTextColor1,
              fontSize: 18
          ),textAlign: TextAlign.left,),
          Text(poi.address,style: TextStyle(
              color: BYDColor.bydTextColor4,
              fontSize: 14
          ),textAlign: TextAlign.left,),
          Container(
            height: 1,
            color: BYDColor.bydSeparatorColor2,
          )
        ],
      ),
      decoration: BoxDecoration(
          color: BYDColor.bydBackgroundColor
      ),
    );
  }
}