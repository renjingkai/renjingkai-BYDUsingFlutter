import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'byd_location_store.g.dart';


class BYDLocationStore extends _BYDLocationStore with _$BYDLocationStore{
// 工厂模式
factory BYDLocationStore() => _getInstance();
static BYDLocationStore get instance => _getInstance();
static BYDLocationStore _instance;
BYDLocationStore._internal() {
// 初始化
}
static BYDLocationStore _getInstance() {
if (_instance == null) {
_instance = new BYDLocationStore._internal();
}
return _instance;
}
}

abstract class _BYDLocationStore with Store {
  @observable
  String keyWordToSearch = "";

  @observable
  List<Poi> nearPois = [];

  @observable
  bool shouldShowSinglePOI = true;



}