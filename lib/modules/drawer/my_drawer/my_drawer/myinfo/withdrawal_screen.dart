import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/myinfo/widget/withdrawal_complete_bottom_sheet.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/common_widget/custom_check_box.dart';
import 'package:nuuz/ui/common_widget/custom_textfield.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class WithdrawalScreen extends StatefulWidget {
  WithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  TextEditingController writeController = TextEditingController();

  final List<String> reasonList = [
    'Side_With_0002',
    'Side_With_0003',
    'Side_With_0004',
    'Side_With_0005',
    'Side_With_0006',
    'Side_With_0007',
    'Self_Diag_0029'
  ];

  bool isLoading = false;
  String selectedReason = "";
  bool isAllNoticeRead = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.white,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        appBar:  SimpleAppbar(context: context, title: 'Comm_Gene_0047'.tr(),),
        body: Stack(
          children: [
            Column(
              children: [

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cautionView(),
                            reasonView(),
                            hSize(5),
                            title('Side_With_0008'),
                            hSize(11),
                            CustomTextField(
                              controller: writeController,
                              fillColor: CustomColor.white,
                              hintText: 'Side_With_0011',
                              maxLine: 8,
                            ),
                            hSize(15),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomButtonView(context),
              ],
            ),
            isLoading
                ? Container(
              // height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.center,
                child: CustomIndicator('Comm_Gene_0001'.tr()))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget bottomButtonView(BuildContext context) {
    return Container(
      color: CustomColor.white,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCheckbox(
                isSelect: isAllNoticeRead,
                onTap: () {
                  setState(() {
                    isAllNoticeRead = !isAllNoticeRead;
                  });
                },
              ),
              SizedBox(
                width: 13.w,
              ),
              Text(
                'Side_With_0009'.tr(),
                style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
              ),
            ],
          ),
          hSize(35),
          CustomButton(
            title: 'Side_With_0010',
            onTap: () async {
              if (isAllNoticeRead && selectedReason.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                //   withdrawalCompleteBottomSheet(context: context);
                LocalDB localDB = LocalDB();
                LoginResponse? loginResponse = await localDB.findAuthInfo();
                MyDrawerRepository dr = MyDrawerRepository();
                await dr.getWithdraw(loginResponse!.accessToken ?? "", writeController.text, selectedReason).then((value) => {
                      if (value!) {withdrawalCompleteBottomSheet(context: context)}
                    });
                setState(() {
                  isLoading = false;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "사유를 체크하고, 유의사항을 확인해주세요.",
                    style: CustomTextStyle.textStyle(color: CustomColor.primary, fontWeight: FontWeight.w700, fontSize: 14.sp),
                  ),
                  backgroundColor: CustomColor.white,
                ));
              }
            },
            horizontalPadding: 0,
            bgColor: CustomColor.primary.withOpacity(isAllNoticeRead && selectedReason.isNotEmpty?1:0.4),
            borderColor: CustomColor.primary.withOpacity(isAllNoticeRead && selectedReason.isNotEmpty?1:0.4),
            textColor: CustomColor.white,
          ),
        ],
      ),
    );
  }

  Widget cautionView() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColor.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comm_Gene_0029'.tr(),
            style: CustomTextStyle.textStyle(color: CustomColor.red, fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
          Text(
            'Side_With_0000'.tr(),
            style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w400, fontSize: 13.sp, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget title(String title) {
    return Text(
      title.tr(),
      style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
    );
  }

  Widget reasonView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title('Side_With_0001'),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  setState(() {
                    selectedReason = reasonList[i].toString();
                  });
                },
                child: itemView(heading: reasonList[i].toString()));
          },
          separatorBuilder: (context, i) {
            return hSize(20);
          },
          itemCount: reasonList.length,
        )
      ],
    );
  }

  Widget itemView({required String heading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        selectedReason == heading
            ? Image.asset(
                IconPath.selectRadioButton,
                width: 22.w,
              )
            : Image.asset(
                IconPath.unSelectRadioButton,
                width: 22.w,
              ),
        wSize(13),
        Text(
          heading.tr(),
          style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w400, fontSize: 16.sp),
        ),
      ],
    );
  }
}
