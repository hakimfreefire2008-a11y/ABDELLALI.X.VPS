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

      curve: Curves.easeOut,

    );


    controller.forward();


    startApp();

  }



  Future<void> startApp() async {


    await ServerService.loadServers();


    await Future.delayed(

      const Duration(seconds: 3),

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


      body: Container(


        width: double.infinity,

        height: double.infinity,



        decoration: const BoxDecoration(


          gradient: LinearGradient(

            colors: [

              Color(0xff020024),

              Color(0xff090979),

              Color(0xff00D4FF),

            ],

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

          ),

        ),




        child: FadeTransition(


          opacity: animation,


          child: Center(


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
                        Colors.blue,

                        blurRadius:
                        35,

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
                      FontWeight.w900,


                      letterSpacing:
                      5,


                    ),


                  ),


                ),




                const SizedBox(

                  height: 30,

                ),




                const Text(


                  "CONFIGES",


                  style:
                  TextStyle(


                    color:
                    Colors.white,


                    fontSize:
                    34,


                    fontWeight:
                    FontWeight.w900,


                    letterSpacing:
                    6,


                  ),


                ),




                const SizedBox(

                  height: 5,

                ),




                const Text(


                  "ABDELLALI PRO",


                  style:
                  TextStyle(


                    color:
                    Colors.lightBlueAccent,


                    fontSize:
                    24,


                    fontWeight:
                    FontWeight.bold,


                    letterSpacing:
                    3,


                  ),


                ),




                const SizedBox(

                  height: 20,

                ),




                const Text(


                  "FAST • SECURE • CONFIGS",


                  style:
                  TextStyle(


                    color:
                    Colors.white70,


                    fontSize:
                    14,


                    letterSpacing:
                    2,


                  ),


                ),




                const SizedBox(

                  height: 35,

                ),




                const CircularProgressIndicator(


                  color:
                  Colors.white,


                ),



              ],


            ),


          ),


        ),


      ),


    );


  }


}
