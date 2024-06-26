part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserList extends UserEvent {
  final bool initialFetch;

  const FetchUserList({this.initialFetch = true});

  @override
  List<Object> get props => [initialFetch];
}

class AddUser extends UserEvent {
  final String name;
  final String job;

  const AddUser(this.name, this.job);

  @override
  List<Object> get props => [name, job];
}

class UpdateUser extends UserEvent {
  final String name;
  final String job;
  final int id;

  const UpdateUser(this.name, this.job, this.id);

  @override
  List<Object> get props => [name, job, id];
}

class DeleteUser extends UserEvent {
  final int id;

  const DeleteUser(this.id);

  @override
  List<Object> get props => [id];
}
