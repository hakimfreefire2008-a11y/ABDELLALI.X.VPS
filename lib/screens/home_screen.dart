import 'package:flutter/material.dart';

import 'ssh_screen.dart';
import 'v2ray_screen.dart';
import 'udp_screen.dart';
import 'slowdns_screen.dart';
import 'hc_files_screen.dart';
import 'create_config_screen.dart';
import 'my_configs_screen.dart';
import 'help_screen.dart';



class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final items = [


      {
        "title":"Create Config",
        "icon":Icons.add_circle,
        "page":const CreateConfigScreen(),
      },


      {
        "title":"My Configs",
        "icon":Icons.folder,
        "page":const MyConfigsScreen(),
      },


      {
        "title":"SSH Servers",
        "icon":Icons.terminal,
        "page":const SshScreen(),
      },


      {
        "title":"V2Ray VLESS / VMESS / TROJAN",
        "icon":Icons.security,
        "page":const V2RayScreen(),
      },


      {
        "title":"UDP CUSTOM",
        "icon":Icons.network_check,
        "page":const UdpScreen(),
      },


      {
        "title":"SLOW DNS",
        "icon":Icons.dns,
        "page":const SlowDnsScreen(),
      },


      {
        "title":"HTTP CUSTOM FILES",
        "icon":Icons.file_download,
        "page":const HcFilesScreen(),
      },


      {
        "title":"Help Developer",
        "icon":Icons.help,
        "page":const HelpScreen(),
      },


    ];



    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "CONFIGES ABDELLALI PRO",
        ),

        centerTitle:true,

      ),



      body:
      ListView.builder(


        padding:
        const EdgeInsets.all(16),


        itemCount:
        items.length,



        itemBuilder:(context,index){



          return Card(


            child:
            ListTile(



              leading:
              Icon(
                items[index]["icon"] as IconData,
                size:35,
              ),



              title:
              Text(
                items[index]["title"] as String,
              ),



              trailing:
              const Icon(
                Icons.arrow_forward_ios,
              ),



              onTap:(){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(_)=>
                    items[index]["page"] as Widget,

                  ),

                );


              },



            ),


          );


        },


      ),



    );


  }


}
