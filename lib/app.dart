import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './home.dart';

class PixaSearchApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PixaSearchAppState();
  }
}

class _PixaSearchAppState extends State<PixaSearchApp> {

  String _str = '';

  void _changeValue(String value){
    print('this is changed $value');
    setState((){
      // _str = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: PixabayHomePage(_str, _changeValue),
    );
  }
}