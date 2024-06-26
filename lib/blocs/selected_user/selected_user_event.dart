part of 'selected_user_bloc.dart';

abstract class SelectedUserEvent extends Equatable {
  const SelectedUserEvent();

  @override
  List<Object> get props => [];
}

class FetchSelectedUsers extends SelectedUserEvent {}

class SelectUser extends SelectedUserEvent {
  final User user;

  const SelectUser(this.user);

  @override
  List<Object> get props => [user];
}

class UnselectUser extends SelectedUserEvent {
  final int id;

  const UnselectUser(this.id);

  @override
  List<Object> get props => [id];
}
