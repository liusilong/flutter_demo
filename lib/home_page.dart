import 'package:flutter/material.dart';
import 'base_ui.dart';
import 'base_bloc.dart';

class HomePage extends BasePage {
  HomePage({Key key}) : super(key: key, bloc: homeBloc);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with BasicPage, ErrorHandlingMixin {
  @override
  String screenName() => 'HomePage';

  @override
  Widget body() {
    return Center(
      child: Text('this is a basic usage of a mixin'),
    );
  }

  @override
  Widget fab() {
    return FloatingActionButton(
      child: Icon(Icons.error),
      onPressed: () => widget.bloc.errorSink.add("A new error"),
    );
  }
}
