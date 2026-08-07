import 'package:flutter/material.dart';

class V2RayScreen extends StatelessWidget {

  const V2RayScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("V2Ray Configs"),
      ),


      body: ListView(

        padding: const EdgeInsets.all(16),

        children: const [

          Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text("VLESS"),
              subtitle: Text("VLESS Configurations"),
            ),
          ),


          Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text("VMESS"),
              subtitle: Text("VMESS Configurations"),
            ),
          ),


          Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text("TROJAN"),
              subtitle: Text("TROJAN Configurations"),
            ),
          ),

        ],

      ),

    );

  }

}
