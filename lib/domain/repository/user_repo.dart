import 'package:flutter_assessment/data/model/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> getUserList({int? page, int? perPage});
}
