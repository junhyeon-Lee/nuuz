import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateNotifierProvider<IsLoadingProvider, bool>((ref) {
  return IsLoadingProvider();
});

class IsLoadingProvider extends StateNotifier<bool> {
  IsLoadingProvider() : super(false);

  isLoading() => state ? state = false : state = true;
}
