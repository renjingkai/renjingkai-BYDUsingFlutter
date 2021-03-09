import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

enum VehicleStatus {
  breakSystem,
  ebreak,
  abs,
  airbag,
  esp,
  steering,
  lowVoltage,
  power,
  tirePressure
}

class BYDVehicleStatusWidget extends StatefulWidget {
  final VehicleStatus vehicleStatus;
  BYDVehicleStatusWidget({this.vehicleStatus});
  @override
  _BYDVehicleStatusWidgetState createState() => _BYDVehicleStatusWidgetState();
}

class _BYDVehicleStatusWidgetState extends State<BYDVehicleStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: buildWidgets(widget.vehicleStatus),
    );
  }
  List<Widget> buildWidgets(VehicleStatus vehicleStatus){
    List<Widget> listWidget;
    switch(vehicleStatus){
      case VehicleStatus.breakSystem:
        listWidget = buildWidget(imageString: "byd_vehicle_status_break.png",textString: S.of(context).byd_vehicle_status_detect_break);
        break;
      case VehicleStatus.ebreak:
        listWidget = buildWidget(imageString: "byd_vehicle_status_ebreak.png",textString: S.of(context).byd_vehicle_status_detect_ebreak);
        break;
      case VehicleStatus.abs:
        listWidget = buildWidget(imageString: "byd_vehicle_status_abs.png",textString: S.of(context).byd_vehicle_status_detect_abs_system);
        break;
      case VehicleStatus.airbag:
        listWidget = buildWidget(imageString: "byd_vehicle_status_airbag.png",textString: S.of(context).byd_vehicle_status_detect_srs_system);
        break;
      case VehicleStatus.esp:
        listWidget = buildWidget(imageString: "byd_vehicle_status_esp.png",textString: S.of(context).byd_vehicle_status_detect_esp_system);
        break;
      case VehicleStatus.steering:
        listWidget = buildWidget(imageString: "byd_vehicle_status_steering_system.png",textString: S.of(context).byd_vehicle_status_detect_steering_system);
        break;
      case VehicleStatus.lowVoltage:
        listWidget = buildWidget(imageString: "byd_vehicle_status_low_voltage_system.png",textString: S.of(context).byd_vehicle_status_detect_low_voltage_system);
        break;
      case VehicleStatus.power:
        listWidget = buildWidget(imageString: "byd_vehicle_status_power_system.png",textString: S.of(context).byd_vehicle_status_detect_power_system);
        break;
      case VehicleStatus.tirePressure:
        listWidget = buildWidget(imageString: "byd_vehicle_status_tire_system.png",textString: S.of(context).byd_vehicle_status_detect_tire_pressure_system);
        break;
    }
    return listWidget;
  }
  List<Widget> buildWidget({String imageString,String textString}){
    return [ Expanded(
      flex: 4,
      child: Image.asset(
          BYDConstants().getBydImageHome(imageString)),
    ),
      Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textString,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300,color: BYDColor.bydTextColor1),
            ),
          )),];
  }
}
