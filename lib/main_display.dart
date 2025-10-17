import 'package:flutter/material.dart';




class MainDisplay extends StatefulWidget {

  MainDisplay({super.key});


  @override
  State<MainDisplay> createState() => _mainDisplayState();
}

class _mainDisplayState extends State<MainDisplay> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          Container(),
          Text('메인으로 바꿈2'),
        ]
      ),
    );
  }
}


