import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class BYDHUD {
  static Future bydShowGeneralDialog(BuildContext context, dynamic whoUseThis,
      {Icon icon,
      String textString,
      Duration duration,
      bool showLoading = false}) {
    ///旋转控制器
    AnimationController _animationRotateController = AnimationController(
        upperBound: 0.07, duration: Duration(seconds: 3), vsync: whoUseThis);
    _animationRotateController.forward();
    if (textString == null) {
      textString = S.of(context).loading;
    }

    if (duration == null) {
      duration = Duration(seconds: 3);
    }
    if (icon == null) {
      icon = Icon(Icons.settings);
    }

    if (showLoading == true) {
      showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          final hudWidth = MediaQuery.of(context).size.width * 400 * 1080;
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(animation.value * 0.3),
            body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: BYDColor.bydBackgroundColor,
                  width: 150,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: RotationTransition(
                            turns: _animationRotateController,
                            child: FlareActor(
                              "assets/images/flare/byd_loading1.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "Aura",
                              callback: (str) {},
                            ),
                          )),
                      Container(
                        height: 10,
                      ),
                      Text(
                        textString,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
      return Future.delayed(duration, () {
        Navigator.of(context).pop();
      });
    }
    return Future.delayed(duration, () {});
  }
}
