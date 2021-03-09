import 'package:carsimmaster/brands/byd/view/byd_main_page_widgets.dart';
import 'package:carsimmaster/common/byd_dialog.dart';
import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BYDControlPage extends StatefulWidget {
  @override
  _BYDControlPageState createState() => _BYDControlPageState();
}

class _BYDControlPageState extends State<BYDControlPage>
    with TickerProviderStateMixin {
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore.instance;
  List<Container> buildGridList(int count) {
    return new List<Container>.generate(count, (int index) {
      switch (index) {
        case 0:
          return Container(
            child: BYDMainPageIconTextWidget(
              imagePath: "assets/images/byd/home/byd_door_unlock.png",
              textString: S.of(context).byd_door_lock,
              onTapFunc: () {
                showOpeationDialog(
                    operationString: S.of(context).byd_door_lock);
              },
            ),
          );
        case 1:
          return Container(
            child: BYDMainPageIconTextWidget(
                imagePath: "assets/images/byd/home/byd_door_unlock.png",
                textString: S.of(context).byd_door_unlock, onTapFunc: () {
              showOpeationDialog(
                  operationString: S.of(context).byd_door_unlock);
            },),
          );
        case 2:
          return Container(
            child: BYDMainPageIconTextWidget(
                imagePath: "assets/images/byd/home/byd_door_unlock.png",
                textString: S.of(context).byd_ac_on, onTapFunc: () {
              showOpeationDialog(
                  operationString: S.of(context).byd_ac_on);
            },),
          );
        case 3:
          return Container(
            child: BYDMainPageIconTextWidget(
                imagePath: "assets/images/byd/home/byd_door_unlock.png",
                textString: S.of(context).byd_ac_off, onTapFunc: () {
              showOpeationDialog(
                  operationString: S.of(context).byd_ac_off);
            },),
          );
        case 4:
          return Container(
            child: BYDMainPageIconTextWidget(
                imagePath: "assets/images/byd/home/byd_door_unlock.png",
                textString: S.of(context).byd_appointment_ac, onTapFunc: () {
              showOpeationDialog(
                  operationString: S.of(context).byd_appointment_ac);
            },),
          );
        case 5:
          return Container(
            child: BYDMainPageIconTextWidget(
              imagePath: "assets/images/byd/home/byd_door_unlock.png",
              textString: S.of(context).byd_hazard_horn,
              onTapFunc: () {
                showOpeationDialog(
                    operationString: S.of(context).byd_hazard_horn);
              },
            ),
          );
        case 6:
          return Container(
            child: BYDMainPageIconTextWidget(
              imagePath: "assets/images/byd/home/byd_door_unlock.png",
              textString: S.of(context).byd_hazard,
              onTapFunc: () {
                showOpeationDialog(
                    operationString: S.of(context).byd_hazard);
              },
            ),
          );
      }
      return Container(
        child: BYDMainPageIconTextWidget(
          imagePath: "assets/images/byd/home/byd_door_unlock.png",
          textString: S.of(context).byd_door_unlock,
          onTapFunc: () {
            showOpeationDialog(
                operationString: S.of(context).byd_door_unlock);
          },
        ),
      );
    });
  }
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  }

  void showOpeationDialog({String operationString}) {
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: operationString + S.of(context).byd_control_confirm_to_do,
        onConfirmTap: () {
          configStore.isDoingAction = true;
          configStore.actionName = operationString;
          Future.delayed(Duration(seconds: 3),(){
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

  Widget builGrid() {
    final space = 7.0;
    return new GridView.extent(
      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(space),
      mainAxisSpacing: space,
      crossAxisSpacing: space,
      children: buildGridList(7),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BYDColor.bydSeparatorColor,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8), child: builGrid()),
      ),
    );
  }
}
