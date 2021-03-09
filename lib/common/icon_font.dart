import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/cupertino.dart';

class IconFont{
  // 工厂模式
  factory IconFont() => _getInstance();
  static IconFont get instance => _getInstance();
  static IconFont _instance;
  IconFont._internal() {
    // 初始化
  }
  static IconFont _getInstance() {
    if (_instance == null) {
      _instance = new IconFont._internal();
    }
    return _instance;
  }
   Icon getIconWithData({int name = 0xe601,Color color = BYDColor.bydTextColor1,double size = 25}){
    IconData data = IconData(name,fontFamily: 'iconfont');
    return Icon(data,size: size,color: color,);
  }

}