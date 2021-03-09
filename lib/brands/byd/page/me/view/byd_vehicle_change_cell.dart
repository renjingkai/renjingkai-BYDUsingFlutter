import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class BYDVehicleChangeCell extends StatefulWidget {
  final BYDModel bydModel;
  final carPlateString;
  final vehicleFrameString;
  final isSelected;
  BYDVehicleChangeCell(
      {this.carPlateString = '',
      this.vehicleFrameString = '',
        this.bydModel = BYDModel.BYDModelHanEV,
      this.isSelected = false});
  @override
  _BYDVehicleChangeCellState createState() => _BYDVehicleChangeCellState();
}

class _BYDVehicleChangeCellState extends State<BYDVehicleChangeCell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.carPlateString,
                    style: TextStyle(color: BYDColor.bydTextColor1, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.vehicleFrameString,
                    style: TextStyle(color: BYDColor.bydTextColor4, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.check_circle_outline,
                color: widget.isSelected
                    ? BYDColor.bydThemeColor
                    : BYDColor.bydTextColor4.withOpacity(0.4),
              ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: BYDColor.bydSeparatorColor2, width: 1),
              boxShadow: [
                BoxShadow(
                    color: BYDColor.bydSeparatorColor2,
                    offset: Offset(0, 2),
                    blurRadius: 5)
              ],
              color: BYDColor.bydBackgroundColor),
        ),
      ),
    );
  }
}
