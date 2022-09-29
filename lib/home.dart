import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/pixa_results.dart';

class PixabayHomePage extends StatelessWidget {
  Future<PixaResults>? futurePixaResults;
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
                      )),
                ],
              )),
            )),
        body: CupertinoScrollbar(
          child: FutureBuilder<PixaResults>(
              future: futurePixaResults,
              builder:
                  (BuildContext context, AsyncSnapshot<PixaResults> snapshot) {
                if (!snapshot.hasData) {
                  // print('no data');
                  return Text('');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.hits?.length,
                    itemBuilder: (context, index) {
                      // print('yes data');
                      String? tags = snapshot.data?.hits?[index].tags;
                      String? user = snapshot.data?.hits?[index].user;
                      String? imageUrl =
                          snapshot.data?.hits?[index].largeImageURL;
                      return Material(
                          child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(imageUrl as String),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                '${user}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                '${tags}',
                              ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            color: Colors.transparent,
                          )
                        ],
                      ));
                    },
                  );
                }
              }),
          // child: Text(''),
        ));
  }
}
