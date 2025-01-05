import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/config/logger.dart';

class DioClient {
  final Dio _dio = Dio();
  Dio get dio => _dio;

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.info('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (res, handler) => {
          AppLogger.info('Response: ${res.statusCode} ${res.statusMessage}'),
          handler.next(res),
        },
        onError: (DioException e, handler) {
          AppLogger.error('Dio error', e, e.stackTrace);
          return handler.next(e);
        },
      ),
    );
  }
}
