import 'package:flutter_assessment/data/datasource/remote/user_service.dart';
import 'package:flutter_assessment/data/model/user_response.dart';
import 'package:flutter_assessment/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepository {
  final UserService remoteDataSource;

  UserRepoImpl({required this.remoteDataSource});

  @override
  Future<UserResponse> getUserList({int? page, int? perPage}) async {
    return remoteDataSource.getUsers(page: page, perPage: perPage);
  }
}
