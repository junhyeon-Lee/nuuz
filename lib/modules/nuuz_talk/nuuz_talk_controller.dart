import 'package:flutter_riverpod/flutter_riverpod.dart';

final nuuzTalkProvider = StateNotifierProvider<NuuzTalkProvider, int>((ref) {
  return NuuzTalkProvider();
});

class NuuzTalkProvider extends StateNotifier<int> {
  NuuzTalkProvider() : super(0);

  onTap(int index) =>state = index;
}

