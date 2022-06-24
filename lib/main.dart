import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "dart:math";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Map<String, String>> list = [
  {"title": "Angular", "subtitle": "javascript framework by google"},
  {"title": "react", "subtitle": "javascript Library by Facebook"},
  {"title": "flutter", "subtitle": "framework of dart"},
  {"title": "firebase", "subtitle": "database create by google"},
];
final _random = Random();
//var element = list[_random.nextInt(list.length)];

class _HomePageState extends State<HomePage> {
  final List<String> button = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"];
// CREATEKEYBOARDBUTTON
  Container createkeyboardButton(char) => Container(
        margin: const EdgeInsets.all(3),
        child: MaterialButton(
          minWidth: 35,
          height: 45,
          color: Colors.yellow,
          onPressed: () {
            onClick(char);
          },
          child: Text(
            char,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );

// createKeybard
  List<Row> createKeyboard() => button
      .map((stringCharAlphabet) => stringCharAlphabet
          .split("")
          .map((char) => createkeyboardButton(char))
          .toList())
      .toList()
      .map((listButton) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listButton,
          ))
      .toList();

  int _score = 5;
  String _word = "";
  String _desc = "";
  String _response = "";
  Map element = {};

  @override
  void onClick(char) {
    setState(() {
      if (_word.contains(char)) {
        for (var i = 0; i < _word.length; i++) {
          if (_word[i] == char) {
            List word = _response.split("");
            word[i] = char;
            _response = word.join('');
          }
          if (_word == _response) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PageScreen(
                          status: true,
                        )));
          }
        }
      } else {
        _score--;
        if (_score == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PageScreen(status: false)));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _score = 5;
    element = list[_random.nextInt(list.length)];
    _word = element["title"].toUpperCase();
    _desc = element["subtitle"];
    for (var i = 0; i < _word.length; i++) {
      _response += "*";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Center(
                child: Text(
              "Hangman",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          ListTile(title: const Text("Replay"), onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
          }),
          ListTile(
              title: const Text("Help"),
              onTap: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
              }),
          ListTile(
              title: const Text("Quit"),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
              })
        ]),
      ),
      appBar: AppBar(
          title: const Text("Hangman"),
          actionsIconTheme: const IconThemeData(color: Colors.yellow),
          actions: [
            Center(
                child: 
                Text(
              '$_score',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 30),
            )),
            IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          ]),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            children: [
              Text(_response),
              const SizedBox(
                height: 15,
              ),
              Text(_desc),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: createKeyboard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageScreen extends StatelessWidget {
  const PageScreen({Key? key, required this.status}) : super(key: key);
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),
          child: Column(children: [
            ((status) ? const Text("You win") : const Text("you loose")),
            const SizedBox(
              height: 170,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
                    },
                    child: const Text("Replay")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
                    },
                    child: const Text("Quit")),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
