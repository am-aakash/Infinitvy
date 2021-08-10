part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFaliure extends PostState {}

class PostSuccess extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  const PostSuccess({required this.posts, required this.hasReachedMax});

  // func to change the members
  PostSuccess copywith({
    required List<Post> posts,
    required bool hasReachedMax,
  }) {
    return PostSuccess(
      posts: posts, // posts if passed, else posts in object.
      hasReachedMax: hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
