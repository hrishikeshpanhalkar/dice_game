import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 2;
  AnimationController _controller;
  CurvedAnimation animation;
  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      //print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        // print("Completed!");
        _controller.reverse();
      }
    });
  }

  void diceFun() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dice Game"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: diceFun,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                              'assets/images/dice-png-$leftDiceNumber.png'))),
                )),
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: diceFun,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                              "assets/images/dice-png-$rightDiceNumber.png"))),
                ))
              ],
            ),
            RaisedButton(
              onPressed: diceFun,
              textColor: Colors.black,
              child: Text('Click Here'),
            ),
          ],
        ),
      ),
    );
  }
}
