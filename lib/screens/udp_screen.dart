import 'package:flutter/material.dart';

class UdpScreen extends StatelessWidget {

  const UdpScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("UDP CUSTOM"),
      ),


      body: ListView(

        padding: const EdgeInsets.all(16),

        children: const [

          Card(
            child: ListTile(
              leading: Icon(Icons.network_check),
              title: Text("UDP Config 1"),
              subtitle: Text("Fast UDP Tunnel"),
            ),
          ),


          Card(
            child: ListTile(
              leading: Icon(Icons.speed),
              title: Text("UDP Config 2"),
              subtitle: Text("Low Ping Server"),
            ),
          ),

        ],

      ),

    );

  }

}
