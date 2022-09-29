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
  String? pixaKey;

  Future<PixaResults> fetchPixaResults() async {

    var finalUrl =   'https://pixabay.com/api/?image_type=photo&pretty=true&key=${pixaKey}&q=${myController.text}';
    print('final ${finalUrl}');

    final response = await http.get(Uri.parse(finalUrl as String));

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

  Future<void> loadAsset(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/my_config.json');
    final dynamic jsonMap = jsonDecode(jsonString);
    print('pixaKey ${jsonMap['pixaUrl']}');
    pixaKey = jsonMap['pixaUrl'];
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    myController.addListener(_printLatestValue);
    loadAsset(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() async {
    setState(() {
      if (myController.text.length > 3) {
        // print('Second text field ${myController.text}');
        this.futurePixaResults = fetchPixaResults();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('redraw');
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
