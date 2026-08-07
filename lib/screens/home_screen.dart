import 'package:flutter/material.dart';

import '../services/server_service.dart';

import 'ssh_screen.dart';
import 'v2ray_screen.dart';
import 'udp_screen.dart';
import 'slowdns_screen.dart';
import 'hc_files_screen.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen> {



  bool loading = false;



  Future<void> refreshServers() async {


    setState(() {

      loading = true;

    });


    await ServerService.loadServers();


    setState(() {

      loading = false;

    });


  }



  @override
  Widget build(BuildContext context) {


    final online =
        ServerService.servers
            .where((s) => s.online)
            .length;


    final total =
        ServerService.servers.length;



    final items = [


      {
        "title": "SSH Servers",
        "icon": Icons.terminal,
        "page": const SshScreen(),
      },


      {
        "title": "V2Ray VLESS / VMESS / TROJAN",
        "icon": Icons.security,
        "page": const V2RayScreen(),
      },


      {
        "title": "UDP CUSTOM",
        "icon": Icons.network_check,
        "page": const UdpScreen(),
      },


      {
        "title": "SLOW DNS",
        "icon": Icons.dns,
        "page": const SlowDnsScreen(),
      },


      {
        "title": "ABDE FILES",
        "icon": Icons.file_download,
        "page": const HcFilesScreen(),
      },


    ];



    return Scaffold(


      appBar: AppBar(


        title: const Text(
          "CONFIGES ABDELLALI PRO",
        ),


        centerTitle: true,


        actions: [


          IconButton(

            onPressed: loading
                ? null
                : refreshServers,


            icon: loading

                ? const CircularProgressIndicator()

                : const Icon(
                    Icons.refresh,
                  ),

          ),


        ],


      ),



      body: Column(


        children: [


          Card(


            margin:
            const EdgeInsets.all(16),


            child: ListTile(


              leading:
              const Icon(
                Icons.cloud_done,
                size: 35,
              ),


              title:
              Text(
                "Servers Online: $online / $total",
              ),


              subtitle:
              const Text(
                "Updated from server",
              ),


            ),


          ),



          Expanded(


            child: ListView.builder(


              padding:
              const EdgeInsets.all(16),


              itemCount:
              items.length,


              itemBuilder:
                  (context,index){



                return Card(


                  child: ListTile(


                    leading:
                    Icon(

                      items[index]["icon"]
                          as IconData,

                      size: 35,

                    ),



                    title:
                    Text(

                      items[index]["title"]
                          as String,

                    ),



                    trailing:
                    const Icon(
                      Icons.arrow_forward_ios,
                    ),



                    onTap: (){


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          items[index]["page"]
                              as Widget,

                        ),

                      );


                    },


                  ),


                );


              },


            ),


          ),


        ],


      ),


    );


  }


}
