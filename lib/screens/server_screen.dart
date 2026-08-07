import 'package:flutter/material.dart';


class ServerScreen extends StatelessWidget {

  const ServerScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Servers"
        ),

      ),


      body:

      const Center(

        child:

        Text(

          "🌐 Servers List\n\nComing Soon",

          textAlign:
          TextAlign.center,


          style:
          TextStyle(

            fontSize:20,

          ),

        ),

      ),


    );


  }


}
