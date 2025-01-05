import 'package:flutter_assessment/data/model/user_response.dart';
import 'package:flutter_assessment/domain/repository/user_repo.dart';

class GetListUserUseCase {
  final UserRepository userRepository;

  GetListUserUseCase({required this.userRepository});

  Future<UserResponse> call({int? page, int? perPage}) {
    return userRepository.getUserList(page: page, perPage: perPage);
  }
}
