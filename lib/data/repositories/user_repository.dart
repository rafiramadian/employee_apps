import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/services/dio_service.dart';

class UserRepository {
  final DioService _dioService;
  UserRepository({
    required DioService dioService,
  }) : _dioService = dioService;

  Future<Users> fetchUserList({required int page}) async {
    try {
      final result = await _dioService.get('?page=$page');

      return Users.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(String name, String job) async {
    try {
      await _dioService.post(
        '',
        {'name': name, 'job': job},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String name, String job, int id) async {
    try {
      await _dioService.put(
        '/$id',
        {'name': name, 'job': job},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _dioService.delete('/$id');
    } catch (e) {
      rethrow;
    }
  }
}
