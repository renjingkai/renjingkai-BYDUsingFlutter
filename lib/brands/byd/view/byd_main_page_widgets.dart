import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BYDMainPageNumberWidget extends StatefulWidget {
  final BYDVehicleConfigStore configStore;
  BYDMainPageNumberWidget(this.configStore);

  @override
  _BYDMainPageNumberWidgetState createState() =>
      _BYDMainPageNumberWidgetState();
}

class _BYDMainPageNumberWidgetState extends State<BYDMainPageNumberWidget> {
  @override
  Widget build(BuildContext context) {
    String powerConsumeString = "";
    String last50kmConsumeString = "";
    String per100km = "";
    return Expanded(
      flex: 160,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            height: 10,
            color: BYDColor.bydSeparatorColor,
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                switch (this.widget.configStore.powerType) {
                  case PowerType.PowerTypeEV:
                    powerConsumeString =
                        this.widget.configStore.powerConsume.toStringAsFixed(1);
                    last50kmConsumeString =
                        S.of(context).byd_last_50km_ev_efficiency;
                    per100km = S.of(context).byd_kw_per_100km;
                    break;
                  case PowerType.PowerTypeHybrid:
                    powerConsumeString = this
                            .widget
                            .configStore
                            .powerConsume
                            .toStringAsFixed(1) +
                        " + " +
                        this.widget.configStore.gasConsume.toStringAsFixed(1);
                    last50kmConsumeString =
                        S.of(context).byd_last_50km_hev_efficiency;
                    per100km = S.of(context).byd_kw_l_per_100km;
                    break;
                  case PowerType.PowerTypeGas:
                    powerConsumeString =
                        this.widget.configStore.gasConsume.toStringAsFixed(1);
                    last50kmConsumeString =
                        S.of(context).byd_last_50km_gas_efficiency;
                    per100km = S.of(context).byd_l_per_100km;
                    break;
                }
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    ///续航 257 公里
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color:
                                        BYDColor.bydTextColor4.withOpacity(0.3),
                                    width: 1))),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).byd_range,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: BYDColor.bydTextColor3,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  this.widget.configStore.range,
                                  style: TextStyle(
                                      color: BYDColor.bydTextColor1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                Text(
                                  S.of(context).km,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: BYDColor.bydTextColor4),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    /// 最近50公里电耗
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color:
                                        BYDColor.bydTextColor4.withOpacity(0.3),
                                    width: 0.7))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: AutoSizeText(
                                last50kmConsumeString,
                                minFontSize: 8,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: BYDColor.bydTextColor3,
                                    fontWeight: FontWeight.w400),
                              ),
                              height: 20,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              height: 25,
                              child: AutoSizeText(
                                powerConsumeString,
                                minFontSize: 8,
                                maxLines: 1,
                                style: TextStyle(
                                    color: BYDColor.bydTextColor1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22),
                              ),
                            ),
                            AutoSizeText(
                              per100km,
                              style: TextStyle(
                                  fontSize: 15, color: BYDColor.bydTextColor4),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///总里程
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color:
                                        BYDColor.bydTextColor4.withOpacity(0.3),
                                    width: 0.7))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  S.of(context).byd_mileage,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: BYDColor.bydTextColor3,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  this.widget.configStore.mileage,
                                  style: TextStyle(
                                      color: BYDColor.bydTextColor1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                Text(
                                  S.of(context).km,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: BYDColor.bydTextColor4),
                                ),
                              ],
                            ),
                            Container(
                              width: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BYDMainPageExpanedIconTextWidget extends StatefulWidget {
  final imagePath;
  final textString;
  final onTap;
  bool shouldShowFlare = false;
  Key key;
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore();
  BYDMainPageExpanedIconTextWidget(this.key,
      {this.imagePath = '',
      this.textString = '',
      this.onTap,
      this.shouldShowFlare = false})
      : super(key: key);

  @override
  _BYDMainPageExpanedIconTextWidgetState createState() =>
      _BYDMainPageExpanedIconTextWidgetState();
}

class _BYDMainPageExpanedIconTextWidgetState
    extends State<BYDMainPageExpanedIconTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    Expanded buildExpandedIcon(String imagePath, String textString) {
    return Observer(
      builder: (x) {
//        print('_BYDMainPageExpanedIconTextWidgetState.build ${widget.configStore.isDoingAction}');
        if (widget.configStore.actionName == widget.textString) {
          widget.shouldShowFlare = widget.configStore.isDoingAction;
        }
//        print('_BYDMainPageExpanedIconTextWidgetState.initState ${widget.textString}');
        return Expanded(
          child: GestureDetector(
            onTap: () {
              Timer(Duration(seconds: 3), () {
                if (widget.shouldShowFlare == true) {
                  setState(() {
                    widget.shouldShowFlare = false;
                  });
                }
              });
              widget.onTap();
            },
            child: Column(
              children: [
                widget.shouldShowFlare == true
                    ? Container(
                        width: 50,
                        height: 50,
                        child: FlareActor(
                          "assets/images/flare/byd_loading1.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "Aura",
                          callback: (str) {},
                        ))
                    : Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(3),
                        child: Image.asset(
                          widget.imagePath,
                        ),
                      ),
                Text(
                  widget.textString,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BYDMainPageIconTextWidget extends StatefulWidget {
  final imagePath;
  final textString;
  final backgroundColor;
  final onTapFunc;
  BYDMainPageIconTextWidget(
      {this.imagePath = '',
      this.textString = '',
      this.backgroundColor = BYDColor.bydBackgroundColor,
      this.onTapFunc});

  @override
  _BYDMainPageIconTextWidgetState createState() =>
      _BYDMainPageIconTextWidgetState();
}

class _BYDMainPageIconTextWidgetState extends State<BYDMainPageIconTextWidget> {
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapFunc,
      child: Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: BYDColor.bydSeparatorColor2, width: 1),
            boxShadow: [
              BoxShadow(
                  color: BYDColor.bydSeparatorColor2,
                  offset: Offset(0, 2),
                  blurRadius: 5)
            ]),
        alignment: Alignment.center,
        child: FittedBox(child: Observer(
          builder: (context) {
            return Column(
              children: [
                configStore.isDoingAction &&
                        configStore.actionName == widget.textString
                    ? Container(
                        width: 50,
                        height: 50,
                        child: FlareActor(
                          "assets/images/flare/byd_loading1.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "Aura",
                          callback: (str) {},
                        ))
                    : Image.asset(
                        widget.imagePath,
                        height: 50,
                      ),
                Text(widget.textString),
              ],
            );
          },
        )),
      ),
    );
  }
}
