import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnk_flutter_rwd/tnk_flutter_rwd.dart';
import 'placement_data.dart';

class PlacementViewItem extends StatefulWidget {
  late final int type;

  PlacementViewItem({super.key, required this.type});

  @override
  State<StatefulWidget> createState() => _PlacementViewItem();
}

class _PlacementViewItem extends State<PlacementViewItem>
    with WidgetsBindingObserver {
  late int _type;
  final _tnkFlutterRwdPlugin = TnkFlutterRwd();
  List<TnkPlacementAdItem> adList = [];
  PlacementPubInfo pubInfo = PlacementPubInfo();
  String _tnkResult = 'Unknown';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _type = widget.type;
    getAdList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          pubInfo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xff353535),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "더 보기",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          color: Color(0xFFFFFFFF),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: adList.length,
            itemBuilder: (context, index) {
              return setPlacementView(adList[index]);
            },
          ),
        ),
      ),
    );
  }

  Future<void> showATTPopup() async {
    try {
      await _tnkFlutterRwdPlugin.showATTPopup();
    } on Exception {
      return;
    }
  }


  // 광고 리스트 호출
  Future<void> getAdList() async {

    try {
      await _tnkFlutterRwdPlugin.setUserName("jameson");
      await _tnkFlutterRwdPlugin.setCOPPA(false);

      String? placementData = await _tnkFlutterRwdPlugin.getPlacementJsonData("offer_nor");
      _tnkFlutterRwdPlugin.setUseTermsPopup(false);

      if (placementData != null) {
        Map<String, dynamic> jsonObject = jsonDecode(placementData);
        String resCode = jsonObject["res_code"];
        String resMessage = jsonObject["res_message"];

        if (resCode == "1") {
          List<TnkPlacementAdItem> adList = praserJsonToTnkPlacementAdItem(
            jsonObject["ad_list"],
          );

          setState(() {
            this.adList.addAll(adList);
            Map<String, dynamic> pubInfoMap = jsonObject["pub_info"];

            pubInfo.ad_type = pubInfoMap["ad_type"];
            pubInfo.title = pubInfoMap["title"];
            pubInfo.more_lbl = pubInfoMap["more_lbl"];
            pubInfo.cust_data = pubInfoMap["cust_data"];
            pubInfo.ctype_surl = pubInfoMap["ctype_surl"];
            pubInfo.pnt_unit = pubInfoMap["pnt_unit"];
            pubInfo.plcmt_id = pubInfoMap["plcmt_id"];

            pubInfo.plcmt_id = pubInfoMap["plcmt_id"];
            pubInfo.title = pubInfoMap["title"];





            _tnkResult = placementData ?? "null";
          });
        } else {
          // 광고 로드 실패
          print("광고 로드 실패");
        }
      }
    } on PlatformException {
      setState(() {
        _tnkResult = "excetpion";
      });
      return;
    }
  }

  // 광고 클릭 이벤트 ( 상세페이지 이동 )
  Future<void> onAdItemClick(String appId) async {
    try {
      String? adDetail = await _tnkFlutterRwdPlugin.onItemClick(appId);
      if (adDetail != null) {
        Map<String, dynamic> jsonObject = jsonDecode(adDetail);
        String resCode = jsonObject["res_code"];
        String resMessage = jsonObject["res_message"];

        if (resCode == "1") {
          print(resMessage);
        } else {
          print(resMessage);
        }
      } else {
        print("adDetail is null");
      }
    } on Exception {
      print("onAdItemClick Exception");
      return;
    }
  }


  Widget setPlacementView(TnkPlacementAdItem adItem) {
    switch (_type) {
      case 1:
        return buildDefaultPlacementView(adItem);
      case 2:
        return buildCpsPlacementView(adItem);
      default:
        return buildDefaultPlacementView(adItem);
    }
  }

  // placement view 구현하는 메소드 ( 기본 )
  Widget buildDefaultPlacementView(TnkPlacementAdItem adItem) {
    return Container(
      width: 216,
      height: 194,
      margin: EdgeInsets.only(right: 10),
      child:
      // onTap 이벤트 추가
      GestureDetector(
        onTap: () => onAdItemClick(adItem.app_id.toString()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 206,
              height: 107,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(adItem.img_url),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 5),

            Text(
              adItem.app_nm,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Color(0xff666666)),
            ),
            SizedBox(height: 5),
            Text(
              adItem.cmpn_type_name,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4572EF),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/images/ic_point.png'),
                  width: 12,
                  height: 12,
                ),
                SizedBox(width: 5),
                Text(
                  adItem.pnt_amt.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4572EF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildCpsPlacementView(TnkPlacementAdItem adItem) {
    return GestureDetector(
      onTap: () => onAdItemClick(adItem.app_id.toString()),
      child: SizedBox(
        width: 110,
        height: 219,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(adItem.img_url)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // padding 8dp
            SizedBox(height: 6),
            Text(
              adItem.app_nm,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xff666666),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 2),
            Row(
              children: [
                Text(
                  adItem.org_prd_price.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "${adItem.sale_dc_rate}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4572EF),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2),
            Row(
              children: [
                Text(
                  adItem.cmpn_type_name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff4572EF).withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // assets 경로
                Image(
                  image: AssetImage('assets/images/ic_point.png'),
                  width: 12,
                  height: 12,
                ),
                SizedBox(width: 3),
                Text(
                  adItem.pnt_amt.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff4572EF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Positioned.fill(child: Container(color: Colors.white)),
          ],
        ),
      ),
    );
  }


}





