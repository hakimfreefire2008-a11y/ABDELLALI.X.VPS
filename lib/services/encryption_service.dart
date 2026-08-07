import 'dart:convert';
import 'dart:io';
import '../models/config_model.dart';


class EncryptionService {



  static String encryptConfig(
      ConfigModel config
      ){


    final json =
    jsonEncode(
      config.toJson()
    );


    final bytes =
    utf8.encode(json);


    return
    base64Encode(bytes);


  }





  static ConfigModel decryptConfig(
      String data
      ){


    final bytes =
    base64Decode(data);


    final json =
    utf8.decode(bytes);


    final map =
    jsonDecode(json);



    return ConfigModel.fromJson(
      map
    );


  }






  static Future<File> createAbdeFile(
      ConfigModel config
      ) async {



    final content =
    encryptConfig(config);



    final directory =
    Directory(
      "/storage/emulated/0/Download"
    );



    if(!directory.existsSync()){

      directory.createSync(
        recursive:true
      );

    }



    final file =
    File(

      "${directory.path}/${config.name}.abde"

    );



    await file.writeAsString(
      content
    );



    return file;


  }





  static Future<ConfigModel> openAbdeFile(
      File file
      ) async {



    final content =
    await file.readAsString();



    return decryptConfig(
      content
    );


  }


}
