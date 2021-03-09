import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:carsimmaster/brands/byd/page/control/byd_control_page.dart';
import 'package:carsimmaster/brands/byd/page/discover/byd_discover_page.dart';
import 'package:carsimmaster/brands/byd/page/location/byd_location_page.dart';
import 'package:carsimmaster/brands/byd/page/location/byd_location_search_page.dart';
import 'package:carsimmaster/brands/byd/page/login/login_page.dart';
import 'package:carsimmaster/brands/byd/page/main/byd_main_page.dart';
import 'package:carsimmaster/brands/byd/page/me/page/byd_me_page.dart';
import 'package:carsimmaster/common/MyToast.dart';
import 'package:carsimmaster/common/icon_font.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'generated/l10n.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(MyApp());
  await AmapService.instance.init(
    iosKey: '3fd0355653988186e2edd8cd07974f03',
    androidKey: '88286b8d6892ddc9baad3b867b80f14a',
    webApiKey: 'e69c6fddf6ccf8de917f5990deaa9aa2',
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///记录上一次点击后退按钮的时间
  int lastTimeClickReturnButton = 0;
  PageController pageController;
  ///默认显示中间的页面
  int currentIndex = 2;
  ///
  Image tabbarImage = Image.asset(
    BYDConstants().getBydImageTabBar("byd_tabbar3.png"),
    fit: BoxFit.cover,
  );
  //点击导航项是要显示的页面
  final pages = [
    BYDControlPage(),
    BYDLocationPage(),
    BYDMainPage(),
    BYDDiscoverPage(),
    BYDMePage()
  ];

  @override
  void initState() {
    super.initState();
    IconFont().getIconWithData(
        name: 0xef3d,
        color: BYDColor.bydTextColor2,
        size: 14);
    pageController = PageController(initialPage: this.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            children: pages,
            controller: pageController,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: MediaQuery.of(context).size.width * 192 / 1080,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: tabbarImage
                  ),
                  Positioned(
                      top: 15,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  tabbarImage =  Image.asset(
                                    BYDConstants().getBydImageTabBar("byd_tabbar1.png"),
                                    fit: BoxFit.cover,
                                  );
                                });
                                ///控制
                                onTap(0);
                              },
                              child: Container(
//                          color: Colors.red,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  tabbarImage =  Image.asset(
                                    BYDConstants().getBydImageTabBar("byd_tabbar2.png"),
                                    fit: BoxFit.cover,
                                  );
                                });
                                ///位置
                                onTap(1);
                              },
                              child: Container(
//                          color: Colors.green,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  tabbarImage =  Image.asset(
                                    BYDConstants().getBydImageTabBar("byd_tabbar3.png"),
                                    fit: BoxFit.cover,
                                  );
                                });
                                ///云
                                onTap(2);
                              },
                              child: Container(
//                          color: Colors.yellow,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  tabbarImage =  Image.asset(
                                    BYDConstants().getBydImageTabBar("byd_tabbar4.png"),
                                    fit: BoxFit.cover,
                                  );
                                });
                                ///发现
                                onTap(3);
                              },
                              child: Container(
//                          color: Colors.blue,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  tabbarImage =  Image.asset(
                                    BYDConstants().getBydImageTabBar("byd_tabbar5.png"),
                                    fit: BoxFit.cover,
                                  );
                                });
                                ///我的
                                onTap(4);
                              },
                              child: Container(
//                          color: Colors.blue,
                                  ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          int newTime = DateTime.now().millisecondsSinceEpoch;
          int result = newTime - lastTimeClickReturnButton;
          lastTimeClickReturnButton = newTime;
          if (result > 2000) {
//            Toast.show(context, '再按一次退出');
          print('再按一次退出');
//MyToast.showInfo('再按一次退出');
//          MyToast.showSuccess("再按一次退出");
//showToast("showToast",context: context);
//            MyToast.showText("再按一次退出", duration: Duration(seconds: 3));
          } else {
            SystemNavigator.pop();
          }
          return null;
        });
  }

  ///点击tabbar切换页面（带动画）
  void onTap(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
