part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class FetchUsers extends UsersEvent {
  const FetchUsers();

  @override
  List<Object> get props => [];
}

class FetchRefreshUsers extends UsersEvent {
  const FetchRefreshUsers();

  @override
  List<Object> get props => [];
}
