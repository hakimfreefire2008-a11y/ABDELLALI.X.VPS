import 'package:flutter/material.dart';

void main() {
  runApp(const ConfigesApp());
}

class ConfigesApp extends StatelessWidget {
  const ConfigesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CONFIGES ABDELLALI PRO',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),

      home: const HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {

  const HomePage({super.key});


  final List<Map<String, dynamic>> items = const [

    {
      "title": "SSH Servers",
      "icon": Icons.terminal,
    },

    {
      "title": "V2Ray VLESS VMESS TROJAN",
      "icon": Icons.security,
    },

    {
      "title": "UDP CUSTOM",
      "icon": Icons.network_check,
    },

    {
      "title": "SLOW DNS",
      "icon": Icons.dns,
    },

    {
      "title": "HTTP CUSTOM FILES",
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


      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [


            Card(

              child: Padding(

                padding: const EdgeInsets.all(16),

                child: Row(

                  children: [

                    const Icon(
                      Icons.vpn_lock,
                      size: 55,
                    ),


                    const SizedBox(width: 15),


                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: const [

                        Text(
                          "CONFIGES ABDELLALI PRO",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Text(
                          "Fast Config Manager",
                        ),

                      ],

                    )

                  ],

                ),

              ),

            ),



            const SizedBox(height: 20),



            Expanded(

              child: ListView.builder(

                itemCount: items.length,


                itemBuilder: (context,index){


                  return Card(

                    child: ListTile(

                      leading: Icon(
                        items[index]["icon"],
                        size: 35,
                      ),


                      title: Text(
                        items[index]["title"],
                      ),


                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),


                      onTap: () {},


                    ),

                  );


                },

              ),

            ),


          ],

        ),

      ),



      floatingActionButton:
          FloatingActionButton.extended(


            onPressed: () {},


            icon: const Icon(
              Icons.add,
            ),


            label: const Text(
              "CREATE CONFIG",
            ),

          ),


    );

  }

}
