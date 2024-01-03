import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/user_info/terms.dart';
import 'package:nuuz/models/user_info/termslist.dart';
import 'package:nuuz/util/log_print.dart';

import 'terms_condition_service.dart';

final useProvider = StateNotifierProvider<UseProvider, bool>((ref) {
  return UseProvider();
});

class UseProvider extends StateNotifier<bool> {
  UseProvider() : super(false);

  void agreeButton() => state ? state = false : state = true;

  void allAgree() => state = true;

  void allDisAgree() => state = false;
}

final policyProvider = StateNotifierProvider<PolicyProvider, bool>((ref) {
  return PolicyProvider();
});

class PolicyProvider extends StateNotifier<bool> {
  PolicyProvider() : super(false);

  void agreeButton() => state ? state = false : state = true;

  void allAgree() => state = true;

  void allDisAgree() => state = false;
}

final marketingProvider = StateNotifierProvider<MarketingProvider, bool>((ref) {
  return MarketingProvider();
});

class MarketingProvider extends StateNotifier<bool> {
  MarketingProvider() : super(false);

  void agreeButton() => state ? state = false : state = true;

  void allAgree() => state = true;

  void allDisAgree() => state = false;
}

final allAgreeProvider = StateNotifierProvider<AllAgreeProvider, bool>((ref) {
  return AllAgreeProvider();
});

class AllAgreeProvider extends StateNotifier<bool> {
  AllAgreeProvider() : super(false);

  void agreeButton() => state ? state = false : state = true;

  void allAgree() => state = true;
}

final startProvider = StateNotifierProvider<StartProvider, bool>((ref) {
  return StartProvider();
});

class StartProvider extends StateNotifier<bool> {
  StartProvider() : super(false);

  agreeAndStart() => state = true;
}

final formProvider = StateNotifierProvider<FormProvider, Terms>((ref) {
  return FormProvider();
});

class FormProvider extends StateNotifier<Terms> {
  FormProvider() : super(Terms(terms: '', privacy: '', marketing: '', caution: ''));
  final termsRepository = TermsRepository();
  String term = '';
  String privacy = '';
  String marketing = '';
  String caution = '';

  getForms() async {
    TermsList? data = await termsRepository.getForm();
    safePrint('양식들');
    safePrint(data?.form?.length);
    if (data!.form != null) {
      for (int i = 0; i < data.form!.length; i++) {
        if (data.form![i].type == "terms") {
          term = data.form![i].content!;
        } else if (data.form![i].type == "privacy") {
          privacy = data.form![i].content!;
        } else if (data.form![i].type == "marketing") {
          marketing = data.form![i].content!;
        } else if (data.form![i].type == "caution") {
          caution = data.form![i].content!;
        }

        state = Terms(terms: term, privacy: privacy, marketing: marketing, caution: caution);
      }
    }
  }
}
