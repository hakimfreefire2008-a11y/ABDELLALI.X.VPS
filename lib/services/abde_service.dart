import 'dart:convert';
import 'dart:io';

import '../models/config_model.dart';


class AbdeService {


  // مفتاح داخلي مؤقت للنسخة الأولى
  static const String _key =
      "ABDELLALI_PRO_SECRET";


  // تشفير النص
  static String _encrypt(String data) {

    final bytes =
        utf8.encode(data + _key);

    return base64.encode(bytes);

  }



  // فك التشفير
  static String _decrypt(String data) {

    final bytes =
        base64.decode(data);

    final result =
        utf8.decode(bytes);


    return result.replaceAll(
        _key,
        ""
    );

  }





  // إنشاء ملف .abde

  static Future<File> createFile(
      ConfigModel config,
      String path,
      ) async {


    final json =
        jsonEncode(
          config.toJson(),
        );


    final encrypted =
        _encrypt(json);



    final file =
        File(
          "$path/${config.name}.abde",
        );


    await file.writeAsString(
      encrypted,
    );


    return file;

  }





  // قراءة ملف .abde

  static Future<Map<String,dynamic>>
  readFile(File file) async {


    final encrypted =
        await file.readAsString();



    final decrypted =
        _decrypt(
          encrypted,
        );



    return jsonDecode(
      decrypted,
    );

  }



}
