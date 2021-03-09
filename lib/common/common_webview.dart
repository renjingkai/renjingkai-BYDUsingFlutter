import 'dart:async';

import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebPage extends StatefulWidget {
  final String urlString;
  CommonWebPage({this.urlString});
  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {
  WebViewController _webViewController;
  String _webtitle = '';
  Timer timer;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_webtitle.length == 0){
      _webtitle = S.of(context).loading + "...";
    }
    return Scaffold(
      appBar: _appBarView(),
      body: WebView(
        initialUrl: (widget.urlString),
        onPageFinished: (str) {
//          print("onPageFinished");
          timer.cancel();
          loadWebviewTitle();
        },
        onWebViewCreated: (WebViewController controller) async {
//          print('onWebViewCreated');
          this._webViewController = controller;
          timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
            loadWebviewTitle();
          });
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  Widget _appBarView() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width,
          50 + MediaQuery.of(context).padding.top),
      child: Container(
        height: 50 + MediaQuery.of(context).padding.top,
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      child: IconButton(
                        onPressed: () async {
                          bool canGoBack = await toBackPage();
//                          print('_CommonWebPageState._appBarView $canGoBack');
                          if (canGoBack == false) {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: BYDColor.bydThemeColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon:
                              Icon(Icons.close, color: BYDColor.bydThemeColor)),
                    )
                  ],
                )),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                height: 50,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: Center(
                  child: Text(
                    _webtitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void loadWebviewTitle() {
    _webViewController.evaluateJavascript("document.title").then((value) {
//      print("document.title $value");
      setState(() {
        _webtitle = value;
      });
    });
  }

  Future<bool> toBackPage() async {
    var canBack = await _webViewController?.canGoBack();
    if (canBack) {
      _webViewController?.goBack();
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
