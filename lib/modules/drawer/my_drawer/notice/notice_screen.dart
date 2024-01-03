import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice_category_model.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/noticelist.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/widget/expand_text.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';

import '../my_drawer_controller.dart';

class NoticeScreen extends ConsumerStatefulWidget {
  NoticeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends ConsumerState<NoticeScreen> {
  List<NoticeCategoryModel> categoryList = [
    NoticeCategoryModel('Prog_Part_0012', 'All'),
    NoticeCategoryModel('Comm_Gene_0052', 'notice'),
    NoticeCategoryModel('Comm_Gene_0050', 'announce'),
    NoticeCategoryModel('Side_Noti_0000', 'update'),
  ];

  String selectedCategory = "Prog_Part_0012";
  List<Notice>? noticeList;
  List<Notice> categoryWiseList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      noticeList = ref.watch(noticeProvider)?.result;
      setState(() {});
      safePrint("noticeList---->${noticeList}");
      noticeList = _getFilteredList(selectedCategory);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (noticeList != null) {
      if (selectedCategory == "Comm_Gene_0052") {
        noticeList = _getFilteredList("notice");
      } else if (selectedCategory == "Comm_Gene_0050") {
        noticeList = _getFilteredList("announce");
      } else if (selectedCategory == "Side_Noti_0000") {
        noticeList = _getFilteredList("update");
      }else{
        noticeList = _getFilteredList("Prog_Part_0012");
      }
    }

    safePrint("noticeList- length--->${noticeList?.length}");

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: CustomColor.background,
        statusBarColor: CustomColor.background,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Column(
          children: [
            hSize(MediaQuery.of(context).viewPadding.top),
            appBar(
              context,
            ),
            noticeList == null
                ? Container(
                    height: MediaQuery.of(context).size.height - 200, alignment: Alignment.center, child: CustomIndicator('Comm_Gene_0001'.tr()))
                : noticeList?.length == 0
                    ? NoItemFound(
                        title: '공지사항이 없습니다.',
                        icon: IconPath.noPostIcon,
                        padding: 20.w,
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    hSize(18),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if(Platform.isAndroid)
                                          Expanded(
                                            child:
                                            Text(
                                              noticeList?[i].title_text ?? "",
                                              style: CustomTextStyle.textStyle(
                                                  fontWeight: FontWeight.w700, fontSize: 18, color: CustomColor.dark, height: 1.25),
                                            ),
                                          ),
                                          if(Platform.isIOS)
                                            Expanded(
                                              child:
                                              Text(
                                                noticeList?[i].title_text?.replaceAll("안드로이드", "ios") ?? "",
                                                style: CustomTextStyle.textStyle(
                                                    fontWeight: FontWeight.w700, fontSize: 18, color: CustomColor.dark, height: 1.25),
                                              ),
                                            ),
                                          wSize(14),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: getNoticeCatColor(noticeList![i].category!.toLowerCase().trim()),
                                              //color: CustomColor.yellow
                                            ),
                                            padding: EdgeInsets.only(top: 2.h, bottom: 2.h + 1.6, left: 11.w, right: 11.w),
                                            alignment: Alignment.center,
                                            child: Text(
                                              noticeList?[i].category=="notice"?"Comm_Gene_0052".tr():
                                              noticeList?[i].category=="announce"?"Comm_Gene_0050".tr():
                                              noticeList?[i].category=="update"?"Side_Noti_0000".tr():""
                                                  ?? "",
                                              style: CustomTextStyle.textStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: CustomColor.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    hSize(9),
                                    if(Platform.isAndroid)
                                    ExpandText(
                                      text: noticeList?[i].body_text.toString() ?? "",
                                      noticeId: noticeList?[i].notice_id??"",
                                    ),
                                    if(Platform.isIOS)
                                      ExpandText(
                                        text: noticeList?[i].body_text.toString().replaceAll("안드로이드", "ios") ?? "",
                                        noticeId: noticeList?[i].notice_id??"",
                                      ),
                                  ],
                                ),
                              ),
                            ]);
                          },
                          separatorBuilder: (context, i) {
                            return hSize(12);
                          },
                          itemCount: noticeList?.length ?? 0,
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  _getFilteredList(keyword) {
    if (selectedCategory == "Prog_Part_0012") {
      return noticeList = ref.watch(noticeProvider)?.result;
    }
    safePrint("lenght----${noticeList?.where((element) => element.category!.toLowerCase() == keyword).toList()}");
    var data = ref.watch(noticeProvider)?.result;
    return data?.where((element) => element.category!.toString().toLowerCase().trim() == keyword.toString().toLowerCase()).toList();
  }

  Color getNoticeCatColor(String item) {
    if (item == "all") {
      return CustomColor.primary;
    } else if (item == "notice") {
      return CustomColor.blue;
    } else if (item == "announce") {
      return CustomColor.yellow;
    } else if (item == "update") {
      return CustomColor.lightDark;
    } else {
      return Colors.transparent;
    }
  }

  Widget appBar(
    BuildContext context,
  ) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Image.asset(
                  IconPath.leftBackIcon,
                  width: 25.w,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Comm_Gene_0052'.tr(),
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 22, color: CustomColor.dark),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 40.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: CustomColor.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(13),
                  underline: const SizedBox(),
                  isExpanded: true,
                  icon: Center(
                      child: Image.asset(
                    IconPath.downArrow,
                    width: 12.w,
                  )),
                  iconDisabledColor: CustomColor.black,
                  items: categoryList.map((location) {
                    return DropdownMenuItem<String>(
                      value: location.title,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              location.title.tr(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CustomColor.dark),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      safePrint('tap');
                      safePrint(newValue);
                      selectedCategory = newValue!;
                      if (noticeList != null) {
                        if (selectedCategory == "Comm_Gene_0052") {
                          noticeList = _getFilteredList("notice");
                        } else if (selectedCategory == "Comm_Gene_0050") {
                          noticeList = _getFilteredList("announce");
                        } else if (selectedCategory == "Side_Noti_0000") { //Comm_Gene_0052
                          noticeList = _getFilteredList("update"); //Side_Noti_0000
                        }else{
                          noticeList = _getFilteredList("Prog_Part_0012");
                        }
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
