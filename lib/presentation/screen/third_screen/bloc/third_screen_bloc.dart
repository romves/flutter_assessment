import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/domain/entity/user.dart';
import 'package:flutter_assessment/domain/usecase/get_list_user.dart';

part 'third_screen_event.dart';
part 'third_screen_state.dart';

class ThirdScreenBloc extends Bloc<ThirdScreenEvent, ThirdScreenState> {
  final GetListUserUseCase getListUserUseCase;
  List<UserEntity> currentUsers = [];
  bool hasReachedMax = false;

  ThirdScreenBloc({
    required this.getListUserUseCase,
  }) : super(ThirdScreenInitial()) {
    on<UserFetched>(_onUserFetched);
    on<UserRefresh>(_onUserRefresh);
  }

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<ThirdScreenState> emit,
  ) async {
    if (state is ThirdScreenLoading) return;
    if (hasReachedMax) return;

    try {
      if (state is ThirdScreenInitial) {
        emit(ThirdScreenLoading());
        final result =
            await getListUserUseCase(page: 1, perPage: state.perPage);
        currentUsers = result.users;
        emit(ThirdScreenLoaded(
          users: currentUsers,
          page: 1,
          hasReachedMax: result.totalPages == result.page,
        ));
        return;
      }

      final currentState = state;
      if (currentState is ThirdScreenLoaded && !currentState.hasReachedMax) {
        final result = await getListUserUseCase(
          page: currentState.page + 1,
          perPage: currentState.perPage,
        );
        currentUsers.addAll(result.users);
        emit(currentState.copyWith(
          users: currentUsers,
          page: currentState.page + 1,
          hasReachedMax: result.totalPages == result.page,
        ));
      }
    } catch (error) {
      emit(ThirdScreenError(message: error.toString()));
    }
  }

  Future<void> _onUserRefresh(
    UserRefresh event,
    Emitter<ThirdScreenState> emit,
  ) async {
    emit(ThirdScreenInitial());
    currentUsers.clear();
    hasReachedMax = false;
    add(const UserFetched());
  }
}
