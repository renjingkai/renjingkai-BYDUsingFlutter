import 'package:carsimmaster/brands/byd/page/login/login_page.dart';
import 'package:carsimmaster/brands/byd/page/me/page/byd_vehicle_change_page.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BYDMePage extends StatefulWidget {
  @override
  _BYDMePageState createState() => _BYDMePageState();
}

class _BYDMePageState extends State<BYDMePage> {
  final BYDVehicleConfigStore configStore = BYDVehicleConfigStore();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
//    configStore.loadConfig(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                    Positioned(
                    child: Image.asset(BYDConstants().getBydImageMe("me_top_banner_background.png"),fit: BoxFit.cover,),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                ),
                        Observer(
                          builder: (_){
//                            print("heyeyeyeye ${configStore.carIconImage}");
                            return Positioned(
                              child: Image.asset(configStore.carIconImage),
                              top: MediaQuery.of(context).padding.top,
                              left: MediaQuery.of(context).size.width * 0.2,
                              right: MediaQuery.of(context).size.width * 0.2,
                              bottom: 50,
                            );
                          },
                        ),
                        Observer(builder: (_) {
                          print("heyeyeyeye ${configStore.carPlateString} ${configStore.vehicleFrameNumber}");
                          return Positioned(
                            child: Text(
                              configStore.carPlateString,
                              textAlign: TextAlign.center,
                            ),
                            bottom: 20,
                            width: MediaQuery.of(context).size.width,
                          );
                        })
                      ],
                    )),
              ),
              Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          //指定跳转的页面
                          return BYDVehicleChangePage();
                        },
                      ));
                    },
                    icon: Icon(Icons.swap_horizontal_circle,color: BYDColor.bydTextColor4,),
                  ),
                  top: 5 + MediaQuery.of(context).padding.top,
                  right: 20)
            ],
          ),
        ),
        Container(
          height: 20,
          color: BYDColor.bydSeparatorColor2,
        ),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          color: BYDColor.bydSeparatorColor2,
          child: Column(
            children: [
              buildCell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        //指定跳转的页面
                        return LoginPage();
                      },
                    ));
                  },
                  image: IconFont().getIconWithData(name: 0xe606,color: BYDColor.bydTextColor1,size: 18.0),
                  string: S.of(context).byd_account_safety),
              buildCell(
                  onTap: () {},
                  image: Image.asset(BYDConstants().getBydImageMe("vehicle_info.png"),width:20, height: 20,),
                  string: S.of(context).byd_vehicle_info),
              buildCell(
                  onTap: () {},
                  image: IconFont().getIconWithData(name: 0xe874,color: BYDColor.bydTextColor1,size: 18.0),
                  string: S.of(context).setting),
              buildCell(
                  onTap: () {},
                  image: IconFont().getIconWithData(name: 0xe609,color: BYDColor.bydTextColor1,size: 18.0),
                  string: S.of(context).byd_about_us),
              buildCell(
                  onTap: () {},
                  image: IconFont().getIconWithData(name: 0xe718,color: BYDColor.bydTextColor1,size: 16.0),
                  string: S.of(context).byd_help_feedback),
            ],
          ),
        ))
      ],
    ));
  }

  Container buildCell({Function onTap, dynamic image, String string}) {
    return Container(
      color: BYDColor.bydBackgroundColor,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 47,
              child: Row(
                children: [
                  image,
                  Text( "  " + string),
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: BYDColor.bydTextColor4,
                    size: 13,
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: BYDColor.bydSeparatorColor2,
            )
          ],
        ),
      ),
    );
  }
}
