import 'package:auto_size_text/auto_size_text.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/helpers/material_color_helper.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:circular_custom_loader/circular_custom_loader.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BYDEnergyConsumptionRankListView extends StatefulWidget {
  @override
  _BYDEnergyConsumptionRankListViewState createState() =>
      _BYDEnergyConsumptionRankListViewState();
}

class _BYDEnergyConsumptionRankListViewState
    extends State<BYDEnergyConsumptionRankListView> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(
          refreshText: S.of(context).byd_refreshText,
          refreshReadyText: S.of(context).byd_refreshReadyText,
          refreshingText: S.of(context).byd_refreshingText,
          refreshedText: S.of(context).byd_refreshedText,
          refreshFailedText: S.of(context).byd_refreshFailedText),
      onRefresh: () {
        print('onRefresh');
        return Future.delayed(Duration(seconds: 1));
      },
      child: ListView(
        children: [
          Container(
            color: BYDColor.bydSeparatorColor,
            child: Column(
              children: [
                RecentRankWidget(),
                BYDRecentHundredKmExpenseWidget(),
                BYDDiscoverCummunitiveRankWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BYDDiscoverServiceAppointment extends StatefulWidget {
  @override
  _BYDDiscoverServiceAppointmentState createState() =>
      _BYDDiscoverServiceAppointmentState();
}

class _BYDDiscoverServiceAppointmentState
    extends State<BYDDiscoverServiceAppointment> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(
          refreshText: S.of(context).byd_refreshText,
          refreshReadyText: S.of(context).byd_refreshReadyText,
          refreshingText: S.of(context).byd_refreshingText,
          refreshedText: S.of(context).byd_refreshedText,
          refreshFailedText: S.of(context).byd_refreshFailedText),
      onRefresh: () {
        print('onRefresh');
        return Future.delayed(Duration(seconds: 1));
      },
      child: Container(
        color: BYDColor.bydBackgroundColor,
        child: Column(
          children: [
            Container(
              height: 13,
            ),
            Container(
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 44,
                          height: 44,
                          child: IconFont().getIconWithData(
                              name: 0xe60d, color: Colors.white)),
                      Text(
                        S.of(context).byd_make_appointment,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 44,
                          height: 44,
                          child: IconFont().getIconWithData(
                              name: 0xe607, color: Colors.white)),
                      Text(
                        S.of(context).byd_service_appointment,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))
                ],
              ),
              height: 65,
              decoration: BoxDecoration(color: BYDColor.bydThemeColor),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height - 500) / 2,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(
                BYDConstants().getBydImageDiscover(
                    "service_appointment_no_appointment.png"),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              S.of(context).byd_no_appointment,
              style: TextStyle(fontSize: 18, color: BYDColor.bydTextColor4),
            )
          ],
        ),
      ),
    );
    ;
  }
}

class RecentRankWidget extends StatefulWidget {
  @override
  _RecentRankWidgetState createState() => _RecentRankWidgetState();
}

class _RecentRankWidgetState extends State<RecentRankWidget> {
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore()..loadCache();
  Color greenAccent = BYDColor.greenAccent;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BYDColor.bydBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).byd_discover_recent_rank,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.45,
              child: Stack(
                children: [
                  Positioned(
                    child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        animationDuration: 2000,
                        axes: <RadialAxis>[
                          RadialAxis(
                              pointers: <GaugePointer>[],
                              startAngle: 270,
                              endAngle: 270,
                              showTicks: false,
                              showLabels: false,
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                  startValue: 0,
                                  endValue: 88,
                                  gradient: SweepGradient(colors: [
                                    Color.fromARGB(255, 99, 70, 255),
                                    Color.fromARGB(255, 186, 33, 237)
                                  ]),
                                ),
//                        GaugeRange(
//                            startValue: 88,
//                            endValue: 100,
//                            color: Color.fromARGB(255, 224, 243, 219),
//                            startWidth: 10,
//                            endWidth: 10),
                              ],
                              annotations: <GaugeAnnotation>[])
                        ]),
                  ),
                  Positioned(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '88',
                              style: TextStyle(
                                color: BYDColor.bydTextColor1,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w300),
                            ),
                            TextSpan(
                              text: '%',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: BYDColor.bydTextColor1,
                                  fontWeight: FontWeight.w300),
                            )
                          ]),
                        ),
                        Container(height: 5,),
                        Text(S.of(context).chaoguoquanguo),
                      ],
                    ),
                  ))
                ],
              )),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  BYDConstants().getBydImageDiscover('medal.png'),
                  width: 22,
                  height: 22,
                ),
                Text(
                  S.of(context).byd_discover_rank_praise,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: BYDColor.bydBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: Offset(0, 0),
                      blurRadius: 3,
                      spreadRadius: 3)
                ],
              ),
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    BYDConstants().getBydImageDiscover('rank.png'),
                    width: 25,
                    height: 25,
                  ),
                  Text(
                    S.of(context).byd_discover_rank,
                    style:
                        TextStyle(fontSize: 16, color: BYDColor.bydTextColor1),
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
              height: 100,
              child: Observer(
                builder: (context) {
                  var powerConsumeString;
                  var billString;
                  switch (configStore.powerType) {
                    case PowerType.PowerTypeEV:
                      powerConsumeString =
                          configStore.powerConsume.toStringAsFixed(1);
                      billString =
                          (configStore.powerConsume * 0.68).toStringAsFixed(2);
                      break;
                    case PowerType.PowerTypeHybrid:
                      powerConsumeString =
                          configStore.powerConsume.toStringAsFixed(1) +
                              " + " +
                              configStore.gasConsume.toStringAsFixed(1);
                      billString = (configStore.powerConsume * 0.68 +
                              configStore.gasConsume * 6)
                          .toStringAsFixed(2);
                      break;
                    case PowerType.PowerTypeGas:
                      powerConsumeString =
                          configStore.gasConsume.toStringAsFixed(1);
                      billString =
                          (configStore.gasConsume * 6).toStringAsFixed(2);
                      break;
                  }

                  return Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 180,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(powerConsumeString +
                                  S.of(context).byd_kw_per_100km),
                              Text(
                                S.of(context).byd_last_50km_ev_efficiency,
                                style: TextStyle(color: BYDColor.bydTextColor4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: BYDColor.bydTextColor4,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 180,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(billString + S.of(context).yuan),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).byd_recent_100km_expense,
                                    style: TextStyle(
                                        color: BYDColor.bydTextColor4),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconFont().getIconWithData(
                                      name: 0xe60b,
                                      color: BYDColor.bydTextColor4,
                                      size: 18.0)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}

class BYDRecentHundredKmExpenseWidget extends StatefulWidget {
  @override
  _BYDRecentHundredKmExpenseWidgetState createState() =>
      _BYDRecentHundredKmExpenseWidgetState();
}

class _BYDRecentHundredKmExpenseWidgetState
    extends State<BYDRecentHundredKmExpenseWidget> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> line1 = createLine1();
    Map<DateTime, double> line2 = createLine2();
    AreaLineChart lineChart = AreaLineChart.fromDateTimeMaps([
      line1
    ], [
      MaterialColorHelper().createMaterialColor(BYDColor.bydThemeColor)
    ], [
      S.of(context).byd_yuan_bracket
    ], gradients: [
      Pair(
          MaterialColorHelper()
              .createMaterialColor(BYDColor.bydThemeColor.withOpacity(0.3))
              .shade50,
          MaterialColorHelper()
              .createMaterialColor(BYDColor.bydThemeColor)
              .shade100)
    ]);

    return Container(
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BYDColor.bydBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).byd_discover_recent_100km_expense,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: IgnorePointer(
                ignoring: true,
                child: AnimatedLineChart(
                  lineChart,
                  key: UniqueKey(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  Map<DateTime, double> createLine1() {
//    Map<DateTime, double> data = {};
//    data[DateTime.now().subtract(Duration(minutes: 40))] = 13.0;
//    data[DateTime.now().subtract(Duration(minutes: 30))] = 12.4;
//    data[DateTime.now().subtract(Duration(minutes: 22))] = 11.6;
//    data[DateTime.now().subtract(Duration(minutes: 20))] = 11.9;
//    data[DateTime.now().subtract(Duration(minutes: 15))] = 12.1;
//    data[DateTime.now().subtract(Duration(minutes: 12))] = 12.0;
//    return data;
//  }

  Map<DateTime, double> createLine1() {
    Map<DateTime, double> data = {};
    data[DateTime.now().subtract(Duration(days: 7 * 6))] = 12.4;
    data[DateTime.now().subtract(Duration(days: 7 * 5))] = 12.4;
    data[DateTime.now().subtract(Duration(days: 7 * 4))] = 11.6;
    data[DateTime.now().subtract(Duration(days: 7 * 3))] = 11.9;
    data[DateTime.now().subtract(Duration(days: 7 * 2))] = 12.1;
    data[DateTime.now().subtract(Duration(days: 7 * 1))] = 12.0;
    return data;
  }

  Map<DateTime, double> createLine2() {
    Map<DateTime, double> data = {};
    data[DateTime.now().subtract(Duration(minutes: 40))] = 13.0;
    data[DateTime.now().subtract(Duration(minutes: 30))] = 12.4;
    data[DateTime.now().subtract(Duration(minutes: 22))] = 11.6;
    data[DateTime.now().subtract(Duration(minutes: 20))] = 11.9;
    data[DateTime.now().subtract(Duration(minutes: 15))] = 12.1;
    data[DateTime.now().subtract(Duration(minutes: 12))] = 12.0;
    return data;
  }
}

class BYDDiscoverCummunitiveRankWidget extends StatefulWidget {
  @override
  _BYDDiscoverCummunitiveRankWidgetState createState() =>
      _BYDDiscoverCummunitiveRankWidgetState();
}

class _BYDDiscoverCummunitiveRankWidgetState
    extends State<BYDDiscoverCummunitiveRankWidget> {
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore()..loadCache();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BYDColor.bydBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).byd_discover_recent_rank,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          Container(
            padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 10),
            height: 110,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                   flex: 2,
                    child: Stack(
                      children: [
                        Positioned(
                          child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 2000,
                              axes: <RadialAxis>[
                                RadialAxis(
                                    pointers: <GaugePointer>[],
                                    startAngle: 270,
                                    endAngle: 270,
                                    showTicks: false,
                                    showLabels: false,
                                    minimum: 0,
                                    maximum: 100,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        startValue: 0,
                                        endValue: 88,
                                        gradient: SweepGradient(colors: [
                                          Color.fromARGB(255, 99, 70, 255),
                                          Color.fromARGB(255, 186, 33, 237)
                                        ]),
                                      ),
//                        GaugeRange(
//                            startValue: 88,
//                            endValue: 100,
//                            color: Color.fromARGB(255, 224, 243, 219),
//                            startWidth: 10,
//                            endWidth: 10),
                                    ],
                                    annotations: <GaugeAnnotation>[])
                              ]),
                        ),
                        Positioned(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '88',
                                        style: TextStyle(
                                            color: BYDColor.bydTextColor1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      TextSpan(
                                        text: '%',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: BYDColor.bydTextColor1,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ]),
                                  ),
                                  Container(height: 5,),
                                  Text(S.of(context).chaoguoquanguo,style: TextStyle(
                                    fontSize: 12
                                  ),),
                                ],
                              ),
                            ))
                      ],
                    )),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 180,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Observer(
                              builder: (context) {
                                PowerType powerType = configStore.powerType;
                                String energyString = "";
                                switch (powerType) {
                                  case PowerType.PowerTypeEV:
                                    energyString =
                                        configStore.powerConsume.toString() +
                                            S.of(context).byd_kw_per_100km;
                                    break;
                                  case PowerType.PowerTypeGas:
                                    energyString =
                                        configStore.gasConsume.toString() +
                                            S.of(context).byd_l_per_100km;
                                    break;
                                  case PowerType.PowerTypeHybrid:
                                    energyString =
                                        configStore.powerConsume.toString() +
                                            S.of(context).byd_kw_per_100km +
                                            "+" +
                                            configStore.gasConsume.toString() +
                                            S.of(context).byd_l_per_100km;
                                    break;
                                }
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      energyString,
                                      maxFontSize: 14,
                                      minFontSize: 5,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      S
                                          .of(context)
                                          .byd_cumulative_average_consumption,
                                      style: TextStyle(
                                          color: BYDColor.bydTextColor4),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: BYDColor.bydTextColor4,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                            flex: 180,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Observer(
                                builder: (context) {
                                  PowerType powerType = configStore.powerType;
                                  num expense = 0;
                                  switch (powerType) {
                                    case PowerType.PowerTypeEV:
                                      expense = configStore.powerConsume * 0.68;
                                      break;
                                    case PowerType.PowerTypeGas:
                                      expense = configStore.gasConsume * 6;
                                      break;
                                    case PowerType.PowerTypeHybrid:
                                      expense =
                                          configStore.powerConsume * 0.68 +
                                              configStore.gasConsume * 6;
                                      break;
                                  }
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(expense
                                              .toStringAsFixed(2)
                                              .toString() +
                                          S.of(context).yuan),
                                      Text(
                                        S
                                            .of(context)
                                            .byd_cumulative_average_expense,
                                        style: TextStyle(
                                            color: BYDColor.bydTextColor4),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//class Pair<T, S> {
//  Pair(this.left, this.right);
//
//  final T left;
//  final S right;
//}

//调用的时候需要把hex改一下，比如#223344 needs change to 0xFF223344
//即把#换成0xFF即可
