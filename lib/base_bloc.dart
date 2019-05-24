import 'dart:core';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  // ignore: close_sinks
  final _errorSubject = PublishSubject<String>();

  Sink<String> get errorSink => _errorSubject.sink;

  Stream<String> get errorStream => _errorSubject.stream;
}

class HomeBloc extends BaseBloc {}

var homeBloc = HomeBloc();
