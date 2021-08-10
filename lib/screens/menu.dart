import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int currentIndex = 0;
  double itemSize = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlue,
        ],
        stops: <double>[0.3, 0.0],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 10,
            child: Column(
              children: [
                Icon(Icons.menu, size: 32,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
