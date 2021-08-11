import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_scroll/bloc/post_bloc.dart';
import 'package:flutter_infinite_scroll/ui/posts_list.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        toolbarHeight: 50,
        title: Text(
          'Infinity Scroll',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: PostsList(),
      ),

      // In our PostsPage widget, we use BlocProvider to create and provide an instance of PostBloc to the subtree.
      // Also, we add a PostFetched event so that when the app loads, it requests the initial batch of Posts.
    );
  }
}
