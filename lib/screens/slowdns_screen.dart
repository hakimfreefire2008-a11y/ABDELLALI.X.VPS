import 'package:flutter/material.dart';

class SlowDnsScreen extends StatelessWidget {

  const SlowDnsScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("SLOW DNS"),
      ),


      body: const Center(

        child: Text(
          "SLOW DNS CONFIGS",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );

  }

}
