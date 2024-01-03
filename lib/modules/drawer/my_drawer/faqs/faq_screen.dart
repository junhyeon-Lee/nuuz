import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/model/faq.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/model/faq_category_list.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_service.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/model/faqlist.dart';
import 'package:nuuz/ui/common/not_found_view.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:easy_localization/easy_localization.dart';

class FaqScreen extends ConsumerStatefulWidget {
  FaqScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {
  List<FaqCategoryList> categoryList = [
    FaqCategoryList('all', '전체'),
    FaqCategoryList('service', '서비스'),
    FaqCategoryList('device', '디바이스'),
    FaqCategoryList('member', '회원'),
   // FaqCategoryList('Comm_Gene_0097', 'Mileage'),
  ];
  var loginResponse;

  List<FaqModel>? faqModelListData;

  List<FaqModel>? faqTempList;
  String selectedCategory='';

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      selectedCategory=categoryList[0].title;
      await ref.watch(getAuthInfoData.notifier).getAuthInfoData();
      loginResponse = ref.watch(getAuthInfoData)?.accessToken;
      safePrint("FaqScreen==loginResponse?.accessToken= ${loginResponse}");
      await ref.watch(faqNotifier.notifier).getFaqData(loginResponse);
      faqModelListData = ref.watch(faqNotifier)?.resultData;


      setState(() {});
      safePrint("FaqScreen=== ${faqModelListData?.length}=======>$selectedCategory");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: CustomColor.background,
            statusBarColor: CustomColor.background,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSize(MediaQuery.of(context).viewPadding.top),
              CustomAppBar(
                title: 'Side_Cust_0000',
                fontSize: 22.sp,
                onTap: () {
                  context.pop();
                },
                iconPath: IconPath.leftBackIcon,
              ),
              hSize(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                    'Side_Faq_0000'.tr(),
                    style: CustomTextStyle.descriptionM
                ),
              ),
              hSize(10),
              SizedBox(
                height: 39.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = categoryList[i].title.toString();

                          var tempList = faqModelListData
                              ?.where((element) =>
                          element.category.toString().toLowerCase().trim() == categoryList[i].title.toString().toLowerCase().trim()
                          )
                              .toList();
                          faqTempList?.clear();
                          faqTempList = tempList;
                          safePrint("templist====${faqTempList?.length}");
                        });
                      },
                      child: Container(
                        width: 64.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedCategory == categoryList[i].category.toString() ? CustomColor.primary : CustomColor.white,
                          border: Border.all(
                            color: selectedCategory == categoryList[i].category.toString()
                                ? CustomColor.primary
                                : CustomColor.lightDark,
                            width: 0.7,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          categoryList[i].title.toString().tr(),
                          style: CustomTextStyle.textStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: selectedCategory.toString().toLowerCase() == categoryList[i].category.toString().tr().toLowerCase()
                                  ? CustomColor.white
                                  : CustomColor.lightDark),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return wSize(10);
                  },
                  itemCount: categoryList.length,
                ),
              ),

              Container(
                color: CustomColor.grayLine,
                height: 0.8,
                margin: EdgeInsets.symmetric(vertical: 14.h),
              ),
              Expanded(child: selectedCategory != "all" ? getFaqListWidgets(faqTempList) : getFaqListWidgets(faqModelListData)),
            ],
          ),
        ));
  }

  Widget getFaqListWidgets(data) {
    return data == null
        ? Container(
        height: MediaQuery.of(context).size.height - 200,
        alignment: Alignment.center,
        child:  CustomIndicator('Comm_Gene_0001'.tr()))
        : data.length > 0
        ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: CustomColor.dark,
              title: Text(
                data[i].title_text.toString() ?? "",
                // 'View the photo information by selecting the desired photo.',
                maxLines: 5,
                style:
                CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    data[i].content_text.toString().replaceAll('\\n', '\n') ?? "",
                    // '·ANDROID·IOS \nIn order to receive push notifications from the nuuz app, both notifications in the smartphone settings and in-app notifications must be turned on...\nIf notifications are turned off in your iOSdevice settings\nIn-app notifications…\nsolution guide solution guide',
                    style: CustomTextStyle.textStyle(
                        color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, i) {
        return hSize(12);
      },
      itemCount: data.length ?? 0,
    )
        : const NotFoundView(title: 'there is no faq found',);
  }
}
