import 'dart:math';
import 'dart:ui';

import 'package:electric_scooter_clone/widgets/scooter_widget.dart';
import 'package:flutter/material.dart';

class ScooterScreen extends StatefulWidget {
  const ScooterScreen({Key key}) : super(key: key);


  @override
  _ScooterScreenState createState() => _ScooterScreenState();
}

class _ScooterScreenState extends State<ScooterScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get maxHeight => MediaQuery.of(context).size.height;

  void _onDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _animationController.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: lerpDouble(1.0, .8, _animationController.value),
            alignment: Alignment.topRight,
            child: GestureDetector(
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10 * 3 * _animationController.value)),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 20),
                        blurRadius: 12,
                      )
                    ]),
                child: Stack(
                  children: [ScooterWidget(scooterDragPercent: _animationController.value,)],
                ),
              ),
            ),
          );
        });
  }
}
