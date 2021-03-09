import 'dart:async';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carsimmaster/brands/byd/page/location/byd_location_page.dart';
import 'package:carsimmaster/brands/byd/page/main/byd_vehicle_status_page.dart';
import 'package:carsimmaster/brands/byd/page/me/page/byd_vehicle_change_page.dart';
import 'package:carsimmaster/brands/byd/view/byd_main_page_widgets.dart';
import 'package:carsimmaster/common/app_env.dart';
import 'package:carsimmaster/common/byd_dialog.dart';
import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/common/common_webview.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math' as math;

class BYDMainPage extends StatefulWidget {
  @override
  _BYDMainPageState createState() => _BYDMainPageState();
}

class _BYDMainPageState extends State<BYDMainPage>
    with TickerProviderStateMixin {
  AmapController mapController;
  String dateTimeString = "";
  final BYDVehicleConfigStore configStore = BYDVehicleConfigStore();
  ScrollController scrollController = ScrollController();
  num scale = 1.0;
  PermissionStatus permissionStatus;
  @override
  void initState() {
    updateRefreshTime();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    Permission.locationAlways.request().then((status) {
      permissionStatus = status;
      if (status == PermissionStatus.granted) {
//        print('_BYDMainPageState.initStatePermissionStatus.granted');
        buildMyVehicleLocationWidget(mapController, context);
      }
    });
    configStore.loadCache();
    scrollController.addListener(() {
      ///如果是下拉才显示缩放动画
      if (scrollController.offset < 0.0) {
        setState(() {
          scale = 1 - (scrollController.offset.abs() * 2) / 100.0;
          if (scale < 0.5) {
            scale = 0.5;
          }
        });
      }
    });
    super.initState();
  }

  void updateRefreshTime() {
    DateTime dateTime = DateTime.now();
    String monthString;
    String dayString;
    String hourString;
    if (dateTime.month < 10) {
      monthString = "0" + dateTime.month.toString();
    } else {
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

  @override
  Widget build(BuildContext context) {
//    print('_BYDMainPageState.builddfghjkfghjk');
    print(MediaQuery.of(context).size);
    Color greenAccent = Color.fromARGB(255, 84, 220, 15);
    double topHeight = configStore.powerType == PowerType.PowerTypeHybrid
        ? MediaQuery.of(context).size.height * 0.33
        : MediaQuery.of(context).size.height * 0.36;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Observer(
          builder: (context) {
            return EasyRefresh(
              scrollController: scrollController,
              header: ClassicalHeader(
                  refreshText: S.of(context).byd_refreshText,
                  refreshReadyText: S.of(context).byd_refreshReadyText,
                  refreshingText: S.of(context).byd_refreshingText,
                  refreshedText: S.of(context).byd_refreshedText,
                  refreshFailedText: S.of(context).byd_refreshFailedText),
              onRefresh: () {
                setState(() {
                  updateRefreshTime();
                });
                return Future.delayed(Duration(seconds: 2), () {});
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: 1050,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          height: topHeight,
//                      color: Colors.red,
                          child: Stack(
                            children: [
                              Positioned(
                                child: SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 2500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                                gradient:
                                                    SweepGradient(colors: [
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0),
                                                  greenAccent.withOpacity(0.01),
                                                  greenAccent.withOpacity(0.02),
                                                  greenAccent.withOpacity(0.06),
                                                  greenAccent.withOpacity(0.24),
                                                ]),
                                                value: 88,
                                                pointerOffset: 0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5)
                                          ],
                                          startAngle: 180,
                                          endAngle: 0,
                                          showTicks: false,
                                          showLabels: false,
                                          minimum: 0,
                                          maximum: 100,
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 88,
                                                color: greenAccent,
                                                startWidth: 10,
                                                endWidth: 10),
                                            GaugeRange(
                                                startValue: 88,
                                                endValue: 100,
                                                color: Color.fromARGB(
                                                    255, 224, 243, 219),
                                                startWidth: 10,
                                                endWidth: 10),
                                          ],
                                          annotations: <GaugeAnnotation>[])
                                    ]),
                                top: topHeight * 0.13,
                                left: MediaQuery.of(context).size.width * 0.07,
                                right: MediaQuery.of(context).size.width * 0.07,
                                bottom: -topHeight * 0.3,
                              ),
                              Positioned(
                                  top: 27 + MediaQuery.of(context).padding.top,
                                  right: 20,
                                  child: IconFont().getIconWithData(
                                      name: 0xef3d,
                                      color: BYDColor.bydTextColor2,
                                      size: 14)),
                              Positioned(
                                child: Opacity(
                                  opacity: 0.35,
                                  child: Container(
                                      decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        greenAccent,
                                        greenAccent.withOpacity(0.01)
                                      ],
//                                      transform:GradientRotation(0.1)
                                    ),
                                  )),
                                ),
                                top: topHeight * 0.71,
                                left: 0,
                                right: 0,
                                bottom: topHeight * 0.1,
                              ),
                              Positioned(
                                child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    child:
                                        Image.asset(configStore.carIconImage)),
                                top: MediaQuery.of(context).padding.top +
                                    topHeight * 0.25,
                                left: MediaQuery.of(context).size.width * 0.23,
                                right: MediaQuery.of(context).size.width * 0.23,
                                bottom: topHeight * 0.1,
                              ),
                              Positioned(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: [
                                    configStore.powerType !=
                                            PowerType.PowerTypeGas
                                        ? Transform.rotate(
                                            angle: -math.pi / 2,
                                            child: IconFont().getIconWithData(
                                                name: 0xe8cf,
                                                color: greenAccent,
                                                size: 19.0),
                                          )
                                        : Icon(
                                            Icons.local_gas_station,
                                            color: greenAccent,
                                            size: 26.0,
                                          ),
                                    Container(
                                      width: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '88',
                                          style: TextStyle(
                                              color: greenAccent,
                                              fontSize: 38,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: '%',
                                          style: TextStyle(
                                              color: greenAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                                top: MediaQuery.of(context).padding.top +
                                    topHeight * 0.15,
                                left: 0,
                                right: 0,
                                height: 40,
                              ),
                              Positioned(
                                child: Text(
                                  S.of(context).byd_refresh_in +
                                      " " +
                                      dateTimeString,
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: BYDColor.bydTextColor4),
                                ),
                                bottom: configStore.powerType == PowerType.PowerTypeHybrid ? topHeight * 0.07 :topHeight * 0.1 ,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                        ),
                        configStore.powerType == PowerType.PowerTypeHybrid
                            ? Container(
                          alignment: Alignment.topCenter,
                          height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Icon(
                                      Icons.local_gas_station,
                                      color: BYDColor.bydThemeColor,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: BYDColor.bydTextColor4
                                                      .withOpacity(0.3))),
                                          child: LinearProgressIndicator(
                                            minHeight: 13,
                                            backgroundColor:
                                                BYDColor.bydBackgroundColor,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                        Color>(
                                                    BYDColor.bydThemeColor),
                                            value: 0.83,
                                          ),
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '83',
                                          style: TextStyle(
                                              color: BYDColor.bydThemeColor,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: '%',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BYDColor.bydThemeColor,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        BYDMainPageNumberWidget(configStore),
                        Expanded(
                          flex: 1200,
                          child: Container(
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 240,
                                    child: GestureDetector(
                                      onTap: () {
                                        print("GestureDetectorGestureDetector");
                                      },
                                      child: AmapView(
                                        onMapClicked: (latlng) {
                                          print('_BYDMainPageState.buildkk');
                                        },
                                        mapType: MapType.Navi,
                                        zoomLevel: 16,
                                        showCompass: false,
                                        showScaleControl: false,
                                        onMapCreated: (controller) async {
                                          mapController = controller;
                                          await buildMyVehicleLocationWidget(
                                              controller, context);
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 240,
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("GestureDetectorkk");
                                        await AmapLocation.instance.init(
                                            iosKey:
                                                '3fd0355653988186e2edd8cd07974f03');
                                        AmapLocation.instance
                                            .listenLocation()
                                            .listen((event) {
                                          print("listenLocation $event");
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Colors.white.withOpacity(0),
                                              Colors.white.withOpacity(0),
                                              Colors.white.withOpacity(1.0),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 120,
                                    left: 15,
                                    right: 15,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                offset: Offset(0, -2),
                                                blurRadius: 3)
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: Column(
                                        children: [
                                          ///车辆控制
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: 40,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: BYDColor.bydThemeColor,
                                                  width: 4,
                                                  height: 15,
                                                ),
                                                Text(
                                                  "  " +
                                                      S
                                                          .of(context)
                                                          .byd_vehicle_control,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                ),
                                                Image.asset(
                                                    'assets/images/byd/home/byd_controls_change.png')
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 110,
                                            child: Row(
                                              children: [
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(), onTap: () {
                                                  showOpeationDialog(
                                                      context: context,
                                                      operationString: S
                                                          .of(context)
                                                          .byd_door_unlock);
                                                },
                                                    imagePath:
                                                        "assets/images/byd/home/byd_door_unlock.png",
                                                    textString: S
                                                        .of(context)
                                                        .byd_door_unlock),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(), onTap: () {
                                                  showOpeationDialog(
                                                      context: context,
                                                      operationString: S
                                                          .of(context)
                                                          .byd_door_lock);
                                                },
                                                    imagePath:
                                                        'assets/images/byd/home/byd_door_lock.png',
                                                    textString: S
                                                        .of(context)
                                                        .byd_door_lock),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(), onTap: () {
                                                  showOpeationDialog(
                                                      context: context,
                                                      operationString: S
                                                          .of(context)
                                                          .byd_ac_on);
                                                },
                                                    imagePath:
                                                        "assets/images/byd/home/byd_ac_on.png",
                                                    textString: S
                                                        .of(context)
                                                        .byd_ac_on),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(), onTap: () {
                                                  showOpeationDialog(
                                                      context: context,
                                                      operationString: S
                                                          .of(context)
                                                          .byd_ac_off);
                                                },
                                                    imagePath:
                                                        "assets/images/byd/home/byd_ac_off.png",
                                                    textString: S
                                                        .of(context)
                                                        .byd_ac_off)
                                              ],
                                            ),
                                          ),

                                          ///车辆状态
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: 40,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: BYDColor.bydThemeColor,
                                                  width: 4,
                                                  height: 15,
                                                ),
                                                Text(
                                                  "  " +
                                                      S
                                                          .of(context)
                                                          .byd_vehicle_status,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 110,
                                            child: Row(
                                              children: [
                                                BYDMainPageExpanedIconTextWidget(
                                                  UniqueKey(),
                                                  imagePath:
                                                      "assets/images/byd/home/byd_door_unlock.png",
                                                  textString:
                                                      S.of(context).byd_door,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              BYDVehicleStatusPage(
                                                                selectedIndex:
                                                                    0,
                                                              )),
                                                    );
                                                  },
                                                ),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(),
                                                    imagePath:
                                                        'assets/images/byd/home/byd_door_lock.png',
                                                    textString: S
                                                        .of(context)
                                                        .byd_pressure,
                                                    onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BYDVehicleStatusPage(
                                                              selectedIndex: 1,
                                                            )),
                                                  );
                                                }),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(),
                                                    imagePath:
                                                        "assets/images/byd/home/byd_ac_on.png",
                                                    textString: S
                                                        .of(context)
                                                        .byd_detect, onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BYDVehicleStatusPage(
                                                              selectedIndex: 2,
                                                            )),
                                                  );
                                                }),
                                                BYDMainPageExpanedIconTextWidget(
                                                    UniqueKey(),
                                                    imagePath:
                                                        "assets/images/byd/home/byd_ac_off.png",
                                                    textString: S
                                                        .of(context)
                                                        .byd_more, onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BYDVehicleStatusPage(
                                                              selectedIndex: 3,
                                                            )),
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular((8)),
                                                topRight: Radius.circular((8))),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CommonWebPage(
                                                            urlString:
                                                                "http://www.bydauto.com.cn/auto/carShow.html-param=%E6%B1%89EV",
                                                          )),
                                                );
                                              },
                                              child: Image.asset(
                                                BYDConstants()
                                                    .getBydImageCommercial(
                                                        'han_ev1.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void buildMyVehicleLocationWidget(
      AmapController controller, BuildContext context) async {
    AmapSearch amapSearch = AmapSearch.instance;
    if (permissionStatus != PermissionStatus.granted) {
      return;
    }
    print('_BYDMainPageState.buildMyVehicleLocationWidget $permissionStatus');
    mapController.getLocation().then((latLng) async {
      //
      ///在外国是否要改成parking
      amapSearch
          .searchAround(latLng, type: "", radius: 100000)
          .then((resultList) async {
        Poi poi = resultList.first;
        String str =
            poi.provinceName + poi.cityName + poi.address + poi.businessArea;
        //                                              print("tgbnmhjkhjkjkitle $str");
        //                                              print("addresskk ${poi.address}");
        //                                              print("poi ${poi.distance}");
        ///这样才可以正常显示位置text
        //                                             await controller.setCenterCoordinate(
        //                                                  LatLng(
        //                                                      poi.latLng.latitude,
        //                                                      poi.latLng.longitude),
        //                                                  zoomLevel: 19);
        await controller.setCenterCoordinate(
          LatLng(poi.latLng.latitude - 0.0021, poi.latLng.longitude),
        );
        Widget carIconImage = Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width * 0.68,
          height: 53,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: BYDColor.bydBackgroundColor,
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            poi.provinceName +
                                poi.cityName +
                                poi.address +
                                poi.businessArea,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: BYDColor.bydTextColor2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 10,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  width: 53,
                  height: 53,
                  //                                         child: Icon(Icons.local_taxi,color: Colors.lightBlueAccent,),
                  child: Image.asset(
                    configStore.carIconImage,
                    fit: BoxFit.contain,
                  ))
            ],
          ),
          //                    child:
          //                        Image.asset(BYDConstants().getBydImageHome("byd_vehicle_icon_in_map.jpg")),
        );

        //                  Widget carIconImage =
        //                  Image.asset(BYDConstants().getBydImageHome("box.png"));

        if (resultList != null) {
          if (resultList.length > 0) {
            String line1 = '';
            String line2 = '';
            Poi poi = resultList.first;
            print("resultList ${resultList}");
            print("title ${poi.title}");
            print("address ${poi.address}");
            print("poi ${poi}");
            if (poi.title != null) {
              if (poi.title.length > 0) {
                line1 = poi.title;
              }
            }

            if (poi.cityName != null) {
              if (poi.cityName.length > 0) {
                line2 = line2 + poi.cityName;
              }
            }
            if (poi.adName != null) {
              if (poi.adName.length > 0) {
                line2 = line2 + poi.adName;
              }
            }
            if (poi.address != null) {
              if (poi.address.length > 0) {
                line2 = line2 + poi.address;
              }
            }
            if (poi.distance != null) {
              //                        double distance = poi.distance > 1000 ? (poi.distance / 1000.0) : poi.distance;
              line1 = poi.distance.toString() + " m" + line1;
            }
            // print('_BYDMainPageState.buildMyVehicleLocationWidgetpoi $poi');
            mapController.addMarker(MarkerOption(
                coordinate: poi.latLng,
                widget: carIconImage,
                infoWindowEnabled: false));

            print("searchAroundLine $line1");
            print("searchAroundLine $line2");
            print("searchAroundLine $poi");
          } else {
            ///如果没有POI，比如在国外。
            mapController.addMarker(MarkerOption(
                coordinate:
                    LatLng(latLng.latitude + 0.001, latLng.longitude + 0.001),
                widget: carIconImage));
          }
        }
      });
    });
    mapController?.showMyLocation(MyLocationOption(
      fillColor: Colors.transparent,
      iconProvider:
          AssetImage(BYDConstants().getBydImageHome("transparent.png")),
      show: true,
    ));
  }

  void showOpeationDialog({String operationString = "", BuildContext context}) {
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: operationString + S.of(context).byd_control_confirm_to_do,
        onConfirmTap: () {
          print('_BYDMainPageState.showOpeationDialog $operationString');
          configStore.actionName = operationString;
          configStore.isDoingAction = true;
          Timer(Duration(seconds: 3), () {
            configStore.isDoingAction = false;
          });
          BYDHUD.bydShowGeneralDialog(context, this).then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: operationString + S.of(context).success);
          });
        },
        onCancelTap: () {});
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
