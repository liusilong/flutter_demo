import 'package:flutter/material.dart';
import 'NavigationBarWidget.dart';

class AppLifecyclePage extends StatefulWidget {
  @override
  _AppLifecyclePageState createState() => _AppLifecyclePageState();
}

class _AppLifecyclePageState extends State<AppLifecyclePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(onPressed: () {
            navigator(3, context);
          }),
        ),
      ),
    );
  }
}
