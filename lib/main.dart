import 'package:async_widgets/future_builder_demo.dart';
import 'package:async_widgets/stream_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Examples(),
    );
  }
}

class Examples extends StatelessWidget {
  const Examples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Widgets")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.brown[300],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FutureBuilderDemo()));
              },
              title: const Text("Future Builder"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.brown[300],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StreamBuilderDemo()));
              },
              title: const Text("Stream Builder"),
            ),
          )
        ],
      ),
    );
  }
}
