import 'package:flutter/material.dart';
import '../models/config_model.dart';
import '../services/encryption_service.dart';



class MyConfigsScreen extends StatefulWidget {

  const MyConfigsScreen({super.key});


  @override
  State<MyConfigsScreen> createState() =>
      _MyConfigsScreenState();

}



class _MyConfigsScreenState
    extends State<MyConfigsScreen> {


  List<ConfigModel> configs = [];



  Future<void> exportConfig(
      ConfigModel config
      ) async {


    await EncryptionService
        .createAbdeFile(config);



    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text(
          "ABDE file created"
        ),

      ),

    );


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "My Configs"
        ),

      ),



      body:


      configs.isEmpty


      ?

      const Center(

        child:
        Text(

          "No Configs",

          style:
          TextStyle(
            fontSize:20
          ),

        ),

      )



      : ListView.builder(


        itemCount:
        configs.length,


        itemBuilder:
        (context,index){


          final config =
          configs[index];



          return Card(


            margin:
            const EdgeInsets.all(10),



            child:
            ListTile(


              title:
              Text(
                config.name
              ),



              subtitle:
              Text(

                "${config.type}\n🟢 Ready",

              ),



              trailing:
              PopupMenuButton(


                itemBuilder:
                (context)=>[



                  const PopupMenuItem(

                    value:"open",

                    child:
                    Text(
                      "OPEN"
                    ),

                  ),




                  const PopupMenuItem(

                    value:"share",

                    child:
                    Text(
                      "SHARE"
                    ),

                  ),




                  const PopupMenuItem(

                    value:"delete",

                    child:
                    Text(
                      "DELETE"
                    ),

                  ),




                  const PopupMenuItem(

                    value:"export",

                    child:
                    Text(
                      "EXPORT .abde"
                    ),

                  ),



                ],




                onSelected:
                (value){


                  if(value=="export"){


                    exportConfig(
                      config
                    );


                  }



                  if(value=="delete"){


                    setState((){


                      configs.removeAt(index);


                    });


                  }



                },

              ),



            ),


          );


        },


      ),



    );


  }



}
