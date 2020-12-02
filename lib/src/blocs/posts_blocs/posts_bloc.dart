import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/post_model.dart';
import '../../repository/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostsBloc({this.postRepository}) : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchPosts && !_hasReachedMax(currentState)) {
      if (currentState is PostsInitial) {
        yield PostsLoading();
        final posts = await postRepository.fetchPosts(startIndex: 0, limit: 10);
        if (posts == null) {
          yield PostsError(error: 'No posts found!');
        } else {
          yield PostsLoaded().copyWith(postModel: posts, hasReachedMax: false);
          return;
        }
      } else if (currentState is PostsLoaded) {
        final posts = await postRepository.fetchPosts(
          startIndex: currentState.postModel.length,
          limit: 10,
        );
        if (posts == null) {
          yield PostsError(error: 'No posts found!');
        } else {
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostsLoaded().copyWith(
                  postModel: currentState.postModel + posts,
                  hasReachedMax: false,
                );
        }
      }
    } else if (event is FetchRefreshPosts) {
      yield PostsLoaded().copyWith(postModel: []);
      yield PostsLoading();
      final posts = await postRepository.fetchPosts(
        startIndex: 0,
        limit: 10,
      );
      print(posts);
      yield PostsLoaded().copyWith(postModel: posts);
    }
  }
}

bool _hasReachedMax(PostsState state) =>
    state is PostsLoaded && state.hasReachedMax;
