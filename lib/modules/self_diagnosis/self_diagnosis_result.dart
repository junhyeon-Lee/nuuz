import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/self_diagnosis/services/self_diagnosis_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_result_container.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../../ui/common_widget/common_button.dart';
import '../../ui/common_widget/common_text_widget.dart';

class ResultSelfDiagnosis extends StatefulWidget {
  final response;

  const ResultSelfDiagnosis({
    super.key,
    required this.response,
  });

  @override
  State<ResultSelfDiagnosis> createState() => _ResultSelfDiagnosisState();
}

class _ResultSelfDiagnosisState extends State<ResultSelfDiagnosis> {
  bool isLoading = false;
  SelfDiagnosisService selfDiagnosisService = SelfDiagnosisService();

  Future<void> showresult(context) async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: CustomColor.white,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 20.h, bottom: 5.h),
              child: Column(
                children: [
                  Text(
                    "Comm_Gene_0005".tr(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xffebeae9),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Self_Diag_0040".tr(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    child: Container(
                      height: 46.h,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffC68590)),
                      child: Center(
                        child: Text(
                          "Comm_Gene_0034".tr(),
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Column(
          children: [
            hSize(12),
            LargeHeaderText(text: 'Comm_Gene_0009'.tr()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSize(10),
                    Material(
                      color: CustomColor.background,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            hSize(20),
                            Text(
                              "Self_Diag_0002".tr(),
                              style: CustomTextStyle.headerM,
                            ),
                            hSize(20),
                            CommonResultContainer(
                              result: widget.response['skinType'],
                              isList: false,
                            ),
                            hSize(20),
                            Text(
                              "Self_Diag_0009".tr(),
                              style: CustomTextStyle.headerM,
                            ),
                            hSize(20),
                            widget.response['skinConcerns'].length == 0
                                ? Container()
                                : CommonResultContainer(
                                    result: widget.response['skinConcerns'],
                                    isList: true,
                                  ),
                            hSize(20),
                            Text(
                              "Self_Diag_0017".tr(),
                              style: CustomTextStyle.headerM,
                            ),
                            hSize(20),
                            widget.response['detailedConcern'].length == 0
                                ? Container()
                                : CommonResultContainer(
                                    result: widget.response['detailedConcern'],
                                    isList: true,
                                  ),
                            hSize(
                              20,
                            ),
                            Text(
                              "Self_Diag_0030".tr(),
                              style: CustomTextStyle.headerM,
                            ),
                            hSize(
                              20,
                            ),
                            widget.response['frequentlyReplaced'] == ''
                                ? Container()
                                : Column(
                                    children: [
                                      CommonResultContainerText(text: 'Self_Diag_0100'.tr(), result: widget.response['frequentlyReplaced']),
                                      hSize(
                                        10,
                                      ),
                                      CommonResultContainerText(text: 'Self_Diag_0100'.tr(), result: widget.response['colorMakeup'])
                                    ],
                                  ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    hSize(40),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: CommonOutlinedButton(
                          onPressed: () {
                            // context.push('/main');
                            context.pop();
                          },
                          child: Text('Comm_Gene_0003'.tr()),
                        ),
                      ),
                      SizedBox(
                        width: 120.w,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return CommonButton(
                                onPressed: () async {
                                  safePrint('제출');
                                  setState(() {
                                    isLoading = true;
                                  });
                                  LocalDB localDB = LocalDB();
                                  LoginResponse? loginResponse = await localDB.findAuthInfo();
                                  safePrint("postSelfDiagnosis=====screen ${widget.response}     token=== ${loginResponse!.accessToken}");
                                  await selfDiagnosisService.postSelfDiagnosis(widget.response, loginResponse!.accessToken);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (!mounted) {
                                    return;
                                  }
                                  context.go('/main');
                                },
                                text: 'Self_Diag_0040'.tr());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        isLoading
            ? Container(height: MediaQuery.of(context).size.height - 200, alignment: Alignment.center, child: CustomIndicator('Comm_Gene_0001'.tr()))
            : SizedBox.shrink()
      ],
    )));
  }
}
