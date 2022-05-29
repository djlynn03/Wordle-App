import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'wordlist.dart';
import 'dart:math';
import 'package:collection/collection.dart';

List<String> WORDLIST = wl;

// Future<List<String>> _loadWordList() async {
//   final String? wordList = await rootBundle.loadString('assets/data.txt');
//   // print(wordList);
//   return wordList!.split('\n');
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _row = 0;
  List<String> _enteredWords = ["", "", "", "", "", ""];
  List<List<int>> _wordStates = [];
  String _gameState = "playing";

  String currentWord = WORDLIST[Random().nextInt(WORDLIST.length)];

  final List<MaterialStateProperty<Color>> _colors = [
    MaterialStateProperty.all<Color>(Color.fromARGB(255, 68, 68, 68)),
    MaterialStateProperty.all<Color>(Colors.yellow),
    MaterialStateProperty.all<Color>(Colors.green)
  ];
  Function eq = const ListEquality().equals;
  MaterialStateProperty<Color> _getColor(int i, int j) {
    print(_wordStates);
    try {
      return _colors[_wordStates[i][j]];
    } catch (e) {
      return MaterialStateProperty.all<Color>(Colors.grey);
    }
  }

  List<int> getWordState(String word, String currentWord) {
    List<int> next = [0, 0, 0, 0, 0];
    String parsed = "";

    for (var i = 0; i < 5; i++) {
      if (word[i] == currentWord[i]) {
        next[i] = 2;
        parsed += word[i];
      }
    }
    for (var i = 0; i < 5; i++) {
      if (next[i] == 2) {
        continue;
      }
      if (currentWord.contains(word[i]) &&
          word[i].allMatches(currentWord).length >
              word[i].allMatches(parsed).length) {
        next[i] = 1;
        parsed += word[i];
      }
    }
    return next;
  }

  @override
  Widget build(BuildContext context) {
    if (_wordStates.isNotEmpty &&
        eq(_wordStates[_wordStates.length - 1], [2, 2, 2, 2, 2])) {
      _gameState = "won";
    } else if (_row > 5) {
      _gameState = "lost";
    }
    // print(currentWord);
    List<String> row1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"];
    List<String> row2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"];
    List<String> row3 = ["⏎", "z", "x", "c", "v", "b", "n", "m", "⌫"];
    return MaterialApp(
      title: 'Wordle',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: AppBar(
            title: Text("Wordle"),
            centerTitle: true,
          ),
        ),
        body: ListView(children: <Widget>[
          SizedBox(
            width: 400,
            height: 400,
            // child: CustomPaint(
            //   painter: OpenPainter(),
            // )),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i in [0, 1, 2, 3, 4, 5])
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (var j in [0, 1, 2, 3, 4])
                            TextButton(
                              child: _enteredWords[i].length > j
                                  ? Text(_enteredWords[i][j])
                                  : const Text(""),
                              onPressed: null,
                              style: ButtonStyle(
                                  backgroundColor: _getColor(i, j),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: Colors.black)))),
                            ),
                        ]),
                ]),
          ),
          SizedBox(
              width: 400,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var i in row1)
                    SizedBox(
                      child: TextButton(
                          child: Text(i),
                          style: TextButton.styleFrom(
                            fixedSize: const Size.fromWidth(0),
                            backgroundColor: Colors.blue[100],
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_enteredWords[_row].length < 5) {
                                _enteredWords[_row] += i;
                              }
                            });
                          }),
                      width: 35,
                    ),
                ],
              )),
          SizedBox(
              width: 400,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var i in row2)
                    SizedBox(
                      child: TextButton(
                          child: Text(i),
                          style: TextButton.styleFrom(
                            fixedSize: const Size.fromWidth(0),
                            backgroundColor: Colors.blue[100],
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_enteredWords[_row].length < 5) {
                                _enteredWords[_row] += i;
                              }
                            });
                          }),
                      width: 35,
                    ),
                ],
              )),
          SizedBox(
              width: 400,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var i in row3)
                    SizedBox(
                      child: TextButton(
                          child: Text(i),
                          style: TextButton.styleFrom(
                            fixedSize: const Size.fromWidth(0),
                            backgroundColor: Colors.blue[100],
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print(_row);
                            setState(() {
                              if (i == "⌫" && _enteredWords[_row].isNotEmpty) {
                                _enteredWords[_row] = _enteredWords[_row]
                                    .substring(
                                        0, _enteredWords[_row].length - 1);
                              } else if (i == "⏎" &&
                                  _row <= 5 &&
                                  _enteredWords[_row].length == 5) {
                                _wordStates.add(getWordState(
                                    _enteredWords[_row], currentWord));
                                _row++;
                              } else if (_enteredWords[_row].length < 5 &&
                                  i != "⏎" &&
                                  i != "⌫") {
                                _enteredWords[_row] += i;
                              }
                            });
                          }),
                      width: 35,
                    ),
                ],
              )),
          SizedBox(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 10,
              ),
              _gameState != "playing"
                  ? _gameState == "won"
                      ? const Text("You won!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green))
                      : Text("You lost! The word was '$currentWord'.",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                  : const Text(""),
              _gameState == "won"
                  ? TextButton(
                      child: const Text("Play Again"),
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(150),
                        backgroundColor: Colors.blue[100],
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _row = 0;
                          _enteredWords = ["", "", "", "", "", ""];
                          _wordStates = [];
                          _gameState = "playing";
                          currentWord =
                              WORDLIST[Random().nextInt(WORDLIST.length)];
                        });
                      },
                    )
                  : TextButton(
                      child: const Text("Reset"),
                      style: TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(150),
                        backgroundColor: Colors.blue[50],
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _row = 0;
                          _enteredWords = ["", "", "", "", "", ""];
                          _wordStates = [];
                          _gameState = "playing";
                          currentWord =
                              WORDLIST[Random().nextInt(WORDLIST.length)];
                        });
                      },
                    )
            ]),
          ),
        ]),
      ),
      theme: ThemeData(
        fontFamily: 'Arial',
        primarySwatch: Colors.blue,
      ),
    );
  }
}
