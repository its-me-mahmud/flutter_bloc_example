import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc({this.userRepository}) : super(UsersInitial());

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is FetchUsers) {
      try {
        yield UsersLoading();
        final users = await userRepository.fetchUsers();
        yield UsersLoaded(userModel: users);
      } catch (error) {
        yield UsersError(error: error);
      }
    } else if (event is FetchRefreshUsers) {
      try {
        yield UsersLoaded(userModel: []);
        yield UsersLoading();
        final users = await userRepository.fetchUsers();
        yield UsersLoaded(userModel: users);
      } catch (error) {
        yield UsersError(error: error);
      }
    }
  }
}
