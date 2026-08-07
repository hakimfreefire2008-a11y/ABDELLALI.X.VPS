import 'dart:io';

import 'package:flutter/material.dart';

import '../models/config_model.dart';
import '../services/abde_service.dart';



class CreateConfigScreen extends StatefulWidget {

  const CreateConfigScreen({super.key});


  @override
  State<CreateConfigScreen> createState() =>
      _CreateConfigScreenState();

}




class _CreateConfigScreenState
    extends State<CreateConfigScreen> {


  String type = "SSH";


  bool useSni = false;
  bool usePayload = false;
  bool useProxy = false;



  final name =
      TextEditingController();


  final note =
      TextEditingController();


  final host =
      TextEditingController();


  final port =
      TextEditingController(text: "443");


  final username =
      TextEditingController();


  final password =
      TextEditingController();



  final sni =
      TextEditingController();


  final payload =
      TextEditingController();



  final proxyHost =
      TextEditingController();


  final proxyPort =
      TextEditingController(text: "8080");



  final uuid =
      TextEditingController();


  final address =
      TextEditingController();



  final nsDomain =
      TextEditingController();


  final publicKey =
      TextEditingController();


  final dnsIp =
      TextEditingController(
          text: "41.214.140.5"
      );




  Future<void> createConfig() async {



    final config = ConfigModel(


      name: name.text.isEmpty
          ? "ABDE CONFIG"
          : name.text,


      type: type,


      note: note.text,



      host: host.text,


      port: port.text,


      username: username.text,


      password: password.text,



      useSni: useSni,


      sni: sni.text,



      usePayload: usePayload,


      payload: payload.text,



      useProxy: useProxy,


      proxyHost: proxyHost.text,


      proxyPort: proxyPort.text,



      v2rayType: type,


      uuid: uuid.text,


      address: address.text,



      nsDomain: nsDomain.text,


      publicKey: publicKey.text,


      dnsIp: dnsIp.text,



      createdAt:
          DateTime.now(),

    );




    final dir =
        Directory.systemTemp;



    final file =
        await AbdeService.createFile(
          config,
          dir.path,
        );




    if(!mounted) return;



    ScaffoldMessenger.of(context)
        .showSnackBar(


      SnackBar(

        content: Text(
            "Created ${file.path}"
        ),

      ),


    );


  }






  Widget input(
      String title,
      TextEditingController controller
      ){


    return Padding(

      padding:
      const EdgeInsets.symmetric(
          vertical:6
      ),


      child:

      TextField(

        controller: controller,

        decoration:

        InputDecoration(

          labelText:title,

          border:
          const OutlineInputBorder(),

        ),

      ),

    );

  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:

      AppBar(

        title:
        const Text(
            "Create Config"
        ),

      ),




      body:

      SingleChildScrollView(


        padding:
        const EdgeInsets.all(16),


        child:

        Column(


          children: [



            input(
                "Config Name",
                name
            ),


            input(
                "Note",
                note
            ),




            DropdownButtonFormField<String>(


              value:type,


              items:

              const [


                DropdownMenuItem(
                    value:"SSH",
                    child:Text("SSH")
                ),


                DropdownMenuItem(
                    value:"VLESS",
                    child:Text("VLESS")
                ),


                DropdownMenuItem(
                    value:"VMESS",
                    child:Text("VMESS")
                ),


                DropdownMenuItem(
                    value:"TROJAN",
                    child:Text("TROJAN")
                ),


                DropdownMenuItem(
                    value:"SLOWDNS",
                    child:Text("SLOW DNS")
                ),


                DropdownMenuItem(
                    value:"UDP",
                    child:Text("UDP")
                ),


              ],



              onChanged:(value){


                setState((){

                  type=value!;

                });


              },

            ),




            const SizedBox(height:20),




            input(
                "Host",
                host
            ),


            input(
                "Port",
                port
            ),



            input(
                "Username",
                username
            ),



            input(
                "Password",
                password
            ),





            SwitchListTile(

              title:
              const Text(
                  "Enable SNI"
              ),

              value:
              useSni,


              onChanged:(v){

                setState((){

                  useSni=v;

                });

              },


            ),



            if(useSni)

              input(
                  "SNI Domain",
                  sni
              ),






            SwitchListTile(

              title:
              const Text(
                  "Enable Payload"
              ),

              value:
              usePayload,


              onChanged:(v){

                setState((){

                  usePayload=v;

                });

              },


            ),



            if(usePayload)

              input(
                  "Payload",
                  payload
              ),






            SwitchListTile(

              title:
              const Text(
                  "Enable Proxy"
              ),

              value:
              useProxy,


              onChanged:(v){

                setState((){

                  useProxy=v;

                });

              },


            ),



            if(useProxy)...[


              input(
                  "Proxy Host",
                  proxyHost
              ),


              input(
                  "Proxy Port",
                  proxyPort
              ),


            ],






            input(
                "UUID",
                uuid
            ),



            input(
                "V2Ray Address",
                address
            ),




            input(
                "NS Domain",
                nsDomain
            ),



            input(
                "Public Key",
                publicKey
            ),



            input(
                "DNS IP",
                dnsIp
            ),






            const SizedBox(height:20),




            ElevatedButton(


              onPressed:createConfig,


              child:

              const Text(
                  "CREATE CONFIG"
              ),


            )




          ],

        ),

      ),


    );


  }


}
