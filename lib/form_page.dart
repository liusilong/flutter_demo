import 'package:flutter/material.dart';
import 'dart:ui';

class FormPageWidget extends StatefulWidget {
  @override
  _FormPageWidgetState createState() => _FormPageWidgetState();
}

class _FormPageWidgetState extends State<FormPageWidget> {
  final formKey = GlobalKey<FormState>();

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email:'),
                  validator: (input) =>
                      !input.contains('@') ? 'Not a valid Email' : null,
                  onSaved: (input) => _email = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password:'),
                  validator: (input) => input.length < 8 ? 'invalid' : null,
                  onSaved: (input) => _password = input,
                  obscureText: true,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: _submit,
                          color: Colors.blue,
                          child: Text('Sign in'),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    // 验证 form 中的输入是正确
    if (formKey.currentState.validate()) {
      // 将 form 中每一个 TextFormField 的进行保存
      formKey.currentState.save();
      print('$_email');
      print('$_password');
    }
  }
}
