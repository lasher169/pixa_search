import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/pixa_results.dart';

class PixabayHomePage extends StatelessWidget {
  Future<PixaResults> futurePixaResults;
  var myController;

  PixabayHomePage(this.myController, this.futurePixaResults);

  // final TextEditingController _textController = TextEditingController(text: '');
  List items = List.generate(50, (index) => "This is item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            height: 150,
            child: CupertinoNavigationBar(
                // backgroundColor: Colors.white,
                middle: Column(
              children: [
                Container(
                  child: Text('Pixabay'),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                    margin: EdgeInsets.only(),
                    child: CupertinoSearchTextField(
                      controller: myController,
                      placeholder: 'Search',
                      // onChanged: (String value) {
                      //   str = value;
                      //   print('this is value $str');
                      //   // if(value.length >= 4) {
                      //   //  changeValue(value);
                      //   // }
                      // },
                    )),
              ],
            )),
          )),
      body: CupertinoScrollbar(
        child: FutureBuilder<Album>(
          future: futureAlbum,
        // ListView.builder(
        //   itemBuilder: (context, index) {
        //     final Hits hits = this.futurePixaResults.hits![index];
        //     return Material(
        //         child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Image.network(''),
        //         Divider(
        //           height: 100,
        //         )
        //       ],
        //     ));
        //   },
        //   itemCount: items.length,
        // ),
      ),
    );
  }
}
