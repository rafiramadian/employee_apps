part of 'selected_user_bloc.dart';

abstract class SelectedUserState extends Equatable {
  const SelectedUserState();

  @override
  List<Object> get props => [];
}

class SelectedUserInitial extends SelectedUserState {}

class SelectedUserLoading extends SelectedUserState {}

class SelectedUserLoaded extends SelectedUserState {
  final List<User> users;

  const SelectedUserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class SelectedUserError extends SelectedUserState {
  final String message;

  const SelectedUserError(this.message);

  @override
  List<Object> get props => [message];
}
