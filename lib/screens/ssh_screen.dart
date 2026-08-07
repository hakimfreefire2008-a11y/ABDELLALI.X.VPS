import 'package:flutter/material.dart';
import '../services/server_service.dart';


class SshScreen extends StatelessWidget {

  const SshScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final servers = ServerService.servers
        .where((s) => s.type == "SSH")
        .toList();


    return Scaffold(

      appBar: AppBar(
        title: const Text("SSH Servers"),
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
                "${server.host}\nPing: ${server.ping} ms",
              ),


              trailing: Icon(

                server.online
                    ? Icons.check_circle
                    : Icons.cancel,

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
