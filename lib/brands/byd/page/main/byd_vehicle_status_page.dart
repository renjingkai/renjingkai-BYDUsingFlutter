import 'package:carsimmaster/brands/byd/page/discover/view/byd_energy_rank_widgets.dart';
import 'package:carsimmaster/brands/byd/page/main/view/byd_vehicle_status_detect_icon_text_widget.dart';
import 'package:carsimmaster/brands/byd/page/main/view/byd_vehicle_status_page_widget.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BYDVehicleStatusPage extends StatefulWidget {
  final int selectedIndex;
  BYDVehicleStatusPage({this.selectedIndex = 0});
  @override
  _BYDVehicleStatusPageState createState() => _BYDVehicleStatusPageState();
}

class _BYDVehicleStatusPageState extends State<BYDVehicleStatusPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  var tabTitles = ['1', '2', '3', '4'];
  int selectedIndexVar;
  String dateTimeString = "";
  @override
  Widget build(BuildContext context) {
    tabTitles = [
      S.of(context).byd_door,
      S.of(context).byd_pressure,
      S.of(context).byd_detect,
      S.of(context).byd_more
    ];
    return Scaffold(
      appBar: _appBarView(),
//      body: _tabBar(),

      body: Column(
        children: [
          Container(height: 75, child: _tabBar()),
          Expanded(child: _tabBarView()),
        ],
      ),
    );
  }

  @override
  void initState() {
    mController = TabController(
      length: tabTitles.length,
      vsync: this,
    );

    print('_BYDVehicleStatusPageState.initState ${widget.selectedIndex}');

    selectedIndexVar = widget.selectedIndex;
    mController.index = widget.selectedIndex;
    super.initState();
  }

  void updateRefreshTime() {
    DateTime dateTime = DateTime.now();
    String monthString;
    String dayString;
    String hourString;
    if(dateTime.month<10){
      monthString = "0" + dateTime.month.toString();
    }else{
      monthString = dateTime.month.toString();
    }
    if (dateTime.day < 10) {
      dayString = "0" + dateTime.day.toString();
    } else {
      dayString = dateTime.day.toString();
    }
    if (dateTime.hour < 10) {
      hourString = "0" + dateTime.hour.toString();
    } else {
      hourString = dateTime.hour.toString();
    }
    dateTimeString = monthString +
        "-" +
        dayString +
        " " +
        hourString +
        ":" +
        (dateTime.minute < 10
            ? ("0" + dateTime.minute.toString())
            : dateTime.minute.toString());
  }

  Widget _appBarView() {
    updateRefreshTime();
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: AppBar(
        backgroundColor: BYDColor.bydBackgroundColor,
        centerTitle: true,
        title: Container(
          child: Column(
            children: [
              Text(
                S.of(context).byd_vehicle_status,
                style: TextStyle(
                    color: BYDColor.bydTextColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                S.of(context).byd_refresh_in + " " + dateTimeString,
                style: TextStyle(
                    color: BYDColor.bydTextColor3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: BYDColor.bydThemeColor,
            )),
        elevation: 0,
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
        color: BYDColor.bydBackgroundColor,
//        boxShadow: [
//          BoxShadow(
//              color: Colors.black.withOpacity(0.8),
//              offset: Offset(0, 3),
//              blurRadius: 2,
//              spreadRadius: 2)
//        ],
      ),
      child: Column(
        children: [
          TabBar(
              onTap: (index) {
                print('_BYDVehicleStatusPageState._tabBar $index');

                ///要延时下才能
                Future.delayed(Duration(milliseconds: 1000), () {
                  setState(() {
                    selectedIndexVar = index;
                  });
                });
              },
              //设置tab是否可水平滑动
              isScrollable: true,
              //控制器
              indicatorColor: BYDColor.bydThemeColor,
              controller: mController,
              //设置tab文字得类型
              labelStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              //设置tab选中得颜色
              labelColor: BYDColor.bydThemeColor,
              //设置tab未选中得颜色
              unselectedLabelColor: BYDColor.bydTextColor1,
              //设置自定义tab的指示器，CustomUnderlineTabIndicator
              //若不需要自定义，可直接通过
              //indicatorColor 设置指示器颜色
              //indicatorWight 设置指示器厚度
              //indicatorPadding
              //indicatorSize  设置指示器大小计算方式
//        indicator: Container(),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 22),
              tabs: tabTitles.map((item) {
//                print('itemhaha $item');
                return Container(
                    width: MediaQuery.of(context).size.width / (6),
                    child: Tab(text: item));
              }).toList()),
          PreferredSize(
            child: Container(
              height: 2.5,
              color: BYDColor.bydSeparatorColor2,
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 5),
          ),
        ],
      ),
    );
  }

  Widget _tabBarView() {
    return Container(
      color: BYDColor.bydBackgroundColor,
      child: TabBarView(
        controller: mController,
        children: tabTitles.map((item) {
          return EasyRefresh(
              header: ClassicalHeader(
                  refreshText: S.of(context).byd_refreshText,
                  refreshReadyText: S.of(context).byd_refreshReadyText,
                  refreshingText: S.of(context).byd_refreshingText,
                  refreshedText: S.of(context).byd_refreshedText,
                  refreshFailedText: S.of(context).byd_refreshFailedText
              ),
              onRefresh: () {
//            print('onRefresh');
                return Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    updateRefreshTime();
                  });
                });
              },
              child: buildListView(context, selectedIndexVar));
        }).toList(),
      ),
    );
  }
}

Widget buildListView(BuildContext context, int index) {
  print('buildListView $index');
  Widget listviewWidegt = ListView();
  double imageSize = MediaQuery.of(context).size.width;
  switch (index) {
    case 0:
      listviewWidegt = ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom) -
                127.5,
            color: BYDColor.bydBackgroundColor,
            alignment: Alignment.center,
            child: Container(
//              color: Colors.red,
              height: imageSize,
              width: imageSize,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(BYDConstants()
                        .getBydImageHome("byd_vehicle_status_doors.png")),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  Positioned(
                      top: imageSize * 0.205,
                      left: imageSize * 0.06,
                      child: Text(
                          S.of(context).byd_vehicle_status_left_front_door +
                              ":" +
                              S.of(context).off)),
                  Positioned(
                      top: imageSize * 0.205,
                      left: imageSize * (1 - 0.23),
                      child: Text(
                          S.of(context).byd_vehicle_status_right_front_door +
                              ":" +
                              S.of(context).off)),
                  Positioned(
                      top: imageSize * (1 - 0.5),
                      left: imageSize * 0.06,
                      child: Text(
                          S.of(context).byd_vehicle_status_left_back_door +
                              ":" +
                              S.of(context).off)),
                  Positioned(
                      top: imageSize * (1 - 0.5),
                      left: imageSize * (1 - 0.23),
                      child: Text(
                          S.of(context).byd_vehicle_status_right_front_door +
                              ":" +
                              S.of(context).off)),
                ],
              ),
            ),
          )
        ],
      );
      break;
    case 1:
      listviewWidegt = ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom) -
                127.5,
            color: BYDColor.bydBackgroundColor,
            alignment: Alignment.center,
            child: Container(
//              color: Colors.red,
              height: imageSize,
              width: imageSize,
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(BYDConstants()
                        .getBydImageHome("byd_vehicle_status_tires.png")),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  Positioned(
                      top: imageSize * 0.205,
                      left: imageSize * 0.07,
                      child: Text(S.of(context).normal)),
                  Positioned(
                      top: imageSize * 0.205,
                      left: imageSize * (1 - 0.16),
                      child: Text(S.of(context).normal)),
                  Positioned(
                      top: imageSize * (1 - 0.35),
                      left: imageSize * 0.07,
                      child: Text(S.of(context).normal)),
                  Positioned(
                      top: imageSize * (1 - 0.35),
                      left: imageSize * (1 - 0.16),
                      child: Text(S.of(context).normal)),
                ],
              ),
            ),
          )
        ],
      );
      break;
    case 2:
//      SliverGridDelegate delegate = SliverGridDelegate.
      listviewWidegt = ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: BYDColor.bydSeparatorColor2),
                height: 44,
                child: Text(
                  "${S.of(context).abnormal}0${S.of(context).item}，${S.of(context).normal}9${S.of(context).item}",
                  style: TextStyle(
                      color: BYDColor.bydTextColor1,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          Container(
            height: 1000,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.breakSystem,
                    );
                    break;
                  case 1:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.ebreak,
                    );
                    break;
                  case 2:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.abs,
                    );
                    break;
                  case 3:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.airbag,
                    );
                    break;
                  case 4:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.esp,
                    );
                    break;
                  case 5:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.steering,
                    );
                    break;
                  case 6:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.lowVoltage,
                    );
                    break;
                  case 7:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.power,
                    );
                    break;
                  case 8:
                    return BYDVehicleStatusWidget(
                      vehicleStatus: VehicleStatus.tirePressure,
                    );
                    break;
                }
                return BYDVehicleStatusWidget(
                  vehicleStatus: VehicleStatus.breakSystem,
                );
              },
              itemCount: 9,
            ),
          )
        ],
      );
      break;
    case 3:
      listviewWidegt = ListView(
        children: [
          MoreStatusTextWidget(
            leftTextString: S.of(context).byd_vehicle_status_ok_indicator,
            rightTextString:
                S.of(context).byd_vehicle_status_ok_indicator_value_off,
          ),
          MoreStatusTextWidget(
            leftTextString: S.of(context).byd_vehicle_status_overall_status,
            rightTextString: S
                .of(context)
                .byd_vehicle_status_overall_status_value_anti_thief_status,
          ),
          MoreStatusTextWidget(
            leftTextString: S.of(context).byd_vehicle_status_speed,
            rightTextString: S.of(context).byd_vehicle_status_speed,
          ),
          MoreStatusTextWidget(
            leftTextString: S.of(context).byd_vehicle_status_power_gear,
            rightTextString:
                S.of(context).byd_vehicle_status_power_gear_value_off_gear,
          ),
          MoreStatusTextWidget(
            leftTextString:
                S.of(context).byd_vehicle_status_accumulate_average_consume,
            rightTextString:
                S.of(context).byd_vehicle_status_accumulate_average_consume,
          )
        ],
      );
      break;
  }
  return listviewWidegt;
}
