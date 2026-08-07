import 'package:flutter/material.dart';

import 'services/server_service.dart';
import 'screens/home_screen.dart';



Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();


  await ServerService.loadServers();


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


      home: const HomeScreen(),


    );


  }


}
