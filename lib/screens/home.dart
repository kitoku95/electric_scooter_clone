import 'package:electric_scooter_clone/screens/menu.dart';
import 'package:electric_scooter_clone/screens/scooter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'map.dart';

class Home extends StatefulWidget{
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Stack(
        children: [
          MenuScreen(),
          MapScreen(),
          ScooterScreen()
        ],
      ),
    );
  }


}