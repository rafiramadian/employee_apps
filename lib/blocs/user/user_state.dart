part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final int currentPage;
  final int totalPages;
  final int totalUser;

  const UserLoaded({
    required this.users,
    required this.currentPage,
    required this.totalPages,
    required this.totalUser,
  });

  bool get hasReachedMax => currentPage >= totalPages;

  UserLoaded copyWith({
    List<User>? users,
    int? currentPage,
    int? totalPages,
    int? totalUser,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalUser: totalUser ?? this.totalUser,
    );
  }

  @override
  List<Object> get props => [users, currentPage, totalPages, totalUser];
}

class AddUserSuccess extends UserState {}

class UpdateUserSuccess extends UserState {}

class DeleteUserSuccess extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
