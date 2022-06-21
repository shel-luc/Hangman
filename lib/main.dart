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

List<Map<String, dynamic>> list = [
  {"title": "Angular", "subtitle": "javascript framework by google"},
  {"title": "react", "subtitle": "javascript Library by Facebook"},
  {"title": "flutter", "subtitle": "framework of dart"},
  {"title": "firebase", "subtitle": "database create by google"},
];
final _random = Random();
var element = list[_random.nextInt(list.length)];
var button = [
  "Q",
  "W",
  "E",
  "R",
  "T",
  "Y",
  "U",
  "I",
  "O",
  "P",
  "A",
  "S",
  "D",
  "F",
  "G",
  "H",
  "J",
  "K",
  "L",
  "Z",
  "X",
  "C",
  "V",
  "B",
  "N",
  "M"
];

class _HomePageState extends State<HomePage> {
  int score = 5;
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
          ListTile(title: const Text("Replay"), onTap: () {}),
          ListTile(
              title: const Text("Help"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageScreen()));
              }),
          ListTile(
              title: const Text("Quit"),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              })
        ]),
      ),
      appBar: AppBar(
          title: const Text("Hangman"),
          actionsIconTheme: const IconThemeData(color: Colors.yellow),
          actions: [
            Center(
                child: Text(
              '$score',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 30),
            )),
            IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          ]),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("****** $index", textAlign: TextAlign.center),
            subtitle: Text(element["subtitle"], textAlign: TextAlign.center),
          );
        },
      ),
  );
  }
}

class PageScreen extends StatefulWidget {
  const PageScreen({Key? key}) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You win",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Replay")),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Quit")),
          ],
        ),
      ),
    );
  }
}
