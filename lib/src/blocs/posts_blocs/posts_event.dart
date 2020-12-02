part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class FetchPosts extends PostsEvent {
  const FetchPosts();

  @override
  List<Object> get props => [];
}

class FetchRefreshPosts extends PostsEvent {
  const FetchRefreshPosts();

  @override
  List<Object> get props => [];
}
