part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

/* ****************************************************************************************************************
  Our presentation layer will need to have several pieces of information in order to properly lay itself out:

    PostInitial- will tell the presentation layer it needs to render a loading indicator while the initial batch of posts are loaded

    PostSuccess- will tell the presentation layer it has content to render
        posts- will be the List<Post> which will be displayed
        hasReachedMax- will tell the presentation layer whether or not it has reached the maximum number of posts

    PostFailure- will tell the presentation layer that an error has occurred while fetching posts
  *********************************************************************************************************************/
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
  })
  //We implemented copyWith so that we can copy an instance of PostSuccess and update zero or more properties conveniently
  {
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
