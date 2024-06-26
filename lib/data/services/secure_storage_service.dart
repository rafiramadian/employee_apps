import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorageService;
  SecureStorageService({
    required FlutterSecureStorage secureStorageService,
  }) : _secureStorageService = secureStorageService;

  final Logger _log = Logger('Secure Storage Service');

  final String keySelectedUser = 'keySelectedUser';

  Future<void> write({
    required String key,
    required String data,
  }) async {
    _log.info('WRITE METHOD | Key: $key | Data: $data');
    try {
      await _secureStorageService.write(key: key, value: data);
      _log.shout('WRITE METHOD | Status: Success');
    } catch (e) {
      _log.severe('WRITE METHOD | Error: ${e.toString()}');
      rethrow;
    }
  }

  Future<String?> read({required String key}) async {
    _log.info('READ METHOD | Key: $key');
    try {
      final String? response = await _secureStorageService.read(key: key);
      _log.shout('READ METHOD | Response: $response');

      return response;
    } catch (e) {
      _log.severe('READ METHOD | Error: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> delete({required String key}) async {
    _log.info('DELETE METHOD | Key: $key');
    try {
      await _secureStorageService.delete(key: key);
      _log.shout('DELETE METHOD | Status: Success');
    } catch (e) {
      _log.severe('DELETE METHOD | Error: ${e.toString()}');
      rethrow;
    }
  }
}
