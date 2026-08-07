import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';



void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ConfigesApp(),
  );

}



class ConfigesApp extends StatelessWidget {


  const ConfigesApp({super.key});



  @override
  Widget build(BuildContext context) {


    return MaterialApp(


      debugShowCheckedModeBanner: false,


      title: "CONFIGES ABDELLALI PRO",



      theme: ThemeData(


        brightness: Brightness.dark,


        useMaterial3: true,


        colorSchemeSeed: Colors.blue,


        scaffoldBackgroundColor:
        const Color(0xff050505),


      ),



      home: const SplashScreen(),



    );


  }


}
