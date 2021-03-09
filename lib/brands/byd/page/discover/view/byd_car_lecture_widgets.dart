import 'package:carsimmaster/common/activity_page.dart';
import 'package:carsimmaster/common/common_webview.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BYDCarLectureWidget extends StatefulWidget {
  @override
  _BYDCarLectureWidgetState createState() => _BYDCarLectureWidgetState();
}

class _BYDCarLectureWidgetState extends State<BYDCarLectureWidget> {
  List dynastyUrls = [
    "http://www.bydauto.com.cn/auto/carShow.html-param=%E6%B1%89EV",
    "http://www.bydauto.com.cn/auto/carShow.html-param=2021%E6%AC%BE%E5%94%90DM",
    "http://www.bydauto.com.cn/auto/carShow.html-param=%E5%AE%8BProDM",
    "http://www.bydauto.com.cn/auto/carShow.html-param=%E7%A7%A6ProDM%E8%B6%85%E8%83%BD%E7%89%88",
    "http://www.bydauto.com.cn/auto/carShow.html-param=%E5%85%A8%E6%96%B0%E5%85%83EV"
  ];
  List dynastyTitles = ['汉', "唐", '宋', '秦', '元'];
  List eseriesUrls = [
    "http://www.bydauto.com.cn/auto/carShow.html-param=e1",
    "http://www.bydauto.com.cn/auto/carShow.html-param=S2",
    "http://www.bydauto.com.cn/auto/carShow.html-param=e2",
    "http://www.bydauto.com.cn/auto/carShow.html-param=e3"
  ];
  List eseriesTitles = ['e1', "s2", "e2", 'e3'];
  List otherTitles = ['F3'];
  List otherUrls = [
    "http://www.bydauto.com.cn/auto/carShow.html-param=%E7%AC%AC%E4%B8%89%E4%BB%A3F3"
  ];

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(
          refreshText: S.of(context).byd_refreshText,
          refreshReadyText: S.of(context).byd_refreshReadyText,
          refreshingText: S.of(context).byd_refreshingText,
          refreshedText: S.of(context).byd_refreshedText,
          refreshFailedText: S.of(context).byd_refreshFailedText
      ),
      onRefresh: (){
        print('onRefresh');
        return Future.delayed(Duration(seconds: 1));
      },
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.43,
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
//                  print('_BYDCarLectureWidgetState.item');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CommonWebPage(
                            urlString: dynastyUrls.first,
                          )),
                    );
                  },
                  child: new Image.asset(
                    BYDConstants().getBydImageCommercial("han_ev${index + 1}.jpg"),
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: 5,
              pagination: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                Widget item({bool isSelect, int index}) {
                  return InkWell(
                    child: AnimatedContainer(
                      margin: EdgeInsets.only(right: 12),
                      width: 4,
                      height: isSelect ? 12 : 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      duration: const Duration(milliseconds: 200),
                    ),
                  );
                }

                List<Widget> itemList = [];
                for (var i = 0; i < config.itemCount; i++) {
                  itemList.add(item(
                    isSelect: i == config.activeIndex,
                    index: i,
                  ));
                }
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 19,
                        bottom: 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: itemList.toList(),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
          buildDynastyGridView(
              context: context,
              seriesName: S.of(context).byd_discover_dynasty,
              imagePrefixName: 'dynasty',
              titles: dynastyTitles,
              urls: dynastyUrls),
          buildDynastyGridView(
              context: context,
              seriesName: S.of(context).byd_discover_eSeries,
              imagePrefixName: 'eserise',
              titles: eseriesTitles,
              urls: eseriesUrls),
          buildDynastyGridView(
              context: context,
              seriesName: S.of(context).byd_discover_more_vehicle,
              imagePrefixName: 'other',
              titles: otherTitles,
              urls: otherUrls),
        ],
      ),
    );
  }

  Widget buildDynastyGridView(
      {BuildContext context,
      String seriesName,
      String imagePrefixName,
      List titles,
      List urls}) {
    double padding = 13;
    return Container(
      padding: EdgeInsets.all(padding),
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 12),
            child: Row(
              children: [
                Text(
                  seriesName,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Expanded(child: SizedBox()),
                Text(
                  S.of(context).byd_discover_all +
                      " " +
                      titles.length.toString() +
                      " " +
                      S.of(context).byd_discover_model,
                  style: TextStyle(fontSize: 14, color: BYDColor.bydTextColor3),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            height: 160,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titles.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                mainAxisSpacing: padding,
                crossAxisSpacing: 10,
                childAspectRatio: 23 / 39,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(
                        '_BYDCarLectureWidgetState.buildDynastyGridView-------${urls[index]}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CommonWebPage(
                                urlString: urls[index],
                              )),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        child: Container(
                          child: Image.asset(
                            BYDConstants().getBydImageDiscover(
                                "$imagePrefixName${index + 1}.jpg"),
                            fit: BoxFit.cover,
                          ),
                          height: 100,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(titles[index]))
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(child: SizedBox()),
          Divider(
            indent: padding,
            endIndent: padding,
            height: 3,
            color: BYDColor.bydTextColor4.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}
