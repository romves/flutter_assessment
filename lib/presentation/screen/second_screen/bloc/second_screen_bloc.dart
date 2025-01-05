import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/domain/entity/user.dart';

part 'second_screen_event.dart';
part 'second_screen_state.dart';

class SecondScreenBloc extends Bloc<SecondScreenEvent, SecondScreenState> {
  SecondScreenBloc() : super(SecondScreenInitial()) {
    on<UserSelected>((event, emit) {
      emit(SecondScreenUserSelected(user: event.user, name: state.name));
    });

    on<SecondScreenInitialized>((event, emit) {
      emit(SecondScreenNameProvided(name: event.name, user: state.user));
    });
  }
}
