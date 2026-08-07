import 'package:flutter/material.dart';
import '../models/config_model.dart';


class CreateConfigScreen extends StatefulWidget {

  const CreateConfigScreen({super.key});


  @override
  State<CreateConfigScreen> createState() =>
      _CreateConfigScreenState();

}



class _CreateConfigScreenState
    extends State<CreateConfigScreen> {


  final nameController = TextEditingController();

  final hostController = TextEditingController();

  final portController = TextEditingController();

  final userController = TextEditingController();

  final passController = TextEditingController();

  final sniController = TextEditingController();

  final payloadController = TextEditingController();

  final proxyController = TextEditingController();

  final noteController = TextEditingController();


  String type = "SSH";


  bool sni = false;

  bool payload = false;

  bool proxy = false;



  List<String> types = [

    "SSH",
    "VLESS",
    "VMESS",
    "TROJAN",
    "SLOW DNS",
    "UDP CUSTOM"

  ];



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Create Config"
        ),

      ),


      body: Padding(

        padding:
        const EdgeInsets.all(16),


        child: ListView(

          children: [


            field(
              nameController,
              "Config Name"
            ),


            DropdownButtonFormField(

              value:type,

              decoration:
              const InputDecoration(

                labelText:"Type",

                border:
                OutlineInputBorder(),

              ),


              items:
              types.map((e){

                return DropdownMenuItem(

                  value:e,

                  child:
                  Text(e),

                );

              }).toList(),


              onChanged:(v){

                setState((){

                  type =
                  v.toString();

                });

              },

            ),


            const SizedBox(height:15),



            field(
              hostController,
              "Host / Server"
            ),


            field(
              portController,
              "Port"
            ),



            if(type=="SSH")

              field(
                userController,
                "Username"
              ),


            if(type=="SSH")

              field(
                passController,
                "Password"
              ),




            SwitchListTile(

              title:
              const Text(
                "Enable SNI"
              ),

              value:sni,

              onChanged:(v){

                setState((){

                  sni=v;

                });

              },

            ),



            if(sni)

              field(
                sniController,
                "SNI Domain"
              ),




            SwitchListTile(

              title:
              const Text(
                "Enable Payload"
              ),

              value:payload,

              onChanged:(v){

                setState((){

                  payload=v;

                });

              },

            ),



            if(payload)

              field(

                payloadController,

                "Payload"

              ),




            SwitchListTile(

              title:
              const Text(
                "Enable Proxy"
              ),

              value:proxy,

              onChanged:(v){

                setState((){

                  proxy=v;

                });

              },

            ),



            if(proxy)

              field(

                proxyController,

                "Proxy Host:Port"

              ),




            field(

              noteController,

              "Note"

            ),




            const SizedBox(height:20),



            ElevatedButton(

              onPressed:(){


                ConfigModel config =

                ConfigModel(

                  id:
                  DateTime.now()
                  .millisecondsSinceEpoch
                  .toString(),


                  name:
                  nameController.text,


                  type:
                  type,


                  host:
                  hostController.text,


                  port:
                  portController.text,


                  username:
                  userController.text,


                  password:
                  passController.text,


                  sni:
                  sniController.text,


                  payload:
                  payloadController.text,


                  payloadEnabled:
                  payload,


                  proxy:
                  proxyController.text,


                  proxyEnabled:
                  proxy,


                  note:
                  noteController.text,


                  createdAt:
                  DateTime.now(),


                );



                Navigator.pop(
                  context,
                  config
                );


              },


              child:
              const Text(
                "💾 Create Config"
              ),


            )


          ],

        ),

      ),

    );


  }





  Widget field(
      TextEditingController controller,
      String label
      ){

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom:12
      ),


      child:

      TextField(

        controller:
        controller,


        decoration:
        InputDecoration(

          labelText:
          label,


          border:
          const OutlineInputBorder(),

        ),

      ),

    );

  }


}
