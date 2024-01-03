import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/app_setting.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/notice_screen.dart';
import 'package:nuuz/modules/home/nuuz_home/cheer_up_widget.dart';
import 'package:nuuz/ui/common/circle_image.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';

class NotiDrawer extends ConsumerStatefulWidget {
  const NotiDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<NotiDrawer> createState() => _NotiDrawerState();
}

class _NotiDrawerState extends ConsumerState<NotiDrawer> {
  @override
    void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.watch(myDrawerProvider.notifier).getUserData();
        eventList = ref.watch(eventProvider)?.result;
        noticeList = ref.watch(noticeProvider)?.result;
        setState(() {});
        safePrint('노티스 리스트');
        safePrint(noticeList);

      });
      super.initState();
    }

  List<Notice>? noticeList;
  List<Event>? eventList;

  @override
  Widget build(BuildContext context) {
    final cheerUpData = ref.watch(myCheerUpGetProvider);
    return SizedBox(
      width: 318.w,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
        child: Drawer(
          child: Container(
            color: CustomColor.darkGray,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  hSize(56),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: SvgPicture.asset(
                            IconPath.close,
                            height: 24.h,
                            width: 24.w,
                          )),
                      wSize(12),
                      Text("Comm_Gene_0002".tr(), style: CustomTextStyle.headerM),
                    ],
                  ),
                  hSize(20),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoticeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: CustomColor.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.w),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(Platform.isAndroid)
                            RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  text: noticeList?[0].title_text??"",
                                  style: CustomTextStyle.headerXS.copyWith(overflow: TextOverflow.ellipsis),
                                ),
                                overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                            if(Platform.isIOS)
                              RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  text: noticeList?[0].title_text?.replaceAll("안드로이드", "ios")??"",
                                  style: CustomTextStyle.headerXS.copyWith(overflow: TextOverflow.ellipsis),
                                ),
                                overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                            hSize(8),
                            if(Platform.isAndroid)
                            RichText(
                              maxLines: 4,
                              text: TextSpan(
                                text:noticeList?[0].body_text,
                                style: CustomTextStyle.descriptionM,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if(Platform.isIOS)
                              RichText(
                                maxLines: 4,
                                text: TextSpan(
                                  text:noticeList?[0].body_text?.replaceAll("안드로이드", "ios"),
                                  style: CustomTextStyle.descriptionM,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  hSize(12),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: eventList?[0]!=null?(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  EventDetail(eventDate: eventList![0])
                          )
                      );
                      ViewCountRepository viewCountRepository = ViewCountRepository();
                      viewCountRepository.increaseViewCount(null, eventList?[0].event_id??"", null, null,null);
                    }:null,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: CustomColor.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 258.w,
                              height: 110.h,
                              decoration:  BoxDecoration(
                                color: CustomColor.gray,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                              child: eventList?[0].image!=null?ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: eventList?[0].image ?? '',
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  height: 110.h,
                                  width: 258.w,
                                  fit: BoxFit.cover,
                                ),
                              ):Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(IconPath.eventDrawer,width: 48.w,),
                                  hSize(2),
                                  Text("Side_Even_0000".tr(),style: CustomTextStyle.headerXS.copyWith(color:Colors.white),)
                                ],
                              ),
                            ),
                            wSize(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hSize(7),
                                SizedBox(
                                  width: 152.w,
                                  child: RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                      text: eventList?[0].title_text??"Side_Even_0005".tr(),
                                      style: CustomTextStyle.headerXS,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  hSize(12),
                  Visibility(
                    visible: cheerUpData!=null&&cheerUpData.isNotEmpty,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(15.w, 11.h, 15.w, 11.h),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: CustomColor.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 108.w,
                                child: Stack(
                                  children: [
                                    CircleImage(size: 36, image: cheerUpData?[0].user?.profile_image??IconPath.nuuzDefaultImage),
                                    Positioned(left: 24.w, child: CircleImage(size: 36, image: cheerUpData?[1].user?.profile_image??IconPath.nuuzDefaultImage)),
                                    Positioned(left: 48.w, child: CircleImage(size: 36, image: cheerUpData?[2].user?.profile_image??IconPath.nuuzDefaultImage)),
                                    Positioned(left: 72.w, child: CircleImage(size: 36, image: cheerUpData?[3].user?.profile_image??IconPath.nuuzDefaultImage)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 32, child: Image.asset(IconPath.cheerup)),
                                  wSize(8),
                                  Text('${ cheerUpData?.length??0}'
                                   ,
                                    style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                                  ),
                                ],
                              )
                            ],
                          ),
                          hSize(8),
                          Text('${cheerUpData?.length??0} 명의 회원이 당신을 응원하고 있어요!\n당신의 피부를 위해 잊지 말고 힘내보아요!', style: CustomTextStyle.descriptionM),
                        ],
                      ),
                    ),
                  ),
                  hSize(10),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: Colors.white,
                  ),
                  hSize(12),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://www.instagram.com/nuuz_official/',
                      );
                      if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                      }
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: CustomColor.white,
                      ),
                      child: Row(
                        children: [
                          wSize(16),
                          SizedBox(width: 32.w, child: Image.asset(IconPath.instar)),
                          wSize(12),
                          SizedBox(height: 20.w, child: Image.asset(IconPath.logo)),
                          wSize(4),
                          Text(
                            'Instagram',
                            style: CustomTextStyle.headerS,
                          ),
                        ],
                      ),
                    ),
                  ),
                  hSize(12),
                  ///이벤트 혜택 알림 받기
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final userData = ref.watch(myDrawerProvider);
                      safePrint('유저데이터');
                      safePrint(userData?.name);
                      safePrint(userData?.notification_settings?.events);
                      return
                        Visibility(
                          visible: userData?.notification_settings?.events=='disable',
                          child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            color: CustomColor.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    wSize(16),
                                    Container(
                                        width: 32.w,
                                        height: 32.w,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                                          border: Border.all(color: CustomColor.lightDark),
                                        ),
                                        child: Center(child: SvgPicture.asset(IconPath.eventNotice))),
                                    wSize(12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        hSize(8),
                                        Text(
                                          'Noti_Main_0001'.tr(),
                                          style: CustomTextStyle.headerXS,
                                        ),
                                        hSize(10),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              hSize(6),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const AppSetting(),
                                      ),
                                    );
                                  },
                                  child: CustomContainer(
                                    width: 250.w,
                                    height: 46,
                                    containerColor: CustomColor.primary,
                                    radius: 13,
                                    child: Center(
                                      child: Text(
                                        'Noti_Main_0003'.tr(),
                                        style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
