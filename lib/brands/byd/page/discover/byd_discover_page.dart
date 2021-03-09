import 'package:auto_size_text/auto_size_text.dart';
import 'package:carsimmaster/brands/byd/page/discover/view/byd_car_lecture_widgets.dart';
import 'package:carsimmaster/brands/byd/page/discover/view/byd_energy_rank_widgets.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BYDDiscoverPage extends StatefulWidget {
  @override
  _BYDDiscoverPageState createState() => _BYDDiscoverPageState();
}

class _BYDDiscoverPageState extends State<BYDDiscoverPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  var tabTitles = ['', '', ''];
  @override
  void initState() {
    mController = TabController(
      length: tabTitles.length,
      vsync: this,
    );
    setStatusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabTitles = [
      S.of(context).byd_energy_consumption_rank,
      S.of(context).byd_service_appointment,
      S.of(context).byd_car_lecture
    ];
    return Scaffold(
      appBar: _appBarView(),
      body: _tabBarView(),
    );
  }

  Widget _appBarView() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 51),
      child: AppBar(
        backgroundColor: BYDColor.bydBackgroundColor,
        title: _tabBar(),
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            height: 2.5,
            color: BYDColor.bydSeparatorColor2,
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 5),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Column(
      children: [
        TabBar(
          onTap: (index){
            setStatusBar();
          },
            //设置tab是否可水平滑动
            isScrollable: true,
            //控制器
            indicatorColor: BYDColor.bydThemeColor,
            controller: mController,
            //设置tab文字得类型
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //设置tab选中得颜色
            labelColor: BYDColor.bydThemeColor,
            //设置tab未选中得颜色
            unselectedLabelColor: BYDColor.bydTextColor1,
            //设置自定义tab的指示器，CustomUnderlineTabIndicator
            //若不需要自定义，可直接通过
            //indicatorColor 设置指示器颜色
            //indicatorWight 设置指示器厚度
            //indicatorPadding
            //indicatorSize  设置指示器大小计算方式
//        indicator: Container(),
        labelPadding:EdgeInsets.symmetric(horizontal: 5),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
            tabs: tabTitles.map((item) {
              return Container(
                  width: MediaQuery.of(context).size.width / (5.5),
                  child: Tab(
                    child: AutoSizeText(
                      item,
                      maxLines: 1,
                      maxFontSize: 16,
                      minFontSize: 3,
                    ),
                  ));
            }).toList()),
      ],
    );
  }

  void setStatusBar() {
     Future.delayed(Duration(seconds: 1),(){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    });
  }

  Widget _tabBarView() {
    return TabBarView(
      controller: mController,
      children: tabTitles.map((item) {
        if (item == S.of(context).byd_energy_consumption_rank) {
          return BYDEnergyConsumptionRankListView();
        }
        if (item == S.of(context).byd_service_appointment) {
          return BYDDiscoverServiceAppointment();
        }
        if (item == S.of(context).byd_car_lecture) {
          return BYDCarLectureWidget();
        }
        return Container(
          child: Center(
            child: Text(item,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BYDColor.bydThemeColor)),
          ),
        );
      }).toList(),
    );
  }
}
