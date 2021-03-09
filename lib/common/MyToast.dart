
import 'package:carsimmaster/theme/byd/byd_color.dart';
/**
 *  MyToast.dart
 *
 *  Created by iotjin on 2020/02/25.
 *  description:  oktoast封装
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

const Color _bgColor = BYDColor.bydThemeColor;
const double _radius = 8.0;

class MyToast {
  static ToastFuture showText(
    String loadingText, {
    Duration duration,
    ToastPosition position,
  }) {
    return _showText(loadingText, duration, position);
  }

  static ToastFuture showSuccess(String text) => _showSuccess(text);

  static ToastFuture showError(String text) => _showError(text);

  static ToastFuture showInfo(String text) => _showInfo(text);

  static ToastFuture showLoadingText({String text = "加载中..."}) =>
      _showLoading(text);

  static void hideHUD() => dismissAllToast();
}

ToastFuture _showText(loadingText, duration, position) {
  var w = Container(
    constraints: BoxConstraints(minHeight: 140, minWidth: 140),
    margin: const EdgeInsets.all(80.0),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
    decoration: BoxDecoration(
      color: _bgColor,
      borderRadius: BorderRadius.circular(_radius),
    ),
    child: Text(
      loadingText,
      style: TextStyle(
        fontSize: 15,
        color: BYDColor.bydTextColor2,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
  );
  return showToastWidget(w, duration: duration, position: position);
}

ToastFuture _showLoading(String loadingText) {
  var w = Container(
    margin: const EdgeInsets.all(50.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: _bgColor,
      borderRadius: BorderRadius.circular(_radius),
    ),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(4.0),
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          if (loadingText != null)
            Text(
              loadingText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    ),
  );
  var bg = Container(
    width: 2000,
    height: 2000,
    color: Colors.transparent,
    child: Center(
      child: w,
    ),
  );

  return showToastWidget(
    bg,
    duration: Duration(seconds: 10),
    handleTouch: true,
  );
}

ToastFuture _showSuccess(loadingText) {
  var w = Container(
    margin: const EdgeInsets.all(50.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: _bgColor,
      borderRadius: BorderRadius.circular(_radius),
    ),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.check_circle_outline,
              size: 30,
              color: Colors.white,
            ),
          ),
          Text(
            loadingText,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
  return showToastWidget(w);
}

ToastFuture _showError(loadingText) {
  var w = Container(
    margin: const EdgeInsets.all(50.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: _bgColor,
      borderRadius: BorderRadius.circular(_radius),
    ),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.highlight_off,
              size: 30,
              color: Colors.white,
            ),
          ),
          Text(
            loadingText,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
  return showToastWidget(w);
}

ToastFuture _showInfo(loadingText) {
  var w = Container(
    margin: const EdgeInsets.all(50.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: _bgColor,
      borderRadius: BorderRadius.circular(_radius),
    ),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.info_outline,
              size: 30,
              color: Colors.white,
            ), //info_outline
          ),
          Text(
            loadingText,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
  return showToastWidget(w);
}
