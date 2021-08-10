part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

//added by the presentation layer whenever it needs more Posts to present
class PostFetched extends PostEvent {}
