import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/repositories/selected_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_user_event.dart';
part 'selected_user_state.dart';

class SelectedUserBloc extends Bloc<SelectedUserEvent, SelectedUserState> {
  final SelectedUserRepository _repository;
  SelectedUserBloc({required SelectedUserRepository repository})
      : _repository = repository,
        super(SelectedUserInitial()) {
    on<SelectUser>(_selectUser);
    on<FetchSelectedUsers>(_fetchSelectedUsers);
    on<UnselectUser>(_unselectUser);
  }

  Future<void> _fetchSelectedUsers(FetchSelectedUsers event, emit) async {
    emit(SelectedUserLoading());
    try {
      final List<User> result = await _repository.fetchSelectedUsers();
      emit(SelectedUserLoaded(result));
    } catch (e) {
      emit(SelectedUserError(e.toString()));
    }
  }

  Future<void> _selectUser(SelectUser event, emit) async {
    emit(SelectedUserLoading());
    try {
      final List<User> result = await _repository.addUser(user: event.user);
      emit(SelectedUserLoaded(result));
    } catch (e) {
      emit(SelectedUserError(e.toString()));
    }
  }

  Future<void> _unselectUser(UnselectUser event, emit) async {
    emit(SelectedUserLoading());
    try {
      final List<User> result = await _repository.deleteUser(id: event.id);
      emit(SelectedUserLoaded(result));
    } catch (e) {
      emit(SelectedUserError(e.toString()));
    }
  }
}
