import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/posts_blocs/posts_bloc.dart';

class UserPostPage extends StatefulWidget {
  @override
  _UserPostPageState createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostsBloc _postsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postsBloc = context.read<PostsBloc>();
    _postsBloc.add(FetchPosts());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _postsBloc.add(FetchRefreshPosts()),
          ),
        ],
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLoaded) {}
        },
        builder: (context, state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostsError) {
            return Center(child: Text(state.error));
          } else if (state is PostsLoaded) {
            if (state.postModel.isEmpty) {
              return Center(
                child: Text(
                  'No users found!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.postModel.length
                    : state.postModel.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.postModel.length
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('userId:\t${state.postModel[index].userId}'),
                            Text('id:\t${state.postModel[index].id}'),
                            Text('title:\t${state.postModel[index].title}'),
                            Text('body:\t${state.postModel[index].body}'),
                          ],
                        );
                },
              ),
            );
          }
          return Center(
            child: Text(
              'Failed to fetch posts!',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).errorColor,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postsBloc.add(FetchPosts());
    }
  }

  Future<Null> _onRefresh() async => _postsBloc.add(FetchRefreshPosts());
}
