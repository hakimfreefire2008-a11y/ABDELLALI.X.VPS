import 'package:flutter/material.dart';
import '../services/server_service.dart';
import '../services/action_service.dart';


class UdpScreen extends StatelessWidget {

  const UdpScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final servers = ServerService.servers
        .where((s) => s.type == "UDP")
        .toList();


    return Scaffold(

      appBar: AppBar(
        title: const Text("UDP CUSTOM"),
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: servers.length,


        itemBuilder: (context,index){


          final server = servers[index];


          final config =
              "TYPE: ${server.type}\n"
              "HOST: ${server.host}\n"
              "COUNTRY: ${server.country}\n"
              "PING: ${server.ping} ms";


          return Card(

            child: Padding(

              padding: const EdgeInsets.all(12),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Text(

                    "${server.country} ${server.name}",

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),


                  const SizedBox(height: 8),


                  Text(
                    server.host,
                  ),


                  Text(
                    "Ping: ${server.ping} ms",
                  ),


                  const SizedBox(height: 5),


                  Row(

                    children: [


                      Icon(

                        server.online
                            ? Icons.check_circle
                            : Icons.cancel,

                        color: server.online
                            ? Colors.green
                            : Colors.red,

                      ),


                      const SizedBox(width: 5),


                      Text(

                        server.online
                            ? "ONLINE"
                            : "OFFLINE",

                      ),


                    ],

                  ),


                  const SizedBox(height: 12),


                  Row(

                    children: [


                      FilledButton.icon(

                        onPressed: (){

                          ActionService.copyConfig(
                            config,
                          );

                        },

                        icon: const Icon(
                          Icons.copy,
                        ),

                        label: const Text(
                          "COPY",
                        ),

                      ),


                      const SizedBox(width: 10),


                      OutlinedButton.icon(

                        onPressed: (){

                          ActionService.shareConfig(
                            config,
                          );

                        },

                        icon: const Icon(
                          Icons.share,
                        ),

                        label: const Text(
                          "SHARE",
                        ),

                      ),


                    ],

                  ),


                ],

              ),

            ),

          );


        },

      ),

    );

  }

}
