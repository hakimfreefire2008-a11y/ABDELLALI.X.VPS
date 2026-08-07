import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';


class ActionService {


  static void copyConfig(String config) {

    Clipboard.setData(
      ClipboardData(
        text: config,
      ),
    );

  }



  static void shareConfig(String config) {

    Share.share(config);

  }


}
