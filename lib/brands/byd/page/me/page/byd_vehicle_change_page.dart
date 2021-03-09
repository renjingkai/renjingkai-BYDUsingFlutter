import 'package:carsimmaster/brands/byd/page/location/byd_location_search_page.dart';
import 'package:carsimmaster/brands/byd/page/location/view/byd_location_search_page_history_result_cell.dart';
import 'package:carsimmaster/brands/byd/page/me/page/byd_vehicle_model.dart';
import 'package:carsimmaster/brands/byd/page/me/view/byd_vehicle_change_cell.dart';
import 'package:carsimmaster/common/byd_hud.dart';
import 'package:carsimmaster/constant/byd_constants.dart';
import 'package:carsimmaster/generated/l10n.dart';
import 'package:carsimmaster/store/byd_vehicle_config_store.dart';
import 'package:carsimmaster/theme/byd/byd_color.dart';
import 'package:flutter/material.dart';

class BYDVehicleChangePage extends StatefulWidget {
  @override
  _BYDVehicleChangePageState createState() => _BYDVehicleChangePageState();
}

class _BYDVehicleChangePageState extends State<BYDVehicleChangePage>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  BYDVehicleConfigStore configStore = BYDVehicleConfigStore();
  List modelList = [
    BYDVehicleModel(
        model: BYDModel.BYDModelHanEV,
        carPlateString: "汉EV-粤BD35838",
        vehicleFrameString: "LC0CE4DC6K0086333"),
    BYDVehicleModel(
        model: BYDModel.BYDModelQingProEV,
        carPlateString: "秦Pro EV-粤BD18193",
        vehicleFrameString: "LC0CE4DC6K376633"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongClassic,
        carPlateString: "宋燃油版-粤BD26903",
        vehicleFrameString: "LC0CE4DC6K627253"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongMaxDM,
        carPlateString: "宋Max DM-粤BD78132",
        vehicleFrameString: "LC0CE4DC6K756737"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongPlus,
        carPlateString: "宋Plus燃油版-粤BD32823",
        vehicleFrameString: "LC0CE4DC6K892901"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongPro,
        carPlateString: "宋Pro燃油版-粤BD12389",
        vehicleFrameString: "LC0CE4DC6K951892"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongProDM,
        carPlateString: "宋Pro DM-粤BD90812",
        vehicleFrameString: "LC0CE4DC6K735193"),
    BYDVehicleModel(
        model: BYDModel.BYDModelSongProEV,
        carPlateString: "宋Pro EV-粤BD91323",
        vehicleFrameString: "LC0CE4DC6K901239"),
    BYDVehicleModel(
        model: BYDModel.BYDModelTang,
        carPlateString: "唐燃油版-粤BD91031",
        vehicleFrameString: "LC0CE4DC6K096123"),
    BYDVehicleModel(
        model: BYDModel.BYDModelYuanEV,
        carPlateString: "元EV-粤BD12192",
        vehicleFrameString: "LC0CE4DC6K962394"),
    BYDVehicleModel(
        model: BYDModel.BYDModelE2,
        carPlateString: "E2-粤BD12622",
        vehicleFrameString: "LC0CE4DC6K962994")
  ];
//10
  @override
  void didChangeDependencies() {
    print(
        '_BYDVehicleChangePageState.didChangeDependencies ${BYDVehicleConfigStore.instance.bydModel}${BYDVehicleConfigStore.instance.bydModel.index}');
    this.selectedIndex = BYDVehicleConfigStore.instance.bydModel.index;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: AppBar(
          elevation: 1.0,
          backgroundColor: BYDColor.bydBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BYDColor.bydThemeColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(S.of(context).byd_change_vehicle,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: BYDColor.bydTextColor1)),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(S.of(context).add),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: modelList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectedIndex = index;
                    var configStore = BYDVehicleConfigStore.instance;
//          configStore.vehicleFrameNumber = widget.vehicleFrameString;
//          configStore.carPlateString = widget.carPlateString;
//          configStore.bydModel = widget.bydModel;
                    BYDVehicleModel model = modelList[index];
                    configStore.setBYDModel(model.model);
                    configStore.setVehicleFrameNumber(model.vehicleFrameString);
                    configStore.setCarPlateString(model.carPlateString);
                    configStore.vehicleFrameNumber = model.vehicleFrameString;
                    switch (configStore.bydModel) {
                      case BYDModel.BYDModelE2:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("e2.png");
                        break;
                      case BYDModel.BYDModelHanEV:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("han_ev.png");
                        break;
                      case BYDModel.BYDModelQingProEV:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("qing_pro_ev.png");
                        break;
                      case BYDModel.BYDModelSongClassic:
                        configStore.carIconImage = BYDConstants()
                            .getBydVehicleIcon("song_classic.png");
                        break;
                      case BYDModel.BYDModelSongMaxDM:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("song_max_dm.png");
                        break;
                      case BYDModel.BYDModelSongPlus:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("song_plus.png");
                        break;
                      case BYDModel.BYDModelSongPro:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("song_pro.png");
                        break;
                      case BYDModel.BYDModelSongProDM:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("song_pro_dm.png");
                        break;
                      case BYDModel.BYDModelSongProEV:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("song_pro_ev.png");
                        break;
                      case BYDModel.BYDModelTang:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("tang.png");
                        break;
                      case BYDModel.BYDModelYuanEV:
                        configStore.carIconImage =
                            BYDConstants().getBydVehicleIcon("yuan_ev.png");
                        break;
                    }
                    configStore.setCarIconImage(configStore.carIconImage);
                    print(
                        '_BYDVehicleChangePageState.build ${configStore.carPlateString} ${configStore.vehicleFrameNumber} ---- ${model.vehicleFrameString}');
//    configStore.setModelConfig(BYDModel.BYDModelQingProEV);
                  });
                }

                BYDHUD.bydShowGeneralDialog(context, this);
              },
              child: buildCell(index),
            );
          },
        ),
      ),
    );
  }

  Widget buildCell(int index) {
    BYDVehicleModel model = modelList[index];

    return BYDVehicleChangeCell(
      bydModel: model.model,
      carPlateString: model.carPlateString,
      vehicleFrameString: model.vehicleFrameString,
      isSelected: selectedIndex == index ? true : false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
