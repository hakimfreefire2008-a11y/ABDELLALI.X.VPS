import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpScreen extends StatelessWidget {


  const HelpScreen({super.key});



  Future<void> openLink(String url) async {


    final uri = Uri.parse(url);


    if(await canLaunchUrl(uri)){

      await launchUrl(uri);

    }


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "About Developer",
        ),

        centerTitle: true,

      ),



      body:
      Center(


        child:
        Padding(


          padding:
          const EdgeInsets.all(20),



          child:
          Column(


            mainAxisAlignment:
            MainAxisAlignment.center,



            children: [



              Container(


                padding:
                const EdgeInsets.all(25),


                decoration:
                const BoxDecoration(


                  shape:
                  BoxShape.circle,


                  gradient:
                  LinearGradient(

                    colors: [

                      Colors.blue,

                      Colors.purple,

                    ],

                  ),


                ),



                child:
                const Text(


                  "ABDE",


                  style:
                  TextStyle(


                    color:
                    Colors.white,


                    fontSize:
                    40,


                    fontWeight:
                    FontWeight.bold,


                  ),


                ),


              ),




              const SizedBox(height: 25),




              const Text(


                "CONFIGES ABDELLALI PRO",


                style:
                TextStyle(


                  fontSize:
                  22,


                  fontWeight:
                  FontWeight.bold,


                ),


              ),




              const SizedBox(height: 10),




              const Text(


                "Version 1.0.0",


                style:
                TextStyle(

                  color:
                  Colors.white70,

                ),

              ),




              const SizedBox(height: 30),




              FilledButton.icon(


                onPressed: (){


                  openLink(
                    "https://wa.me/212000000000",
                  );


                },


                icon:
                const Icon(
                  Icons.chat,
                ),


                label:
                const Text(
                  "WhatsApp Developer",
                ),


              ),





              const SizedBox(height: 15),





              OutlinedButton.icon(


                onPressed: (){


                  openLink(
                    "https://t.me/username",
                  );


                },


                icon:
                const Icon(
                  Icons.telegram,
                ),


                label:
                const Text(
                  "Telegram Channel",
                ),


              ),




            ],


          ),


        ),


      ),


    );


  }


}
