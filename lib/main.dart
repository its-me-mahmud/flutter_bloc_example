import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/blocs/users_blocs/users_bloc.dart';
import 'src/repository/user_repository.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UsersBloc(userRepository: UserRepository()),
        ),
        // BlocProvider(
        //   create: (_) => PostsBloc(postRepository: PostRepository()),
        // ),
      ],
      child: App(),
    ),
  );
}
