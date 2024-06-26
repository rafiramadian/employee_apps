import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  UserBloc({
    required UserRepository repository,
  })  : _repository = repository,
        super(UserInitial()) {
    on<FetchUserList>(_fetchUserList);
    on<AddUser>(_addUser);
    on<UpdateUser>(_updateUser);
    on<DeleteUser>(_deleteUser);
  }

  Future<void> _fetchUserList(FetchUserList event, emit) async {
    final currentState = state;
    if (currentState is UserLoaded &&
        currentState.hasReachedMax &&
        !event.initialFetch) return;

    try {
      if (currentState is UserInitial) {
        final users = await _repository.fetchUserList(page: 1);
        emit(UserLoaded(
          users: users.data,
          currentPage: 1,
          totalPages: users.totalPages,
          totalUser: users.total,
        ));
      } else if (event.initialFetch) {
        emit(UserLoading());
        final users = await _repository.fetchUserList(page: 1);
        emit(UserLoaded(
          users: users.data,
          currentPage: 1,
          totalPages: users.totalPages,
          totalUser: users.total,
        ));
      } else if (currentState is UserLoaded) {
        final nextPage = currentState.currentPage + 1;
        final users = await _repository.fetchUserList(page: nextPage);
        emit(UserLoaded(
          users: currentState.users + users.data,
          currentPage: nextPage,
          totalPages: users.totalPages,
          totalUser: users.total,
        ));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _addUser(AddUser event, emit) async {
    emit(UserLoading());
    try {
      await _repository.addUser(
        event.name,
        event.job,
      );
      emit(AddUserSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _updateUser(UpdateUser event, emit) async {
    emit(UserLoading());
    try {
      await _repository.updateUser(
        event.name,
        event.job,
        event.id,
      );
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _deleteUser(DeleteUser event, emit) async {
    emit(UserLoading());
    try {
      await _repository.deleteUser(event.id);
      emit(DeleteUserSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
