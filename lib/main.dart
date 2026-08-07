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


        colorSchemeSeed: Colors.blue,


        useMaterial3: true,


      ),



      home: const SplashScreen(),



    );


  }


}
