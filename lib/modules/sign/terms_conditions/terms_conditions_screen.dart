import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/sign/terms_conditions/terms_condition_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/self_diagnosis_appbar.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class TermsConditionsScreen extends ConsumerStatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends ConsumerState<TermsConditionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(loadingProvider.notifier).isLoadingTrue();
      await ref.watch(formProvider.notifier).getForms();
      ref.watch(loadingProvider.notifier).isLoadingFalse();
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final useContainer = ref.watch(useProvider);
    final usePolicy = ref.watch(policyProvider);
    final useMarketing = ref.watch(marketingProvider);

    final allAgreeState = ref.listen(allAgreeProvider, (previous, next) {
      if (next) {
        ref.watch(useProvider.notifier).allAgree();
        ref.watch(policyProvider.notifier).allAgree();
        ref.watch(marketingProvider.notifier).allAgree();
        safePrint(usePolicy.toString());
      } else {
        ref.watch(useProvider.notifier).allDisAgree();
        ref.watch(policyProvider.notifier).allDisAgree();
        ref.watch(marketingProvider.notifier).allDisAgree();
      }
    });

    final agreeAndStart = ref.listen(startProvider, (previous, next) {
      if (next) {
        context.go('/fillprofileScreen');
      }
    });

    return Stack(
      children: [
        Scaffold(
          appBar: SelfDiagnosisAppbar(
            context: context,
            title: 'Sign_Inup_0018'.tr(),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 844.h - MediaQuery.of(context).padding.top - 58.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      hSize(23),
                      ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColor.white,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ListTileTheme(
                              dense: true,
                              child: ConfigurableExpansionTile(
                                header: SizedBox(
                                  height: 71.h,
                                  width: 358.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 270.w,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  ref.watch(useProvider.notifier).agreeButton();
                                                },
                                                icon: useContainer
                                                    ? SvgPicture.asset(
                                                        IconPath.checkBoxOn,
                                                        width: 20.w,
                                                      )
                                                    : SvgPicture.asset(
                                                        IconPath.checkBoxOff,
                                                        width: 20.w,
                                                      ),
                                              ),
                                              Text(
                                                "Sign_Inup_0019".tr(),
                                                style: CustomTextStyle.headerS,
                                              ),
                                            ],
                                          ),
                                        ),
                                        wSize(34.w),
                                        SvgPicture.asset(IconPath.expanded)
                                      ],
                                    ),
                                  ),
                                ),
                                childrenBody: SingleChildScrollView(
                                  child: SizedBox(
                                    height: 350.h,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Html(
                                          data: ref.watch(formProvider).terms ?? "",
                                          shrinkWrap: true,
                                          style: {
                                            'body': Style(
                                              padding: EdgeInsets.zero,
                                              margin: Margins(
                                                bottom: Margin.zero(),
                                                left: Margin.zero(),
                                                top: Margin.zero(),
                                                right: Margin.zero(),
                                              ),
                                            )
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColor.white,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ListTileTheme(
                              dense: true,
                              child: ConfigurableExpansionTile(
                                header: SizedBox(
                                  height: 71.h,
                                  width: 358.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  ref.watch(policyProvider.notifier).agreeButton();
                                                },
                                                icon: usePolicy
                                                    ? SvgPicture.asset(
                                                        IconPath.checkBoxOn,
                                                        width: 20.w,
                                                      )
                                                    : SvgPicture.asset(
                                                        IconPath.checkBoxOff,
                                                        width: 20.w,
                                                      ),
                                              ),
                                              Text(
                                                "Sign_Inup_0020".tr(),
                                                style: CustomTextStyle.headerS,
                                              ),
                                            ],
                                          ),
                                        ),
                                        wSize(34.w),
                                        SvgPicture.asset(IconPath.expanded)
                                      ],
                                    ),
                                  ),
                                ),
                                childrenBody: SingleChildScrollView(
                                  child: SizedBox(
                                    height: 350.h,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Html(
                                          data: ref.watch(formProvider).privacy ?? "",
                                          shrinkWrap: true,
                                          style: {
                                            'body': Style(
                                              padding: EdgeInsets.zero,
                                              margin: Margins(
                                                bottom: Margin.zero(),
                                                left: Margin.zero(),
                                                top: Margin.zero(),
                                                right: Margin.zero(),
                                              ),
                                            )
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColor.white,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ListTileTheme(
                              dense: true,
                              child: ConfigurableExpansionTile(
                                onExpansionChanged: (value) {},
                                header: SizedBox(
                                  height: 71.h,
                                  width: 358.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                ref.watch(marketingProvider.notifier).agreeButton();
                                              },
                                              icon: useMarketing
                                                  ? SvgPicture.asset(
                                                      IconPath.checkBoxOn,
                                                      width: 20.w,
                                                    )
                                                  : SvgPicture.asset(
                                                      IconPath.checkBoxOff,
                                                      width: 20.w,
                                                    ),
                                            ),
                                            Text(
                                              "Sign_Inup_0021".tr(),
                                              style: CustomTextStyle.headerS,
                                            ),
                                          ],
                                        ),
                                        wSize(34.w),
                                        SvgPicture.asset(IconPath.expanded)
                                      ],
                                    ),
                                  ),
                                ),
                                childrenBody: SingleChildScrollView(
                                  child: SizedBox(
                                    height: 350.h,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Html(
                                          data: ref.watch(formProvider).marketing ?? "",
                                          shrinkWrap: true,
                                          style: {
                                            'body': Style(
                                              padding: EdgeInsets.zero,
                                              margin: Margins(
                                                bottom: Margin.zero(),
                                                left: Margin.zero(),
                                                top: Margin.zero(),
                                                right: Margin.zero(),
                                              ),
                                            )
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSize(200)
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 160.h,
                color: CustomColor.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(22.w, 10.w, 22.w, 10.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref.watch(allAgreeProvider.notifier).agreeButton();
                            },
                            icon: useContainer && usePolicy && useMarketing
                                ? SvgPicture.asset(
                                    IconPath.checkBoxOn,
                                    width: 20.w,
                                  )
                                : SvgPicture.asset(
                                    IconPath.checkBoxOff,
                                    width: 20.w,
                                  ),
                          ),
                          Text(
                            "Sign_Inup_0022".tr(),
                            style: CustomTextStyle.headerXS,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w),
                      child: GestureDetector(
                          onTap: useContainer && usePolicy
                              ? () {
                                  ref.watch(startProvider.notifier).agreeAndStart();
                                }
                              : null,
                          child: commonButton(context, 'Sign_Inup_0023'.tr(), useContainer && usePolicy ? true : false)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        loadingScreen()
      ],
    );
  }
}

class TermsConditionsDrawerScreen extends ConsumerStatefulWidget {
  const TermsConditionsDrawerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TermsConditionsDrawerScreen> createState() => _TermsConditionsDrawerScreenState();
}

class _TermsConditionsDrawerScreenState extends ConsumerState<TermsConditionsDrawerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(loadingProvider.notifier).isLoadingTrue();
      await ref.watch(formProvider.notifier).getForms();
      ref.watch(loadingProvider.notifier).isLoadingFalse();
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final useContainer = ref.watch(useProvider);
    final usePolicy = ref.watch(policyProvider);
    final useMarketing = ref.watch(marketingProvider);

    final allAgreeState = ref.listen(allAgreeProvider, (previous, next) {
      if (next) {
        ref.watch(useProvider.notifier).allAgree();
        ref.watch(policyProvider.notifier).allAgree();
        ref.watch(marketingProvider.notifier).allAgree();
        safePrint(usePolicy.toString());
      } else {
        ref.watch(useProvider.notifier).allDisAgree();
        ref.watch(policyProvider.notifier).allDisAgree();
        ref.watch(marketingProvider.notifier).allDisAgree();
      }
    });

    final agreeAndStart = ref.listen(startProvider, (previous, next) {
      if (next) {
        context.go('/fillprofileScreen');
      }
    });

    return Stack(
      children: [
        Scaffold(
          appBar: SimpleAppbar(
            context: context,
            title: 'Sign_Inup_0018'.tr(),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 844.h - MediaQuery.of(context).padding.top - 58.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      hSize(23),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColor.white,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: ListTileTheme(
                                dense: true,
                                child: ConfigurableExpansionTile(
                                  header: SizedBox(
                                    height: 71.h,
                                    width: 358.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 270.w,
                                            child: Row(
                                              children: [
                                                wSize(48.w),
                                                Text(
                                                  "Side_Main_0006".tr(),
                                                  style: CustomTextStyle.headerS,
                                                ),
                                              ],
                                            ),
                                          ),
                                          wSize(34.w),
                                          SvgPicture.asset(IconPath.expanded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  childrenBody: SingleChildScrollView(
                                    child: SizedBox(
                                      height: 350.h,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Html(
                                            data: ref.watch(formProvider).terms ?? "",
                                            shrinkWrap: true,
                                            style: {
                                              'body': Style(
                                                padding: EdgeInsets.zero,
                                                margin: Margins(
                                                  bottom: Margin.zero(),
                                                  left: Margin.zero(),
                                                  top: Margin.zero(),
                                                  right: Margin.zero(),
                                                ),
                                              )
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hSize(16),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColor.white,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: ListTileTheme(
                                dense: true,
                                child: ConfigurableExpansionTile(
                                  header: SizedBox(
                                    height: 71.h,
                                    width: 358.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                wSize(48.w),
                                                Text(
                                                  "Side_Main_0007".tr(),
                                                  style: CustomTextStyle.headerS,
                                                ),
                                              ],
                                            ),
                                          ),
                                          wSize(34.w),
                                          SvgPicture.asset(IconPath.expanded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  childrenBody: SingleChildScrollView(
                                    child: SizedBox(
                                      height: 350.h,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Html(
                                            data: ref.watch(formProvider).privacy ?? "",
                                            shrinkWrap: true,
                                            style: {
                                              'body': Style(
                                                padding: EdgeInsets.zero,
                                                margin: Margins(
                                                  bottom: Margin.zero(),
                                                  left: Margin.zero(),
                                                  top: Margin.zero(),
                                                  right: Margin.zero(),
                                                ),
                                              )
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hSize(16),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColor.white,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: ListTileTheme(
                                dense: true,
                                child: ConfigurableExpansionTile(
                                  onExpansionChanged: (value) {},
                                  header: SizedBox(
                                    height: 71.h,
                                    width: 358.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, right: 20.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              wSize(48.w),
                                              Text(
                                                "Sign_Inup_0021".tr(),
                                                style: CustomTextStyle.headerS,
                                              ),
                                            ],
                                          ),
                                          wSize(34.w),
                                          SvgPicture.asset(IconPath.expanded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  childrenBody: SingleChildScrollView(
                                    child: SizedBox(
                                      height: 350.h,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Html(
                                            data: ref.watch(formProvider).marketing ?? "",
                                            shrinkWrap: true,
                                            style: {
                                              'body': Style(
                                                padding: EdgeInsets.zero,
                                                margin: Margins(
                                                  bottom: Margin.zero(),
                                                  left: Margin.zero(),
                                                  top: Margin.zero(),
                                                  right: Margin.zero(),
                                                ),
                                              )
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 80.h,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: commonButton(context, '돌아가기'.tr(), true)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        loadingScreen()
      ],
    );
  }
}
