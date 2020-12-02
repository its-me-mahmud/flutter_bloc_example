part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {
  const UsersLoading();

  @override
  List<Object> get props => [];
}

class UsersLoaded extends UsersState {
  final List<UserModel> userModel;

  const UsersLoaded({this.userModel});

  UsersLoaded copyWith({
    List<UserModel> userModel = const <UserModel>[],
  }) {
    return UsersLoaded(
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [userModel];
}

class UsersError extends UsersState {
  final String error;

  const UsersError({this.error});

  @override
  List<Object> get props => [error];
}
