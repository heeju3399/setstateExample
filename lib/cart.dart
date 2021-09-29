import 'package:ex54/main.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final tiles = saved.map((WordPair pair) {
      return ListTile(
        title: Text(pair.asPascalCase),
        onTap: () {
          setState(() {
            saved.remove(pair);
          });
        },
      );
    });

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[]; //선그어주기....
    return Scaffold(
      appBar: AppBar(
        title: Text('Saced Suggestions'),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
