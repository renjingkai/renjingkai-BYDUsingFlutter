import 'package:carsimmaster/common/byd_dialog.dart';
import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:flutter/material.dart';

class BYDComfirmDialogHUD extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
  void showOperationDialog({String operationString, BuildContext context}) {
    BYDDialog(
        context: context,
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        detailString: operationString + S.of(context).byd_control_confirm_to_do,
        onConfirmTap: () {
          BYDHUD
              .bydShowGeneralDialog(context, this,
                  showLoading: true,
                  textString: S.of(context).ing + operationString + "...")
              .then((value) {
            BYDDialog(
                context: context,
                confirmString: S.of(context).confirm,
                detailString: operationString + S.of(context).success);
          });
        },
        onCancelTap: () {});
  }
}
