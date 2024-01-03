import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';

Widget loadingScreen() {
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final isLoading = ref.watch(loadingProvider);
      return Visibility(
        visible: isLoading,
        child: Container(
          color: CustomColor.lightDark,
          child: const Center(
            child: CustomIndicator(''),
          ),
        ),
      );
    },
  );
}

final loadingProvider = StateNotifierProvider<LoadingProvider, bool>((ref) {
  return LoadingProvider();
});

class LoadingProvider extends StateNotifier<bool> {
  LoadingProvider() : super(false);

  void isLoadingTrue() {
    state = true;
    Future.delayed(const Duration(seconds: 8), () {
      if (state) {
        state = false;
      }
    });
  }

  void isLoadingFalse() => state = false;
}
