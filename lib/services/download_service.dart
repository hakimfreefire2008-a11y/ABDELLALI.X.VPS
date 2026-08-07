import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DownloadService {


  static Future<String> saveFile(
      String fileName,
      String content,
      ) async {


    final directory =
        await getApplicationDocumentsDirectory();


    final file = File(
      '${directory.path}/$fileName',
    );


    await file.writeAsString(
      content,
    );


    return file.path;

  }


}
