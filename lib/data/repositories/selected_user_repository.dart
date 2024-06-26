import 'dart:convert';

import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/services/secure_storage_service.dart';

class SelectedUserRepository {
  final SecureStorageService _secureStorageService;
  SelectedUserRepository({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;

  Future<List<User>> fetchSelectedUsers() async {
    late List<User> users;

    try {
      final String? result = await _secureStorageService.read(
        key: _secureStorageService.keySelectedUser,
      );

      if (result != null) {
        users = (json.decode(result) as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList();
      } else {
        users = [];
      }

      return users;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> addUser({
    required User user,
  }) async {
    late String encodedData;
    late List<User> users;

    try {
      final String? result = await _secureStorageService.read(
        key: _secureStorageService.keySelectedUser,
      );

      if (result != null) {
        users = (json.decode(result) as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList();

        if (!users.any((element) => element.id == user.id)) {
          users.add(user);
        }

        encodedData = json.encode(users.map((e) => e.toJson()).toList());
      } else {
        users = [user];
        encodedData = json.encode(users.map((e) => e.toJson()).toList());
      }

      await _secureStorageService.write(
        key: _secureStorageService.keySelectedUser,
        data: encodedData,
      );

      return users;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> deleteUser({required int id}) async {
    late String encodedData;
    late List<User> users;
    try {
      final String? result = await _secureStorageService.read(
        key: _secureStorageService.keySelectedUser,
      );

      users = (json.decode(result!) as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList();
      users.removeWhere(
        (element) => element.id == id,
      );
      encodedData = json.encode(users.map((e) => e.toJson()).toList());

      await _secureStorageService.write(
        key: _secureStorageService.keySelectedUser,
        data: encodedData,
      );

      return users;
    } catch (e) {
      rethrow;
    }
  }
}
