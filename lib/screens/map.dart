import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double get maxHeight => MediaQuery.of(context).size.height;
  double minHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight * .45,
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20)
        ),
        child: Image.asset('assets/images/map.png',
          fit: BoxFit.cover,),
      ),
    );
  }
}
