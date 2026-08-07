import 'package:flutter/material.dart';


class HcFilesScreen extends StatelessWidget {

  const HcFilesScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final files = [

      {
        "name": "inwi-6.abde",
        "type": "UDP CUSTOM",
        "country": "🇲🇦 Morocco",
      },


      {
        "name": "orange.abde",
        "type": "SLOW DNS",
        "country": "🇲🇦 Morocco",
      },


      {
        "name": "germany-vless.abde",
        "type": "VLESS",
        "country": "🇩🇪 Germany",
      },

    ];


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "ABDE FILES",
        ),

      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: files.length,


        itemBuilder: (context,index){


          final file = files[index];


          return Card(

            child: ListTile(

              leading: const Icon(
                Icons.file_open,
              ),


              title: Text(
                file["name"]!,
              ),


              subtitle: Text(
                "${file["country"]}\n${file["type"]}",
              ),


              trailing: PopupMenuButton(

                itemBuilder: (context)=>[

                  const PopupMenuItem(

                    value: "download",

                    child: Text(
                      "Download",
                    ),

                  ),


                  const PopupMenuItem(

                    value: "share",

                    child: Text(
                      "Share",
                    ),

                  ),

                ],

              ),


            ),

          );


        },

      ),

    );

  }

}
