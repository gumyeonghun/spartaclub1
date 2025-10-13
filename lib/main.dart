import 'package:flutter/material.dart';
import 'dart:math';
import 'package:spartaclub1/main_display.dart';
import 'dart:io';

void main(
    ) {

  runApp( MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({super.key});
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainDisplay()
    );
    print("object");

  }
}




