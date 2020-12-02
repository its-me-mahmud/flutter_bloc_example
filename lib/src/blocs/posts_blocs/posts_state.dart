part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();

  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  const PostsLoading();

  @override
  List<Object> get props => [];
}

class PostsLoaded extends PostsState {
  final List<PostModel> postModel;
  final bool hasReachedMax;

  const PostsLoaded({
    this.postModel = const <PostModel>[],
    this.hasReachedMax = false,
  });

  PostsLoaded copyWith({
    List<PostModel> postModel,
    bool hasReachedMax,
  }) {
    return PostsLoaded(
      postModel: postModel ?? this.postModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [postModel, hasReachedMax];
}

class PostsError extends PostsState {
  final String error;

  const PostsError({this.error});

  @override
  List<Object> get props => [error];
}
