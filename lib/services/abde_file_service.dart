import 'package:flutter/services.dart';


class AbdeFileService {


  static Future<String> loadFile(String fileName) async {


    final data = await rootBundle.loadString(
      'assets/configs/$fileName',
    );


    return data;

  }


}
