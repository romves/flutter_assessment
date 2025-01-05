import 'package:flutter_assessment/domain/usecase/is_palindrome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreenState {
  FirstScreenState({
    this.showDialog = false,
    this.isPalindrome = false,
    this.name = '',
    this.palindrome = '',
  });

  final bool isPalindrome;
  final bool showDialog;

  final String name;
  final String palindrome;

  FirstScreenState copyWith({
    String? name,
    String? palindrome,
    bool? isPalindrome,
    bool? showDialog,
  }) {
    return FirstScreenState(
      name: name ?? this.name,
      palindrome: palindrome ?? this.palindrome,
      isPalindrome: isPalindrome ?? this.isPalindrome,
      showDialog: showDialog ?? this.showDialog,
    );
  }
}

class FirstScreenCubit extends Cubit<FirstScreenState> {
  FirstScreenCubit() : super(FirstScreenState());

  void checkPalindrome() {
    final palindrome = state.palindrome;

    if (palindrome.isEmpty) {
      return;
    }

    final isPalindrome = IsPalindromeUseCase().call(params: palindrome);

    emit(state.copyWith(isPalindrome: isPalindrome, showDialog: true));
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setPalindrome(String palindrome) {
    emit(state.copyWith(palindrome: palindrome));
  }

  void closeDialog() {
    emit(state.copyWith(showDialog: false));
  }
}
