import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  final List<Map<String, dynamic>> services = const [

    {
      "name": "SSH Servers",
      "icon": Icons.terminal,
    },

    {
      "name": "V2Ray VLESS / VMESS / TROJAN",
      "icon": Icons.security,
    },

    {
      "name": "UDP CUSTOM",
      "icon": Icons.network_check,
    },

    {
      "name": "SLOW DNS",
      "icon": Icons.dns,
    },

    {
      "name": "HTTP CUSTOM FILES",
      "icon": Icons.file_download,
    },

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "CONFIGES ABDELLALI PRO",
        ),
        centerTitle: true,
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: services.length,


        itemBuilder: (context,index){

          return Card(

            child: ListTile(

              leading: Icon(
                services[index]["icon"],
                size: 35,
              ),


              title: Text(
                services[index]["name"],
              ),


              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),


              onTap: () {},

            ),

          );

        },

      ),

    );

  }
}
