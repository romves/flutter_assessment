part of 'third_screen_bloc.dart';

abstract class ThirdScreenState extends Equatable {
  final int page;
  final int perPage;

  const ThirdScreenState({
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class ThirdScreenInitial extends ThirdScreenState {}

class ThirdScreenLoading extends ThirdScreenState {}

class ThirdScreenLoaded extends ThirdScreenState {
  final List<UserEntity> users;
  final bool hasReachedMax;

  const ThirdScreenLoaded({
    required this.users,
    required super.page,
    this.hasReachedMax = false,
    super.perPage,
  });

  ThirdScreenLoaded copyWith({
    List<UserEntity>? users,
    int? page,
    bool? hasReachedMax,
    int? perPage,
  }) {
    return ThirdScreenLoaded(
      users: users ?? this.users,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object?> get props => [users, page, perPage, hasReachedMax];
}

class ThirdScreenError extends ThirdScreenState {
  final String message;

  const ThirdScreenError({required this.message});

  @override
  List<Object?> get props => [message];
}
