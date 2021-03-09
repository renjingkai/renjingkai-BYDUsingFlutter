// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'byd_vehicle_config_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BYDVehicleConfigStore on _BYDVehicleConfigStore, Store {
  final _$bydModelAtom = Atom(name: '_BYDVehicleConfigStore.bydModel');

  @override
  BYDModel get bydModel {
    _$bydModelAtom.reportRead();
    return super.bydModel;
  }

  @override
  set bydModel(BYDModel value) {
    _$bydModelAtom.reportWrite(value, super.bydModel, () {
      super.bydModel = value;
    });
  }

  final _$carPlateStringAtom =
      Atom(name: '_BYDVehicleConfigStore.carPlateString');

  @override
  String get carPlateString {
    _$carPlateStringAtom.reportRead();
    return super.carPlateString;
  }

  @override
  set carPlateString(String value) {
    _$carPlateStringAtom.reportWrite(value, super.carPlateString, () {
      super.carPlateString = value;
    });
  }

  final _$powerConsumeAtom = Atom(name: '_BYDVehicleConfigStore.powerConsume');

  @override
  num get powerConsume {
    _$powerConsumeAtom.reportRead();
    return super.powerConsume;
  }

  @override
  set powerConsume(num value) {
    _$powerConsumeAtom.reportWrite(value, super.powerConsume, () {
      super.powerConsume = value;
    });
  }

  final _$powerTypeAtom = Atom(name: '_BYDVehicleConfigStore.powerType');

  @override
  PowerType get powerType {
    _$powerTypeAtom.reportRead();
    return super.powerType;
  }

  @override
  set powerType(PowerType value) {
    _$powerTypeAtom.reportWrite(value, super.powerType, () {
      super.powerType = value;
    });
  }

  final _$gasConsumeAtom = Atom(name: '_BYDVehicleConfigStore.gasConsume');

  @override
  num get gasConsume {
    _$gasConsumeAtom.reportRead();
    return super.gasConsume;
  }

  @override
  set gasConsume(num value) {
    _$gasConsumeAtom.reportWrite(value, super.gasConsume, () {
      super.gasConsume = value;
    });
  }

  final _$carIconImageAtom = Atom(name: '_BYDVehicleConfigStore.carIconImage');

  @override
  String get carIconImage {
    _$carIconImageAtom.reportRead();
    return super.carIconImage;
  }

  @override
  set carIconImage(String value) {
    _$carIconImageAtom.reportWrite(value, super.carIconImage, () {
      super.carIconImage = value;
    });
  }

  final _$vehicleFrameNumberAtom =
      Atom(name: '_BYDVehicleConfigStore.vehicleFrameNumber');

  @override
  String get vehicleFrameNumber {
    _$vehicleFrameNumberAtom.reportRead();
    return super.vehicleFrameNumber;
  }

  @override
  set vehicleFrameNumber(String value) {
    _$vehicleFrameNumberAtom.reportWrite(value, super.vehicleFrameNumber, () {
      super.vehicleFrameNumber = value;
    });
  }

  final _$rangeAtom = Atom(name: '_BYDVehicleConfigStore.range');

  @override
  String get range {
    _$rangeAtom.reportRead();
    return super.range;
  }

  @override
  set range(String value) {
    _$rangeAtom.reportWrite(value, super.range, () {
      super.range = value;
    });
  }

  final _$mileageAtom = Atom(name: '_BYDVehicleConfigStore.mileage');

  @override
  String get mileage {
    _$mileageAtom.reportRead();
    return super.mileage;
  }

  @override
  set mileage(String value) {
    _$mileageAtom.reportWrite(value, super.mileage, () {
      super.mileage = value;
    });
  }

  final _$isDoingActionAtom =
      Atom(name: '_BYDVehicleConfigStore.isDoingAction');

  @override
  bool get isDoingAction {
    _$isDoingActionAtom.reportRead();
    return super.isDoingAction;
  }

  @override
  set isDoingAction(bool value) {
    _$isDoingActionAtom.reportWrite(value, super.isDoingAction, () {
      super.isDoingAction = value;
    });
  }

  final _$actionNameAtom = Atom(name: '_BYDVehicleConfigStore.actionName');

  @override
  String get actionName {
    _$actionNameAtom.reportRead();
    return super.actionName;
  }

  @override
  set actionName(String value) {
    _$actionNameAtom.reportWrite(value, super.actionName, () {
      super.actionName = value;
    });
  }

  final _$uniqueKeyStringAtom =
      Atom(name: '_BYDVehicleConfigStore.uniqueKeyString');

  @override
  String get uniqueKeyString {
    _$uniqueKeyStringAtom.reportRead();
    return super.uniqueKeyString;
  }

  @override
  set uniqueKeyString(String value) {
    _$uniqueKeyStringAtom.reportWrite(value, super.uniqueKeyString, () {
      super.uniqueKeyString = value;
    });
  }

  final _$setCarPlateStringAsyncAction =
      AsyncAction('_BYDVehicleConfigStore.setCarPlateString');

  @override
  Future<dynamic> setCarPlateString(String valueString) {
    return _$setCarPlateStringAsyncAction
        .run(() => super.setCarPlateString(valueString));
  }

  final _$setCarIconImageAsyncAction =
      AsyncAction('_BYDVehicleConfigStore.setCarIconImage');

  @override
  Future<dynamic> setCarIconImage(String valueString) {
    return _$setCarIconImageAsyncAction
        .run(() => super.setCarIconImage(valueString));
  }

  final _$setVehicleFrameNumberAsyncAction =
      AsyncAction('_BYDVehicleConfigStore.setVehicleFrameNumber');

  @override
  Future<dynamic> setVehicleFrameNumber(String valueString) {
    return _$setVehicleFrameNumberAsyncAction
        .run(() => super.setVehicleFrameNumber(valueString));
  }

  final _$setBYDModelAsyncAction =
      AsyncAction('_BYDVehicleConfigStore.setBYDModel');

  @override
  Future<dynamic> setBYDModel(BYDModel model) {
    return _$setBYDModelAsyncAction.run(() => super.setBYDModel(model));
  }

  final _$loadCacheAsyncAction =
      AsyncAction('_BYDVehicleConfigStore.loadCache');

  @override
  Future<dynamic> loadCache() {
    return _$loadCacheAsyncAction.run(() => super.loadCache());
  }

  @override
  String toString() {
    return '''
bydModel: ${bydModel},
carPlateString: ${carPlateString},
powerConsume: ${powerConsume},
powerType: ${powerType},
gasConsume: ${gasConsume},
carIconImage: ${carIconImage},
vehicleFrameNumber: ${vehicleFrameNumber},
range: ${range},
mileage: ${mileage},
isDoingAction: ${isDoingAction},
actionName: ${actionName},
uniqueKeyString: ${uniqueKeyString}
    ''';
  }
}
