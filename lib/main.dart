import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scratcher/scratcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

final scratchKey = GlobalKey<ScratcherState>();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> scratchCardDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Scratcher(
            key: scratchKey,
            accuracy: ScratchAccuracy.high,
            brushSize: 40,
            threshold: 70,
            image: Image.asset(
              'images/reward_cover.png',
              fit: BoxFit.cover,
            ),
            onChange: (value) {
              print("Scratch progress: $value%");
            },
            onThreshold: () {
              setState(() {
                scratchKey.currentState.reveal(
                  duration: Duration(milliseconds: 2000),
                );
              });
            },
            child: Container(
              color: Colors.white,
              height: 300,
              width: 300,
              child: Center(
                child: Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Rewards'),
              background: Container(
                color: Colors.amber,
                height: 200,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => scratchCardDialog(context),
                    child: Image.asset(
                      'images/reward_cover.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              childCount: 7,
            ),
          )
        ],
      ),
    );
  }
}
