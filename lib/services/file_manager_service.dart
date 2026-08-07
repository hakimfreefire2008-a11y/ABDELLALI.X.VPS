import 'dart:convert';
import 'dart:io';

import 'package:share_plus/share_plus.dart';

import '../models/config_model.dart';



class FileManagerService {



  static Future<File> saveConfig(
      ConfigModel config,
      String directoryPath
      ) async {


    final json =
        jsonEncode(
          config.toJson(),
        );


    final file =
        File(
          "$directoryPath/${config.id}.abde",
        );


    await file.writeAsString(
        json
    );


    return file;

  }





  static Future<ConfigModel?> loadConfig(
      File file
      ) async {


    try {


      final content =
          await file.readAsString();


      final data =
          jsonDecode(content);



      return ConfigModel.fromJson(
          data
      );


    } catch(e){


      return null;


    }


  }





  static Future<void> shareConfig(
      File file
      ) async {


    await Share.shareXFiles(

      [

        XFile(
          file.path,
        )

      ],

      text:
      "CONFIGES ABDELLALI PRO CONFIG",

    );


  }





  static Future<List<File>> getConfigs(
      String directoryPath
      ) async {


    final directory =
        Directory(
            directoryPath
        );


    if(!directory.existsSync()){

      return [];

    }



    return directory
        .listSync()
        .whereType<File>()
        .where(
            (file)=>
            file.path.endsWith(".abde")
    )
        .toList();


  }



}
