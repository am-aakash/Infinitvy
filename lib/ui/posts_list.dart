import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_scroll/bloc/post_bloc.dart';

import 'widgets/bottom_loader.dart';
import 'widgets/post_list_item.dart';

class PostsList extends StatefulWidget {
  //PostsList is a StatefulWidget because it will need to maintain a ScrollController.
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  late PostBloc _postBloc;

  //In initState, we add a listener to our ScrollController so that we can respond to scroll events.
  //We also access our PostBloc instance via context.read<PostBloc>()
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  //Our build method returns a BlocBuilder.
  //BlocBuilder is a Flutter widget from the flutter_bloc package which handles building a widget in response to new bloc states.
  //Any time our PostBloc state changes, our builder function will be called with the new PostState
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostFaliure) {
          return Center(
            child: Text('failed to fetch posts',
                style: TextStyle(color: Colors.black, fontSize: 16)),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text(
                'No posts',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          }
          //else
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader() //indicate to the user that we are loading more posts
                  : PostListItem(
                      post: state.posts[index]); //render an individual Post
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // We need to remember to clean up after ourselves and dispose of our ScrollController when the StatefulWidget is disposed
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //   ->
  //Whenever the user scrolls, we calculate how far you have scrolled down the page
  //and if our distance is ≥ 90% of our maxScrollextent
  //we add a PostFetched event in order to load more posts.

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
