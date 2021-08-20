import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll/ui/posts_list.dart';
import 'package:flutter_infinite_scroll/ui/posts_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infinite Scroll',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: PostsPage(),
    );
  }
}
