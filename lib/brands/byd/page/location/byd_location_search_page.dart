import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:carsimmaster/brands/byd/page/location/store/byd_location_store.dart';
import 'package:carsimmaster/brands/byd/page/location/view/byd_location_search_page_history_result_cell.dart';
import 'package:carsimmaster/brands/byd/view/byd_main_page_widgets.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BYDLocationSearchPage extends StatefulWidget {
  @override
  _BYDLocationSearchPageState createState() => _BYDLocationSearchPageState();
}

class _BYDLocationSearchPageState extends State<BYDLocationSearchPage> {
  BYDLocationStore locationStore = BYDLocationStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 40),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: BYDColor.bydBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BYDColor.bydThemeColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Container(
            padding: EdgeInsets.only(top: 10),
            height: 40,
            child: Row(
              children: [
                Container(
                  width: 15,
                ),
                Icon(
                  Icons.search,
                  size: 25,
                  color: BYDColor.bydTextColor4,
                ),
                Container(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    onSubmitted: (str) {
                      if (str.length > 0) {
                        locationStore.keyWordToSearch = str;
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop();
                      }
                    },
                    onTap: () {},
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.blue.shade100,
                        hintText:
                            S.of(context).byd_location_search_placeholder),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: BYDColor.bydSeparatorColor2,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ),
      body: Container(
        color: BYDColor.bydBackgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              height: 85,
              child: Row(
                children: [
                  BYDMainPageExpanedIconTextWidget(
                    UniqueKey(),
                    imagePath: BYDConstants()
                        .getBydLocationImage("byd_charge_station.png"),
                    textString: S.of(context).charge_station,
                    onTap: () {
                      locationStore.shouldShowSinglePOI = false;
                      locationStore.keyWordToSearch =
                          S.of(context).charge_station;
                      Navigator.of(context).pop();
                    },
                  ),
                  BYDMainPageExpanedIconTextWidget(UniqueKey(), onTap: () {
                    locationStore.shouldShowSinglePOI = false;
                    locationStore.keyWordToSearch = S.of(context).gas_station;
                    Navigator.of(context).pop();
                  },
                      imagePath: BYDConstants()
                          .getBydLocationImage("byd_gas_station.png"),
                      textString: S.of(context).gas_station),
                  BYDMainPageExpanedIconTextWidget(UniqueKey(), onTap: () {
                    locationStore.shouldShowSinglePOI = false;
                    locationStore.keyWordToSearch = S.of(context).parking_lot;
                    Navigator.of(context).pop();
                  },
                      imagePath: BYDConstants()
                          .getBydLocationImage("byd_parking_lot.png"),
                      textString: S.of(context).parking_lot),
                  BYDMainPageExpanedIconTextWidget(UniqueKey(), onTap: () {
                    locationStore.shouldShowSinglePOI = false;
                    locationStore.keyWordToSearch =
                        S.of(context).service_station;
                    Navigator.of(context).pop();
                  },
                      imagePath:
                          BYDConstants().getBydLocationImage("byd_service.png"),
                      textString: S.of(context).service_station),
                  BYDMainPageExpanedIconTextWidget(UniqueKey(), onTap: () {
                    locationStore.shouldShowSinglePOI = false;
                    locationStore.keyWordToSearch =
                        S.of(context).car_wash_station;
                    Navigator.of(context).pop();
                  },
                      imagePath: BYDConstants()
                          .getBydLocationImage("byd_car_wash.png"),
                      textString: S.of(context).car_wash_station)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).nearest_poi,
                style: TextStyle(color: BYDColor.bydTextColor4, fontSize: 16),
              ),
              decoration: BoxDecoration(color: BYDColor.bydSeparatorColor2),
            ),
            Expanded(
                child: Container(
              color: BYDColor.bydSeparatorColor2,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: locationStore.nearPois.length + 1,
                  itemBuilder: (ctx, idx) {
                    if(idx < locationStore.nearPois.length){
                      Poi poi = locationStore.nearPois[idx];
                      return GestureDetector(onTap: (){
                        Navigator.of(context).pop(poi);
                      },child: BYDLocationSearchPageHistoryResultCell(poi: poi,));
                    }else{
                      return  Container(
                        color: BYDColor.bydBackgroundColor,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          locationStore.nearPois.length.toString() + S.of(context).results,
                          style: TextStyle(color: BYDColor.bydTextColor4),
                        ),
                      );
                    }
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
