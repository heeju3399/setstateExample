import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

void main() {
  runApp(const MyApp());
}

final Set<WordPair> saved = <WordPair>{};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWord(),
    );
  }
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> _suggestions = generateWordPairs().take(10).toList();

  Widget _buildSuggestions() {
    print('build suggestions pass!!!!!!!!!!!!!!!!!!!!!!!');
    Iterable<Widget> tiles =
        _suggestions.map((wordPair) => _buildRow(wordPair)); //여기서 10번돌림
    print('title???? ${tiles.length}');
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];

    return ListView(padding: const EdgeInsets.all(16), children: divided);
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('Startip name Genetator'),
        actions: [
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Cart();
    }));
    setState(() {});
  }
}

class RandomWord extends StatefulWidget {
  const RandomWord({Key? key}) : super(key: key);

  @override
  State<RandomWord> createState() => _RandomWordState();
}
