import 'package:async_widgets/coffee_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FutureBuilderDemo extends StatefulWidget {
  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  String coffeeUrl = 'https://api.sampleapis.com/coffee';

  Future<List<Coffee>> getCoffeeData(String type) async {
    try {
      final response = await http.get(Uri.parse('$coffeeUrl/$type'));
      Iterable l = json.decode(response.body);
      List<Coffee> coffees =
          List<Coffee>.from(l.map((model) => Coffee.fromJson(model)));
      return coffees;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Builder"),
      ),
      body: Center(
        child: FutureBuilder<List<Coffee>>(
            future: getCoffeeData('iced'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {}
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                '${snapshot.data![index].image}',
                                errorBuilder: (context, exception, stackTrace) {
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  color: Colors.brown,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            '${snapshot.data![index].title}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.brown,
                                              child: Text(
                                                  '${snapshot.data![index].id}')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Container();
            }),
      ),
    );
  }
}
