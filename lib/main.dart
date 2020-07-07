import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Animation',
      debugShowCheckedModeBanner: false,
      home: HeartAnimation2(),
    );
  }
}

class HeartAnimation2 extends StatefulWidget {
  HeartAnimation2({Key key}) : super(key: key);

  @override
  _HeartAnimation2State createState() => _HeartAnimation2State();
}

class _HeartAnimation2State extends State<HeartAnimation2>
    with SingleTickerProviderStateMixin {
  double ratio = 1.0;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            FadeTransition(
              opacity:
                  Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                curve: Curves.fastOutSlowIn,
                parent: animationController,
              )),
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))
                    .animate(CurvedAnimation(
                  curve: Curves.fastOutSlowIn,
                  parent: animationController,
                )),
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Icon(Icons.favorite,
                      color: Colors.red, size: 100 * ratio),
                ),
              ),
            ),
            GestureDetector(
              onTapDown: (d) {
                setState(() {
                  ratio = 0.9;
                });
              },
              onTapUp: (d) {
                setState(() {
                  ratio = 1.0;
                });
                animationController.forward();
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child:
                    Icon(Icons.favorite, color: Colors.red, size: 100 * ratio),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
