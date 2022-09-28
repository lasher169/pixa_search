import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './home.dart';
import 'models/pixa_results.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PixaSearchApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PixaSearchAppState();
  }
}

class _PixaSearchAppState extends State<PixaSearchApp> {
  final myController = TextEditingController();
  Future<PixaResults>? futurePixaResults;

  Future<PixaResults> fetchPixaResults() async {

    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=30140123-68f55f4801af03afee214a954&q=${myController.text}&image_type=photo&pretty=true'));

    print('calling method ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      PixaResults pixaResults = PixaResults.fromJson(jsonDecode(response.body));
      // print('image ${pixaResults?.hits?[0].largeImageURL}');
      return pixaResults;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() async{
    setState(() {
      if (myController.text.length > 3) {
        // print('Second text field ${myController.text}');
        this.futurePixaResults = fetchPixaResults();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('redraw');
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: PixabayHomePage(myController, this.futurePixaResults),
    );
  }
}
