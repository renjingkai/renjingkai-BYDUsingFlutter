import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'byd_vehicle_config_store.g.dart';

//class BYDVehicleConfigStore = _BYDVehicleConfigStore with _$BYDVehicleConfigStore;
enum BYDModel {
  BYDModelHanEV,
  BYDModelQingProEV,
  BYDModelSongClassic,
  BYDModelSongMaxDM,
  BYDModelSongPlus,
  BYDModelSongPro,
  BYDModelSongProDM,
  BYDModelSongProEV,
  BYDModelTang,
  BYDModelYuanEV,
  BYDModelE2,
}
enum PowerType{
  PowerTypeEV,
  PowerTypeHybrid,
  PowerTypeGas,
}
class BYDVehicleConfigStore extends _BYDVehicleConfigStore
    with _$BYDVehicleConfigStore {
  // 工厂模式
  factory BYDVehicleConfigStore() => _getInstance();
  static BYDVehicleConfigStore get instance => _getInstance();
  static BYDVehicleConfigStore _instance;
  BYDVehicleConfigStore._internal() {
    // 初始化
  }
  static BYDVehicleConfigStore _getInstance() {
    if (_instance == null) {
      _instance = new BYDVehicleConfigStore._internal();
    }
    return _instance;
  }
}

abstract class _BYDVehicleConfigStore with Store {
  String carPlateStringKey = "carPlateStringKey";
  String carIconImageKey = "carIconImageKey";
  String vehicleFrameNumberKey = "vehicleFrameNumberKey";
  String bydModelKey = "bydModelKey";


  @observable
  BYDModel bydModel = BYDModel.BYDModelHanEV;

  @observable
  String carPlateString = "粤BD18058";

  @observable
  num powerConsume = 12.8;

  @observable
  PowerType powerType = PowerType.PowerTypeEV;

  @observable
  num gasConsume = 1.5;

  @observable
  String carIconImage = "assets/images/byd/me/vehicleIcon/han_ev.png";

  @observable
  String vehicleFrameNumber = 'init';

  @observable
  String range = (0.88 * 550).toStringAsFixed(0);

  @observable
  String mileage = "8086";

  @observable
  bool isDoingAction = false;

  @observable
  String actionName = "";

  @observable
  String uniqueKeyString = "";

  @action
  Future setCarPlateString(String valueString)async{
    this.carPlateString = valueString;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(carPlateStringKey, this.carPlateString);
  }

  @action
  Future setCarIconImage(String valueString)async{
    this.carIconImage = valueString;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(carIconImageKey, this.carIconImage);
  }

  @action
  Future setVehicleFrameNumber(String valueString)async{
    this.vehicleFrameNumber = valueString;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(vehicleFrameNumberKey, this.vehicleFrameNumber);
  }

  @action
  Future setBYDModel(BYDModel model)async{
    this.bydModel = model;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(bydModelKey, this.bydModel.index);
    ///需要更新 动力类型、能耗、剩余里程续航
    await loadCache();



  }

  @action
  Future loadCache() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.getString(carPlateStringKey) != null){
      this.carPlateString = sp.getString(carPlateStringKey);
    }
    if(sp.getString(carIconImageKey) != null){
      this.carIconImage = sp.getString(carIconImageKey);
    }
    if(sp.getString(vehicleFrameNumberKey) != null){
      this.vehicleFrameNumber = sp.getString(vehicleFrameNumberKey);
    }
    if(sp.getInt(bydModelKey) != null){
      BYDModel model = BYDModel.values[sp.getInt(bydModelKey)];
//      print('_BYDVehicleConfigStore.loadCache------ $model');
      this.bydModel = model;
      switch (this.bydModel){
        case BYDModel.BYDModelE2:
          this.powerType = PowerType.PowerTypeEV;
          this.powerConsume = 9.8;
          this.range = (0.88 * 405).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelQingProEV:
          this.powerType = PowerType.PowerTypeEV;
          this.powerConsume = 12.6;
          this.range = (0.88 * 405).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelHanEV:
          this.powerType = PowerType.PowerTypeEV;
          this.powerConsume = 12.3;
          this.range = (0.88 * 550).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongClassic:
          this.powerType = PowerType.PowerTypeGas;
          this.gasConsume = 8.6;
          this.range = (0.88 * 550).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongMaxDM:
          this.powerType = PowerType.PowerTypeHybrid;
          this.gasConsume = 1.7;
          this.powerConsume = 12.3;
          this.range = (0.88 * 600).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongPlus:
          this.powerType = PowerType.PowerTypeGas;
          this.gasConsume = 8.1;
          this.range = (0.88 * 600).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongPro:
          this.powerType = PowerType.PowerTypeGas;
          this.gasConsume = 8.5;
          this.range = (0.88 * 550).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongProDM:
          this.powerType = PowerType.PowerTypeHybrid;
          this.gasConsume = 1.3;
          this.powerConsume = 12.3;
          this.range = (0.88 * 650).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelSongProEV:
          this.powerType = PowerType.PowerTypeEV;
          this.powerConsume = 13.3;
          this.range = (0.88 * 405).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelTang:
          this.powerType = PowerType.PowerTypeGas;
          this.gasConsume = 9.1;
          this.range = (0.88 * 580).toStringAsFixed(0).toString();
          break;
        case BYDModel.BYDModelYuanEV:
          this.powerType = PowerType.PowerTypeEV;
          this.powerConsume = 12.9;
          this.range = (0.88 * 410).toStringAsFixed(0).toString();
          break;
        default:
          this.powerType = PowerType.PowerTypeEV;
          break;
      }
    }
    this.mileage = (num.tryParse(this.range) * 38).toStringAsFixed(0).toString();

//    print('_BYDVehicleConfigStore.loadCache -- ${this.mileage}');
  }

}
