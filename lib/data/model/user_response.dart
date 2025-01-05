import 'package:flutter_assessment/data/model/user.dart';

class UserResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> users;

  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: UserModel.fromJsonList(json['data']),
    );
  }
}
