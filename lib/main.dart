import 'package:flutter/material.dart';
import 'package:sandboxhsi_sesi_5/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Data Santri HSI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
