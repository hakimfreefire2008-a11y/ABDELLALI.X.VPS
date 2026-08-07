import 'dart:async';

import 'package:flutter/material.dart';

import '../services/server_service.dart';
import 'home_screen.dart';



class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {



  late AnimationController controller;

  late Animation<double> animation;



  @override
  void initState() {

    super.initState();


    controller = AnimationController(

      duration: const Duration(seconds: 2),

      vsync: this,

    );


    animation = CurvedAnimation(

      parent: controller,

      curve: Curves.easeIn,

    );


    controller.forward();


    startApp();


  }



  Future<void> startApp() async {


    await ServerService.loadServers();


    await Future.delayed(

      const Duration(seconds: 2),

    );



    if(mounted){

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const HomeScreen(),

        ),

      );

    }


  }



  @override
  void dispose(){

    controller.dispose();

    super.dispose();

  }




  @override
  Widget build(BuildContext context){


    return Scaffold(


      body: Center(


        child: FadeTransition(

          opacity: animation,


          child: Column(


            mainAxisAlignment:
            MainAxisAlignment.center,


            children: [


              Container(

                width: 130,

                height: 130,


                decoration:
                BoxDecoration(

                  shape:
                  BoxShape.circle,


                  color:
                  Colors.blue,

                ),


                child:
                const Center(

                  child: Text(

                    "ABDE",

                    style:
                    TextStyle(

                      fontSize: 45,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Colors.white,

                    ),

                  ),

                ),

              ),



              const SizedBox(
                height: 25,
              ),



              const Text(

                "CONFIGES ABDELLALI PRO",

                style:
                TextStyle(

                  fontSize: 22,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),



              const SizedBox(
                height: 15,
              ),



              const CircularProgressIndicator(),



            ],


          ),


        ),


      ),


    );


  }


}
