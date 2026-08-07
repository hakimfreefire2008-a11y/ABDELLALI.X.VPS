import 'package:flutter/material.dart';

class SshScreen extends StatelessWidget {

  const SshScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("SSH Servers"),
      ),


      body: const Center(

        child: Text(
          "SSH CONFIGS",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );

  }

}
