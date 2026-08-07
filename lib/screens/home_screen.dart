import 'package:flutter/material.dart';

import '../services/server_service.dart';

import 'ssh_screen.dart';
import 'v2ray_screen.dart';
import 'udp_screen.dart';
import 'slowdns_screen.dart';
import 'hc_files_screen.dart';
import 'help_screen.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();

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



    final total =
        ServerService.servers.length;



    final online =
        ServerService.servers
            .where((s) => s.online)
            .length;



    final pages = [



      {
        "title": "SSH SERVERS",
        "icon": Icons.terminal,
        "page": const SshScreen(),
      },


      {
        "title": "V2RAY VLESS VMESS TROJAN",
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


      {
        "title": "HELP & DEVELOPER",
        "icon": Icons.support_agent,
        "page": const HelpScreen(),
      },


    ];



    return Scaffold(



      appBar: AppBar(


        title:

        const Text(

          "CONFIGES ABDELLALI PRO",

        ),


        centerTitle: true,



        actions: [



          IconButton(


            onPressed:
            loading ? null : refreshServers,


            icon:

            loading

                ? const SizedBox(

              width:20,

              height:20,

              child:
              CircularProgressIndicator(),

            )


                :

            const Icon(

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

                size: 40,

              ),



              title:

              Text(

                "ONLINE $online / $total",

              ),



              subtitle:

              const Text(

                "Server Status",

              ),



            ),



          ),





          Expanded(



            child: ListView.builder(



              padding:

              const EdgeInsets.all(16),



              itemCount:

              pages.length,





              itemBuilder:

                  (context,index){



                return Card(



                  elevation: 3,



                  child: ListTile(



                    leading:

                    Icon(

                      pages[index]["icon"]

                      as IconData,

                      size: 35,

                    ),





                    title:

                    Text(

                      pages[index]["title"]

                      as String,



                      style:

                      const TextStyle(

                        fontWeight:

                        FontWeight.bold,

                      ),



                    ),





                    trailing:

                    const Icon(

                      Icons.arrow_forward_ios,

                    ),





                    onTap: () {



                      Navigator.push(



                        context,



                        MaterialPageRoute(



                          builder: (_) =>

                          pages[index]["page"]

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
