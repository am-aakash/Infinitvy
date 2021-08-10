import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_scroll/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(PostInitial());
  final http.Client httpClient;

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state; //from Bloc class

    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          if (posts.isEmpty) {
            yield currentState.copywith(hasReachedMax: true, posts: []);
          } else {
            yield PostSuccess(
              posts: currentState.posts + posts,
              hasReachedMax: false,
            );
          }
        }
      } catch (_) {
        yield PostFaliure();
      }
    }
  }

  bool _hasReachedMax(PostState state) {
    return state is PostSuccess && state.hasReachedMax;
  }

  _fetchPosts(int start, int limit) async {
    String url =
        'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit';
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          body: rawPost['body'],
          title: rawPost['title'],
        );
      }).toList();
    } else {
      throw Exception('Error fetching post');
    }
  }
}
