import 'package:flutter/material.dart';
import '../services/file_service.dart';


class HcFilesScreen extends StatelessWidget {

  const HcFilesScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final files = [

      "Morocco-Free.hc",
      "SSH-Fast.hc",
      "UDP-Premium.hc",

    ];


    return Scaffold(

      appBar: AppBar(
        title: const Text("HTTP CUSTOM FILES"),
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: files.length,


        itemBuilder: (context,index){


          return Card(

            child: ListTile(

              leading: const Icon(
                Icons.file_download,
              ),


              title: Text(
                files[index],
              ),


              trailing: IconButton(

                icon: const Icon(
                  Icons.download,
                ),


                onPressed: (){

                  FileService.downloadFile(
                    context,
                    files[index],
                  );

                },

              ),

            ),

          );


        },

      ),

    );

  }

}
