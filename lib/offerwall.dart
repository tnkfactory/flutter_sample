import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnk_flutter_rwd/tnk_flutter_rwd.dart';

class OfferwallItem extends StatefulWidget {

  OfferwallItem({super.key});

  @override
  State<StatefulWidget> createState() => _OfferwallItem();
}

class _OfferwallItem extends State<OfferwallItem> with WidgetsBindingObserver {

  final _tnkFlutterRwdPlugin = TnkFlutterRwd();
  String _tnkResult = 'Unknown';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    showAdList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }


  Future<void> showAdList() async {
    String platformVersion;

    try {
      await _tnkFlutterRwdPlugin.setUserName("testUser");
      await _tnkFlutterRwdPlugin.setCOPPA(false);

      _tnkFlutterRwdPlugin.setUseTermsPopup(false);
      platformVersion = await _tnkFlutterRwdPlugin.showAdList("미션 수행하기") ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // sleepAndClose();
    if (!mounted) return;

    setState(() {
      _tnkResult = platformVersion;
    });
  }

}