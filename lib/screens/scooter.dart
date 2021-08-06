import 'package:flutter/material.dart';

class ScooterScreen extends StatefulWidget {
  const ScooterScreen({ Key key }) : super(key: key);

  @override
  _ScooterScreenState createState() => _ScooterScreenState();
}

class _ScooterScreenState extends State<ScooterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: const<BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 20),
            blurRadius: 12,
          )
        ]
      ),
      child: Stack(
        children: [
          
        ],
      ),
    );
  }
}