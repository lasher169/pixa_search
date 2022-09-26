import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PixabayHomePage extends StatelessWidget {
  PixabayHomePage({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController(text: '');
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
                      child:Text('Pixabay'),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                        margin: EdgeInsets.only(),
                        child: CupertinoSearchTextField(
                          controller: _textController,
                          placeholder: 'Search',
                          onChanged: (String value) {
                            print('this is value $value');
                          },
                        )
                    ),
                  ],)
            ),
          )
      ),
      body: CupertinoScrollbar(
        child: ListView.builder(
          itemBuilder:(context, index) {
            return Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      title: Text(items[index]),
                    ),
                    Divider(
                      height: 100,
                    )
                  ],
                )
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}