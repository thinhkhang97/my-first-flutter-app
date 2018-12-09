import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class RandomEnglishWord extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new RandomEnglishWordState();
    }
}

class RandomEnglishWordState extends State<RandomEnglishWord>{
  final litems = <String>[];
  final donItems = Set<String>();
  final TextEditingController eCtrl = new TextEditingController();
  final _words = <WordPair>[];
  final _checkedWords = new Set<WordPair>();
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('List to do'),
        ),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {});
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Text the todo'
              ),
            ),
            new Expanded(
              child: new ListView.builder(itemBuilder: (context, index) {
                  if(index < litems.length)
                  return _buildRow(litems[index], index, context);
                },
              )
            )
          ],
        ) 
      );
    }
    Widget _buildRow(String item, int index, BuildContext context) {
      final color = index % 2 == 0 ? Colors.red : Colors.blue;
      final isChecked = donItems.contains(item);

      return new Dismissible(
        key: new Key(item),
        onDismissed: (direction) {
          litems.remove(item);
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Delete a todo"),
          ));
        },
        background: new Container(
          color: Colors.red
        ),
        child: new ListTile(
          leading: new Icon(isChecked ? Icons.check_box : Icons.check_box_outline_blank, color: color),
          title: new Text(item, style: new TextStyle(fontSize: 18.0, color: color)),
          onTap: () {
            setState(() {
                        if(isChecked) {
                          donItems.remove(item);
                        } else {
                          donItems.add(item);
                        }
                      });
          },
        )
      );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'This is the title of app',
      home: new RandomEnglishWord()
    );
  }
}
