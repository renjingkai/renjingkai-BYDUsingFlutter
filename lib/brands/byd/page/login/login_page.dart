import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/main.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isFirstLoad = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('_LoginPageState.didChangeDependencies');
    if (isFirstLoad == true) {
      isFirstLoad = false;
      Future.delayed(Duration(milliseconds: 500), () {
        BYDHUD
            .bydShowGeneralDialog(context, this,
                showLoading: true,
                textString: S.of(context).ing + S.of(context).login + "...")
            .then((value) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              //指定跳转的页面
              return MyHomePage();
            },
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double imagePadding = MediaQuery.of(context).size.width * 0.12;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              left: imagePadding,
              right: imagePadding,
              top: imagePadding,
              bottom: imagePadding,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  BYDConstants()
                      .getBydImageHome("byd_location_car_icon_thin.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.centerRight,
                      child: Text(S.of(context).register,
                          style: TextStyle(
                              color: BYDColor.bydThemeColor, fontSize: 16)),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Text("Hey",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Text(S.of(context).byd_welcome_to_use,
                          style: TextStyle(fontSize: 20)),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildTextFieldWidget("18129982768", false),
                          buildTextFieldWidget("·········", true),
                          Container(
                            alignment: Alignment(-1, -0.7),
                            height: 100,
                            child: Text(S.of(context).byd_use_sms_code_login,
                                style:
                                    TextStyle(color: BYDColor.bydThemeColor)),
                          ),
                          GestureDetector(
                            onTap: () {
//
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)),
                                  color: BYDColor.bydThemeColor),
                              alignment: Alignment.center,
                              height: 44,
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text(S.of(context).login,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(S.of(context).guest_login,
                              style: TextStyle(color: BYDColor.bydTextColor3)),
                          Expanded(child: Container()),
                          Text(S.of(context).forget_password,
                              style: TextStyle(color: BYDColor.bydTextColor3))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldWidget(String textString, bool isSecure) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: BYDColor.bydTextColor4)),
      ),
      padding: EdgeInsets.only(top: 15),
      alignment: Alignment.topLeft,
      height: 65,
      child: Row(
        children: [
          isSecure
              ? IconFont().getIconWithData(
                  name: 0xe687, color: BYDColor.bydTextColor3, size: 18)
              : IconFont().getIconWithData(
                  name: 0xe63c, color: BYDColor.bydTextColor3, size: 18),
          Container(
            width: 10,
          ),
          Expanded(
            child: TextField(
              obscureText: true,
              style: TextStyle(
                  color: BYDColor.bydTextColor1,
                  fontSize: 20,
                  fontWeight: isSecure ? FontWeight.w900 : FontWeight.w400),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.blue.shade100,
                  labelText: textString),
            ),
          ),
        ],
      ),
    );
  }
}
