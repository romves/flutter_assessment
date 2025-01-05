part of 'third_screen_bloc.dart';

sealed class ThirdScreenEvent extends Equatable {
  const ThirdScreenEvent();

  @override
  List<Object> get props => [];
}

final class UserFetched extends ThirdScreenEvent {
  final int? page;
  final int? perPage;

  const UserFetched({
    this.page,
    this.perPage,
  });
}

final class UserRefresh extends ThirdScreenEvent {}
