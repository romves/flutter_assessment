import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/config/dio_client.dart';
import 'package:flutter_assessment/data/model/user_response.dart';

class UserService {
  final dioClient = DioClient();

  Future<UserResponse> getUsers({int? page = 1, int? perPage = 10}) async {
    try {
      final response = await dioClient.dio
          .get('https://reqres.in/api/users', queryParameters: {
        'page': page,
        'per_page': perPage,
      });

      return UserResponse.fromJson(response.data);
    } on DioException catch (_) {
      return Future.error({
        'message': "Internal Server Error",
      });
    }
  }
}
