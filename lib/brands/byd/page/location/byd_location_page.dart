import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carsimmaster/brands/byd/page/control/byd_control_page.dart';
import 'package:carsimmaster/brands/byd/page/discover/byd_discover_page.dart';
import 'package:carsimmaster/brands/byd/page/location/byd_location_search_page.dart';
import 'package:carsimmaster/brands/byd/page/location/store/byd_location_store.dart';
import 'package:carsimmaster/brands/byd/page/me/page/byd_me_page.dart';
import 'package:carsimmaster/common/app_env.dart';
import 'package:carsimmaster/common/byd_dialog.dart';
import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/common/common_auth.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/common/byd_comfirm_dialog_hud.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:math' as math;
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

class BYDLocationPage extends StatefulWidget {
  @override
  _BYDLocationPageState createState() => _BYDLocationPageState();
}

class _BYDLocationPageState extends State<BYDLocationPage>
    with TickerProviderStateMixin {
  AmapController mapController;
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore();
  BYDLocationStore locationStore = BYDLocationStore();
  AmapSearch amapSearch = AmapSearch.instance;
  LatLng currentLatLng;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (ctx) {
                addMarkersToMap(currentLatLng, locationStore.keyWordToSearch);
                return AmapView(
                  mapType: MapType.Navi,
                  zoomLevel: 17,
                  showCompass: false,
                  showScaleControl: false,
                  showZoomControl: false,
                  onMapCreated: (controller) {
                    mapController = controller;
                    mapController.getLocation().then((latLng) async {
                      currentLatLng = latLng;
//                print("getLocation $value");
                      ///如果是测试环境，就写死坐标
                      bool isProd = AppEnv.isProductionEnv;
                      if (isProd == false) {
//                  latLng = LatLng(
//                    22.501278,
//                    113.894389,
//                  );
                      }
                      print("resultListinit");

                      ///在外国是否要改成parking
                      amapSearch
                          .searchAround(latLng, type: "", radius: 100000)
                          .then((resultList) {
                        locationStore.nearPois = resultList;
                        Poi poi = resultList.first;
                        print("title ${poi.title}");
                        print("address ${poi.address}");
                        print("poi ${poi.distance}");
                        Widget carIconImage = Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: BYDColor.bydBackgroundColor,
                                  ),
                                  height: 90,
                                  child: Flex(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Transform.rotate(
                                                angle: math.pi / 4,
                                                child: Icon(
                                                  Icons.navigation,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: 35,
                                                  child: Text(
                                                    S.of(context).navi,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                          color: BYDColor.bydThemeColor,
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Flex(
                                          direction: Axis.vertical,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
//                                                padding: EdgeInsets.only(
//                                                    left: 15, right: 15, top: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: AutoSizeText(
                                                          poi.title,
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: BYDColor
                                                                  .bydTextColor1,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    IconFont().getIconWithData(
                                                        name: 0xe6ae,
                                                        color: BYDColor
                                                            .bydThemeColor,
                                                        size: 18),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white),
                                                child: Text(
                                                  poi.distance.toString() +
                                                      "m " +
                                                      poi.provinceName +
                                                      poi.cityName +
                                                      poi.address,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: BYDColor
                                                          .bydTextColor2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color:
                                      BYDColor.bydThemeColor.withOpacity(0.1),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child:
                                        Image.asset(configStore.carIconImage),
                                  ),
                                ),
                              )
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
                                coordinate: LatLng(latLng.latitude + 0.001,
                                    latLng.longitude + 0.001),
                                widget: carIconImage));
                          }
                        }
                      });
                    });
                    print('requestForLocation');
                    return mapController?.showMyLocation(MyLocationOption(
                      show: true,
                    ));
                  },
                );
              },
            )),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 30,
            right: 30,
            height: 50,
            child: Container(
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
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {

                            //指定跳转的页面
                            return new BYDLocationSearchPage();
                          },
                        )).then((poi) {
                          mapController.clear();
                          ///当返回单个poi的时候，就不显示群pois。
                          if(poi != null){
                            locationStore.shouldShowSinglePOI = true;
                            mapController.addMarker(MarkerOption(
                              coordinate: poi.latLng,
                              title: poi.title + "." + poi.address,
                              // widget: IconFont().getIconWithData(
                              //     name: 0xe672, size: 25, color: BYDColor.bydThemeColor)

                              // widget: Container(width: 25,height: 25,color: Colors.red,)
                            ));
                          }
                        });
                      },
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
                  color: BYDColor.bydBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            )),
        Positioned(
          bottom: 35,
          left: 15,
          width: 38,
          height: 38.0 * 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(3.5),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 2)
                  ]),
                  width: 38,
                  height: 38,
                  child: Image.asset(
                      BYDConstants().getBydLocationImage("vehicle_hazard.png")),
                ),
                onTap: () {
                  BYDComfirmDialogHUD().showOperationDialog(
                      operationString: S.of(context).byd_hazard,
                      context: context);
                },
              ),
              GestureDetector(
                onTap: () async {
                  bool result =
                      await CommonAuth().startCommonAuthenticate(context);
                  if (result == true) {}
                },
                child: GestureDetector(
                  onTap: () {
                    BYDComfirmDialogHUD().showOperationDialog(
                        operationString: S.of(context).byd_hazard_horn,
                        context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.5),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                    width: 38,
                    height: 38,
                    child: Image.asset(BYDConstants()
                        .getBydLocationImage("vehicle_hazard_horn.png")),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BYDHUD
                      .bydShowGeneralDialog(context, this,
                          showLoading: true,
                          textString: S.of(context).locateVehicle + "...")
                      .then((value) {
                    mapController.showMyLocation(MyLocationOption());
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(3.5),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 2)
                  ]),
                  width: 38,
                  height: 38,
                  child: Image.asset(BYDConstants()
                      .getBydLocationImage("vehicle_get_location.png")),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 35,
          right: 15,
          width: 38,
          height: 38.0 * 2 + 1,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 2)
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                makeTapIcon(Icon(Icons.add), () {
                  mapController.zoomIn(animated: true);
                }),
                Expanded(
                    child: Container(
                  color: BYDColor.bydSeparatorColor,
                )),
                makeTapIcon(Icon(Icons.minimize), () {
                  mapController.zoomOut(animated: true);
                }),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  void addMarkersToMap(LatLng latLng, String keywordString) {
    print('_BYDLocationPageState.addMarkersToMap1 ${locationStore.shouldShowSinglePOI}');
    if (latLng == null || keywordString == null || keywordString.length == 0 || locationStore.shouldShowSinglePOI == true) {
      return;
    }

    mapController.clear();

    ///在外国是否要改成parking
    amapSearch
        .searchAround(currentLatLng, type: keywordString, radius: 100000)
        .then((resultList) {
      resultList.forEach((poi) {
        print(
            '_BYDLocationPageState.addMarkersToMap ${poi.distance}${poi.adName}');
        mapController.addMarker(MarkerOption(
          coordinate: poi.latLng,
          title: poi.title + "." + poi.address,
          // widget: IconFont().getIconWithData(
          //     name: 0xe672, size: 25, color: BYDColor.bydThemeColor)

          // widget: Container(width: 25,height: 25,color: Colors.red,)
        ));
      });
    });
  }

  void showOpeationDialog({String operationString}) {
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: operationString + S.of(context).byd_control_confirm_to_do,
        onConfirmTap: () {
          BYDHUD.bydShowGeneralDialog(context, this).then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: operationString + S.of(context).success);
          });
        },
        onCancelTap: () {});
  }

  Widget makeTapIcon(Icon icon, Function tapFunc) {
    return GestureDetector(
      onTap: tapFunc,
      child: Container(
        width: 38,
        height: 38,
        child: icon,
        color: BYDColor.bydBackgroundColor,
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
