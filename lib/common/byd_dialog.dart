import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class BYDDialog {
  Function onConfirmTap;
  Function onCancelTap;
  BYDDialog(
      {BuildContext context,
      String confirmString = "",
      String cancelString,
      String detailString = "",
      Function onConfirmTap,
      Function onCancelTap}) {
    confirmString = S.of(context).confirm;
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        double font16 = 16.0;
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular((12))),
              color: BYDColor.bydBackgroundColor,
            ),
            padding: EdgeInsets.all(20),
            height: 120,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Material(
              color: BYDColor.bydBackgroundColor,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(detailString,
                          style: TextStyle(
                              fontSize: font16,
                              color: BYDColor.bydTextColor2,
                              fontWeight: FontWeight.w300)),
                    ],
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelString == null
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  if (onCancelTap != null) {
                                    onCancelTap();
                                  }
                                },
                                child: Text(
                                  cancelString,
                                  style: TextStyle(
                                      color: BYDColor.bydTextColor3,
                                      fontSize: font16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                        Container(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (onConfirmTap != null) {
                              onConfirmTap();
                            }
                          },
                          child: Text(
                            confirmString,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: font16,
                                color: BYDColor.bydThemeColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showTwoStepOperationDialog(BuildContext context,String operationString) {
    print("showTwoStepOperationDialog $context");
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: S.of(context).byd_door_lock +
            operationString,
        onConfirmTap: () {
          BYDHUD.bydShowGeneralDialog(context, this).then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: operationString);
          });
        },
        onCancelTap: () {});
  }
}

class DialogWithTwoStepOperation extends StatefulWidget  {
  final operationString;
  DialogWithTwoStepOperation(BuildContext context,this.operationString);
  @override
  _DialogWithTwoStepOperationState createState() => _DialogWithTwoStepOperationState();
}

class _DialogWithTwoStepOperationState extends State<DialogWithTwoStepOperation> {
  @override
  Widget build(BuildContext context) {
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: S.of(context).byd_door_lock +
            widget.operationString,
        onConfirmTap: () {
          BYDHUD.bydShowGeneralDialog(context, this).then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: widget.operationString);
          });
        },
        onCancelTap: () {});
    return Container();
  }
}




class OperationDialog{
  OperationDialog(BuildContext context,String operationString){
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: S.of(context).byd_door_lock +
            operationString,
        onConfirmTap: () {
          BYDHUD.bydShowGeneralDialog(context, this).then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: operationString);
          });
        },
        onCancelTap: () {});
  }
}