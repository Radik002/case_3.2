import 'dart:async';
import 'package:case_32/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JsonScreen(),
    );
  }
}

class JsonScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'User ID:${data.userId.toString()}',
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.work),
                            Text(
                              'ID:${data.id.toString()}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Название: \n\n${data.title}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Описание: \n\n${data.body}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
  }

  Future<Post> fetchPost() async {
    final map = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/Posts/1'));

    if (map.statusCode == 200) {
      return Post.fromJson(map.body);
    } else {
      throw Exception('Failed to load Post');
    }
  }
}
