import 'package:flutter/material.dart';

import 'create_config_screen.dart';
import 'my_configs_screen.dart';
import 'server_screen.dart';
import 'hc_files_screen.dart';
import 'help_screen.dart';



class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "CONFIGES ABDELLALI PRO"
        ),

        centerTitle:true,

      ),



      body:
      Padding(

        padding:
        const EdgeInsets.all(16),


        child:
        ListView(


          children:[



            button(

              context,

              "➕ Create Config",

              const CreateConfigScreen(),

            ),



            button(

              context,

              "📁 My Configs",

              const MyConfigsScreen(),

            ),



            button(

              context,

              "🌐 Servers",

              const ServerScreen(),

            ),



            button(

              context,

              "📂 HC Files",

              const HcFilesScreen(),

            ),



            button(

              context,

              "❓ Help",

              const HelpScreen(),

            ),



          ],


        ),

      ),


    );


  }




  Widget button(

      BuildContext context,

      String text,

      Widget page

      ){


    return Container(

      margin:
      const EdgeInsets.only(
        bottom:15
      ),



      child:
      ElevatedButton(


        style:
        ElevatedButton.styleFrom(

          padding:
          const EdgeInsets.all(20),

        ),



        onPressed:(){


          Navigator.push(

            context,

            MaterialPageRoute(

              builder:
              (context)=>page,

            ),

          );


        },



        child:
        Text(

          text,

          style:
          const TextStyle(

            fontSize:18

          ),

        ),


      ),

    );


  }



}
