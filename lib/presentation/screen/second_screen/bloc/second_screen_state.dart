part of 'second_screen_bloc.dart';

sealed class SecondScreenState extends Equatable {
  final String? name;
  final UserEntity? user;

  const SecondScreenState({
    this.name,
    this.user,
  });

  @override
  List<Object> get props => [];
}

final class SecondScreenInitial extends SecondScreenState {}

final class SecondScreenUserSelected extends SecondScreenState {
  const SecondScreenUserSelected({required UserEntity super.user, super.name});
}

final class SecondScreenNameProvided extends SecondScreenState {
  const SecondScreenNameProvided({required String super.name, super.user});
}
