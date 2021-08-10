import 'package:flutter/material.dart';

import 'gradient_text.dart';

class ScooterWidget extends StatefulWidget {
  const ScooterWidget({Key key, this.scooterDragPercent}) : super(key: key);

  final double scooterDragPercent;

  @override
  _ScooterWidgetState createState() => _ScooterWidgetState();
}

class _ScooterWidgetState extends State<ScooterWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _slideInAnimattionController;
  Animation<double> _slideInAnimation;

  Offset _scooterOffset = const Offset(0, 0);
  Offset _centerTextOffset = const Offset(0, 0);
  Offset _cardOffset = const Offset(1, -.2);

  double _bottomTextPosY = 120;

  @override
  void initState() {
    _slideInAnimattionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..addListener(() {
        setState(() {
          _scooterOffset = Offset(-1 + _slideInAnimation.value, 0);
          _centerTextOffset = Offset(1 - _slideInAnimation.value, 0);
          _bottomTextPosY = 70 + (50 * _slideInAnimation.value);
        });
      })
      ..forward();
    _slideInAnimation = CurvedAnimation(
        parent: _slideInAnimattionController, curve: Curves.ease);
    super.initState();
  }

  @override
  void dispose() {
    _slideInAnimattionController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScooterWidget oldWidget) {
    final double dragPercent = widget.scooterDragPercent;
    if (oldWidget.scooterDragPercent != dragPercent) {
      _scooterOffset = Offset(-.3 * dragPercent, -.3 * dragPercent);
      _bottomTextPosY = 120 + (-200 * dragPercent);
      _cardOffset = Offset(1 - dragPercent, (1 - dragPercent) * -.2);
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCenterText() {
    return FractionalTranslation(
        translation: _centerTextOffset,
        child: Transform.scale(
          scale: 1.0 - widget.scooterDragPercent.clamp(0.0, 0.1),
          child: Center(
            child: GradientText('Go',
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.blueAccent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
          ),
        ));
  }

  Widget _buildScooterImage(double height) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: height * .26,
      child: FractionalTranslation(
        translation: _scooterOffset,
        child: Transform.scale(
            scale: 1 + (widget.scooterDragPercent / 2),
            child: Image.asset(
              'assets/images/scooter.png',
            )),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      bottom: _bottomTextPosY,
      child: Container(
        child: Text(
          'go to where',
          style: new TextStyle(
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildBottomCard() {
    return FractionalTranslation(
      translation: _cardOffset,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 90,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Transform.scale(scale: widget.scooterDragPercent,
              child: Container(
                width: 100,
                height: 90,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(20 + (1 - widget.scooterDragPercent) * (10 * 4))),
                child: Center(
                  child: ImageIcon(
                    const AssetImage('assets/images/power.png'),
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),),
              SizedBox(
                width: 40,
              ),
              Row(
                children: [
                  Text(
                    'Swipe to off',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        _buildCenterText(),
        _buildScooterImage(height),
        _buildBottomText(),
        _buildBottomCard()
      ],
    );
  }
}
