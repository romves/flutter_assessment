part of 'second_screen_bloc.dart';

sealed class SecondScreenEvent extends Equatable {
  const SecondScreenEvent();

  @override
  List<Object> get props => [];
}

final class UserSelected extends SecondScreenEvent {
  final UserEntity user;

  const UserSelected({required this.user});
}

final class SecondScreenInitialized extends SecondScreenEvent {
  final String name;

  const SecondScreenInitialized({required this.name});
}
