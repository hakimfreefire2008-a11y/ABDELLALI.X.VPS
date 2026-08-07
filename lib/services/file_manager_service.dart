import 'dart:convert';
import 'dart:io';

import 'package:share_plus/share_plus.dart';

import '../models/config_model.dart';



class FileManagerService {



  Future<File> saveConfigAsABDE(
      ConfigModel config
      ) async {


    final directory =
    Directory(
      "/storage/emulated/0/CONFIGES_ABDELLALI",
    );


    if(!directory.existsSync()){

      await directory.create(
          recursive:true
      );

    }



    final file =
    File(
      "${directory.path}/${config.id}.abde",
    );



    final data =
    jsonEncode(
        config.toJson()
    );



    await file.writeAsString(
        data
    );



    return file;


  }







  Future<bool> isValidABDE(
      String path
      ) async {


    try {


      final file =
      File(path);



      if(!await file.exists()){

        return false;

      }



      final text =
      await file.readAsString();



      final json =
      jsonDecode(text);



      return json["id"] != null;



    }catch(e){


      return false;


    }


  }







  Future<ConfigModel?> importABDE(
      String path
      ) async {


    try{


      final file =
      File(path);



      final text =
      await file.readAsString();



      final json =
      jsonDecode(text);



      return ConfigModel.fromJson(
          json
      );



    }catch(e){


      return null;


    }


  }







  Future<bool> deleteConfig(
      String id
      ) async {


    try{


      final file =
      File(
        "/storage/emulated/0/CONFIGES_ABDELLALI/$id.abde",
      );



      if(await file.exists()){


        await file.delete();


      }



      return true;



    }catch(e){


      return false;


    }


  }







  Future<bool> shareConfig(
      ConfigModel config
      ) async {


    try{


      final file =
      await saveConfigAsABDE(
          config
      );



      await Share.shareXFiles(

        [

          XFile(
            file.path,
          )

        ],


        text:
        "CONFIGES ABDELLALI PRO",

      );



      return true;



    }catch(e){


      return false;


    }


  }



}	

