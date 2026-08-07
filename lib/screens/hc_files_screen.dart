import 'package:flutter/material.dart';
import '../services/abde_file_service.dart';
import '../services/action_service.dart';


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

            child: Padding(

              padding: const EdgeInsets.all(12),


              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Row(

                    children: [


                      const Icon(
                        Icons.insert_drive_file,
                        size: 35,
                      ),


                      const SizedBox(
                        width: 10,
                      ),


                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,


                          children: [


                            Text(

                              file["name"]!,

                              style:
                              const TextStyle(

                                fontSize: 18,

                                fontWeight:
                                FontWeight.bold,

                              ),

                            ),



                            Text(

                              "${file["country"]} | ${file["type"]}",

                            ),


                          ],

                        ),

                      ),


                    ],

                  ),



                  const SizedBox(height: 15),



                  Row(

                    children: [



                      FilledButton.icon(

                        onPressed: () async {


                          final content =
                              await AbdeFileService.loadFile(
                                file["name"]!,
                              );



                          if(context.mounted){

                            showDialog(

                              context: context,


                              builder: (context){


                                return AlertDialog(


                                  title: Text(
                                    file["name"]!,
                                  ),


                                  content: SingleChildScrollView(

                                    child: Text(
                                      content,
                                    ),

                                  ),


                                  actions: [


                                    TextButton(

                                      onPressed: (){

                                        Navigator.pop(context);

                                      },

                                      child:
                                      const Text(
                                        "CLOSE",
                                      ),

                                    )


                                  ],


                                );


                              },

                            );

                          }


                        },


                        icon:
                        const Icon(
                          Icons.open_in_new,
                        ),


                        label:
                        const Text(
                          "OPEN",
                        ),


                      ),



                      const SizedBox(
                        width: 10,
                      ),




                      OutlinedButton.icon(

                        onPressed: () async {


                          final content =
                              await AbdeFileService.loadFile(
                                file["name"]!,
                              );



                          ActionService.shareConfig(
                            content,
                          );


                        },


                        icon:
                        const Icon(
                          Icons.share,
                        ),


                        label:
                        const Text(
                          "SHARE",
                        ),


                      ),



                    ],

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
