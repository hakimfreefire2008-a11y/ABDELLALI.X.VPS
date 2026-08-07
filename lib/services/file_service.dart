import 'package:flutter/material.dart';

class FileService {

  static void downloadFile(BuildContext context, String fileName) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          "$fileName ready",
        ),
      ),

    );

  }

}
