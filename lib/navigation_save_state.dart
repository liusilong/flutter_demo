import 'package:flutter/material.dart';
import 'dart:math';

class NavigationBarWithStateWidget extends StatefulWidget {
  @override
  _NavigationBarWithStateWidgetState createState() =>
      _NavigationBarWithStateWidgetState();
}

class _NavigationBarWithStateWidgetState
    extends State<NavigationBarWithStateWidget> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with AutomaticKeepAliveClientMixin {
  int num = 0;

  @override
  void initState() {
    super.initState();
    num = Random().nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('$num'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
