import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpScreen extends StatelessWidget {

  const HelpScreen({super.key});



  Future<void> openUrl(String link) async {

    final uri = Uri.parse(link);


    if(await canLaunchUrl(uri)) {

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

    }

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "HELP & DEVELOPER",
        ),

        centerTitle: true,

      ),




      body: Center(


        child: SingleChildScrollView(


          padding:
          const EdgeInsets.all(20),



          child: Column(


            mainAxisAlignment:
            MainAxisAlignment.center,



            children: [



              Container(


                padding:
                const EdgeInsets.all(25),


                decoration:
                BoxDecoration(


                  shape:
                  BoxShape.circle,


                  gradient:
                  const LinearGradient(

                    colors: [

                      Colors.blue,

                      Colors.purple,

                    ],

                  ),



                  boxShadow: [


                    BoxShadow(

                      color:
                      Colors.blueAccent,

                      blurRadius:
                      30,

                      spreadRadius:
                      5,

                    ),


                  ],


                ),



                child:
                const Text(


                  "ABDE",



                  style:
                  TextStyle(


                    color:
                    Colors.white,


                    fontSize:
                    45,


                    fontWeight:
                    FontWeight.bold,


                  ),


                ),


              ),




              const SizedBox(height:25),





              const Text(


                "💗𝗔𝗕𝗗𝗘𝗟𝗟𝗔𝗟𝗜💗",



                style:
                TextStyle(


                  fontSize:
                  26,


                  fontWeight:
                  FontWeight.w900,


                  color:
                  Colors.blueAccent,


                ),



              ),





              const SizedBox(height:10),





              const Text(


                "CONFIGES ABDELLALI PRO",



                style:
                TextStyle(


                  fontSize:
                  18,


                  fontWeight:
                  FontWeight.bold,


                ),



              ),




              const SizedBox(height:30),




              Card(


                child:
                ListTile(


                  leading:
                  const Icon(
                    Icons.phone,
                  ),


                  title:
                  const Text(
                    "WhatsApp Developer",
                  ),


                  subtitle:
                  const Text(
                    "+212714193084",
                  ),


                  onTap: () {


                    openUrl(
                      "https://wa.me/212714193084",
                    );


                  },


                ),


              ),





              Card(


                child:
                ListTile(


                  leading:
                  const Icon(
                    Icons.telegram,
                  ),


                  title:
                  const Text(
                    "Telegram",
                  ),


                  subtitle:
                  const Text(
                    "t.me/abdellali84",
                  ),


                  onTap: () {


                    openUrl(
                      "https://t.me/abdellali84",
                    );


                  },


                ),


              ),





              Card(


                child:
                ListTile(


                  leading:
                  const Icon(
                    Icons.campaign,
                  ),


                  title:
                  const Text(
                    "WhatsApp Channel",
                  ),


                  subtitle:
                  const Text(
                    "ABDELLALI CHANNEL",
                  ),


                  onTap: () {


                    openUrl(
                      "https://whatsapp.com/channel/0029VbBJN2RFcow7OykfP02I",
                    );


                  },


                ),


              ),





              const SizedBox(height:20),




              const Text(


                "Version 1.0.0\nFAST • SECURE • CONFIGS",



                textAlign:
                TextAlign.center,



                style:
                TextStyle(


                  color:
                  Colors.white70,


                ),



              ),



            ],


          ),


        ),


      ),


    );


  }


}
