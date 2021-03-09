///
///file name :webview_redpack_page
///created by :zcy
/// created on: 2019-12-27
///
/// h5春节红包活动容器
/// 在上层判断是否登录，此处直接加载h5红包页面
/// 从cookie中读取token返回给h5。
///
import 'dart:convert';
import 'dart:typed_data';


import 'package:carsimmaster/common/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


///
/// 活动页面

class ActivityPage extends StatefulWidget {
  final String activityUrl;

  const ActivityPage({Key key, this.activityUrl}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  WebViewController _webViewController;
  double _showRedPack = 1.0;
  FocusNode _focusNode;
  String _webtitle = "";
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode?.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: toBackPage,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: _showRedPack,
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0,
                        child: TextField(
                          focusNode: _focusNode,
                        ),
                      ),
                      WebView(
                        initialUrl: (widget.activityUrl),
                        onPageFinished: (str) {
                          setState(() {
                            _showLoading = false;
                          });
                          _webViewController
                              .evaluateJavascript("document.title")
                              .then((value) {
                            setState(() {
                              _webtitle =
                                  value.replaceAll(new RegExp("\""), "");
                            });
                          });
                        },
                        onWebViewCreated: (WebViewController controller) async {
                          this._webViewController = controller;
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                      Visibility(
                        visible: _showLoading,
                        child: Text('1234'),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: PreferredSize(

                      preferredSize: Size(MediaQuery.of(context).size.width, 50),
                    child: AppBar(
//                    iconColor: Theme.of(context).textTheme.display1.color,
                      backgroundColor: Theme.of(context).backgroundColor,
//                    backCallback: toHomePage,
                      centerTitle: true,
                      title: Text(
                        "${_webtitle}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future toHomePage() async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> toBackPage() async {
    var canBack = await _webViewController?.canGoBack();
    if (canBack) {
      _webViewController?.goBack();
      return Future.value(false);
    }
    return Future.value(true);
  }




}
