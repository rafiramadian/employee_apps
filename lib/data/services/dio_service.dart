// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class DioService {
  final Dio _dio;
  final Connectivity _connectivity;
  DioService({
    required Dio dio,
    required Connectivity connectivity,
  })  : _dio = dio,
        _connectivity = connectivity;

  final String _baseUrl = 'https://reqres.in/api/users';
  final Logger _log = Logger('Dio Service');

  Future<dynamic> get(String path) async {
    _log.info('GET METHOD | Path: $path');
    try {
      await _checkConnectivity();

      final response = await _dio.get('$_baseUrl$path');

      return _handleResponse(response, 'GET METHOD');
    } on DioException catch (e) {
      _handleException(e, 'GET METHOD');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    _log.info('POST METHOD | Path: $path | Data: $data');
    try {
      await _checkConnectivity();

      final response = await _dio.post(
        '$_baseUrl$path',
        data: data,
      );

      return _handleResponse(response, 'POST METHOD');
    } on DioException catch (e) {
      _handleException(e, 'POST METHOD');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String path,
    Map<String, dynamic> data,
  ) async {
    _log.info('PUT METHOD | Path: $path | Data: $data');
    try {
      await _checkConnectivity();

      final response = await _dio.put(
        '$_baseUrl$path',
        data: data,
      );

      return _handleResponse(response, 'PUT METHOD');
    } on DioException catch (e) {
      _handleException(e, 'PUT METHOD');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String path) async {
    _log.info('DELETE METHOD | Path: $path');
    try {
      await _checkConnectivity();

      final response = await _dio.delete('$_baseUrl$path');

      return _handleResponse(response, 'DELETE METHOD');
    } on DioException catch (e) {
      _handleException(e, 'DELETE METHOD');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _checkConnectivity() async {
    // Check for internet connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.other ||
        connectivityResult == ConnectivityResult.none) {
      throw 'No Internet Connection';
    }
  }

  dynamic _handleResponse(Response response, String method) {
    if ((response.statusCode ?? 300) < 299) {
      // Successful response
      _log.shout(
        '$method | Response: ${response.data}',
      );
      return response.data;
    } else {
      // Handle error response
      _log.severe(
        '$method | Error: (${response.statusCode}): ${response.statusMessage}',
      );
      throw '${response.statusCode}: ${response.statusMessage}';
    }
  }

  Never _handleException(DioException exception, String method) {
    _log.severe('$method | Dio Error: ${exception.message}');

    if (exception.type == DioExceptionType.connectionTimeout) {
      throw 'Connection Timeout';
    } else if (exception.type == DioExceptionType.sendTimeout) {
      throw 'Send Timeout';
    } else if (exception.type == DioExceptionType.receiveTimeout) {
      throw 'Receive Timeout';
    } else if (exception.type == DioExceptionType.badResponse) {
      // When the server responds with an error
      throw 'Response Exception: ${exception.response?.statusCode}';
    } else if (exception.type == DioExceptionType.cancel) {
      throw 'Request Cancelled';
    } else {
      throw 'Unexpected Error: ${exception.message}';
    }
  }
}
