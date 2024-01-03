import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportCategoryProvider = StateNotifierProvider.autoDispose<ReportCategoryProvider, int>((ref) {
  return ReportCategoryProvider();
});

class ReportCategoryProvider extends StateNotifier<int> {
  ReportCategoryProvider() : super(0);

  tapCategory(int index) => state = index;
}

final reportDropdownProvider = StateNotifierProvider.autoDispose<ReportDropdownProvider, String>((ref) {
  return ReportDropdownProvider();
});

class ReportDropdownProvider extends StateNotifier<String> {
  ReportDropdownProvider() : super('Talk_Repo_0006');

  final valueList = ['Talk_Repo_0006', 'Talk_Repo_0007', "Talk_Repo_0008", 'Talk_Repo_0009', 'Talk_Repo_0010', 'Talk_Repo_0011'];

  setValue(String value) {
    state = value;
  }

  setValueInt(int index) {
    state = valueList[index];
  }
}

final reportBodyProvider = StateNotifierProvider.autoDispose<ReportBodyProvider, bool>((ref) {
  return ReportBodyProvider();
});

class ReportBodyProvider extends StateNotifier<bool> {
  ReportBodyProvider() : super(false);

  TextEditingController controller = TextEditingController();

  checkController() {
    controller.text.isEmpty ? state = true : state = false;
  }
}
