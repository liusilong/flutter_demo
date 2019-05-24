import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'base_bloc.dart';

abstract class BasePage<T extends BaseBloc> extends StatefulWidget {
  final BaseBloc bloc;

  BasePage({Key key, this.bloc}) : super(key: key);
}

// 设置泛型通配符上限
abstract class BaseState<T extends BasePage> extends State<T> {
  String screenName();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}

// 限制只能和 BaseState 类的子类混入
mixin BasicPage<T extends BasePage> on BaseState<T> {
  // mixin 中可以声明抽象方法，混入类必须实现
  Widget body();

  // 该方法供子类重写
  Widget fab() => Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(screenName())),
      body: Container(
        child: body(),
        color: Colors.amber,
      ),
      floatingActionButton: fab(),
    );
  }
}

mixin ErrorHandlingMixin<T extends BasePage> on BaseState<T> {
  @override
  void initState() {
    super.initState();
    print('init...');
    // 监听错误消息的 Stream
    widget.bloc.errorStream
        .transform(new ThrottleStreamTransformer(
            (_) => TimerStream(true, const Duration(seconds: 2))))
        .listen((String error) =>
            showErrorSnackBar(error, scaffoldKey.currentState));
  }

  void showErrorSnackBar(String event, ScaffoldState context) {
    print('${context == null}');
    if (event != null) {
      context.showSnackBar(SnackBar(
        content: Text(event),
      ));
    }
  }
}
