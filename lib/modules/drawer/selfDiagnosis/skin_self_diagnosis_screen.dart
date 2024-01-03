import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosis.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/self_diagnosis/self_diagnosis_home.dart';
import 'package:nuuz/modules/self_diagnosis/services/self_diagnosis_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_result_container.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class SkinSelfDiagnosis extends StatefulWidget {
  final SelfDiagnosisModel response;

  const SkinSelfDiagnosis({
    super.key,
    required this.response,
  });

  @override
  State<SkinSelfDiagnosis> createState() => _SkinSelfDiagnosisState();
}

class _SkinSelfDiagnosisState extends State<SkinSelfDiagnosis> {
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
                  const Text(
                    "Submitted",
                    style: TextStyle(fontSize: 14),
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
                      child: const Center(
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    safePrint("SkinSelfDiagnosis---->${widget.response}");
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
    systemNavigationBarColor: CustomColor.background,
    statusBarColor: CustomColor.background,
    statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: CustomAppBar(
        title: 'Comm_Gene_0009'.tr(),
        onTap: () {
          context.pop();
        },
        iconPath: IconPath.leftBackIcon,
      ),
    ),
    body: Column(
      children: [
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSize(20),
                             Text("Self_Diag_0002".tr(), style: CustomTextStyle.headerM,),
                            hSize(20),
                            CommonResultContainer(result: widget.response.skin_type, isList: false),
                            hSize(20),
                            Text("Self_Diag_0009".tr(), style: CustomTextStyle.headerM,),
                            hSize(20),
                            widget.response.skin_concerns!.isEmpty
                                ? Container()
                                : CommonResultContainer(
                                    result: widget.response.skin_concerns!.toList(),
                                    isList: true,
                                  ),
                            hSize(20),
                            Text("Self_Diag_0017".tr(), style: CustomTextStyle.headerM,),
                            hSize(20),
                            widget.response.detailed_concern!.isEmpty
                                ? Container()
                                : CommonResultContainer(
                                    result: widget.response.detailed_concern!.toList(),
                                    isList: true,
                                  ),
                            hSize(
                              20,
                            ),
                            Text("Self_Diag_0030".tr(), style: CustomTextStyle.headerM,),
                            hSize(
                              20,
                            ),
                            widget.response.frequently_replaced == ''
                                ? Container()
                                : Column(
                                    children: [
                                      CommonResultContainerText(
                                          text: 'Self_Diag_0100'.tr(), result: widget.response.frequently_replaced),
                                      hSize(
                                        10,
                                      ),
                                      CommonResultContainerText(text: 'Self_Diag_0101'.tr(), result: widget.response.color_makeup)
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
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SelfDiagnosisHome(),
                      ),
                    );
                  },
                  text: 'Comm_Gene_0048'.tr()),
            ],
          ),
        ),
      ],
    ),
      ),
    );
  }
}
