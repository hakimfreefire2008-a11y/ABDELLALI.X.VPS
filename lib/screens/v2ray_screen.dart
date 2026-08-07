import 'package:flutter/material.dart';
import '../services/server_service.dart';


class V2RayScreen extends StatelessWidget {

  const V2RayScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final servers = ServerService.servers
        .where((s) =>
            s.type == "VLESS" ||
            s.type == "VMESS" ||
            s.type == "TROJAN")
        .toList();


    return Scaffold(

      appBar: AppBar(
        title: const Text("V2Ray Servers"),
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: servers.length,


        itemBuilder: (context,index){


          final server = servers[index];


          return Card(

            child: ListTile(

              leading: Text(
                server.country,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),


              title: Text(
                server.name,
              ),


              subtitle: Text(
                "${server.type}\n${server.host}\nPing: ${server.ping} ms",
              ),


              trailing: Icon(

                server.online
                    ? Icons.wifi
                    : Icons.wifi_off,

                color: server.online
                    ? Colors.green
                    : Colors.red,

              ),

            ),

          );


        },

      ),

    );

  }

}
