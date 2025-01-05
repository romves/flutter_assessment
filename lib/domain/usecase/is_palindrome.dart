
class IsPalindromeUseCase {
  bool call({required String params}) {
    final input = params.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    final reversed = input.split('').reversed.join('');
    return input == reversed;
  }
}
