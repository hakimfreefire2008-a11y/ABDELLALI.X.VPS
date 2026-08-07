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
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGES ABDELLALI PRO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.vpn_lock,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              'CONFIGES ABDELLALI PRO',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            FilledButton(
              onPressed: () {},
              child: const Text('CONNECT'),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () {},
              child: const Text('CREATE CONFIG'),
            ),

          ],
        ),
      ),
    );
  }
}
