import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  var eventList;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       eventList = ref.watch(eventProvider)?.result;
       safePrint("EventScreen====$eventList");
       setState(() {

       });
    });
    super.initState();
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
            title: 'Side_Even_0000'.tr(),
            onTap: () {
              context.pop();
            },
            iconPath: IconPath.leftBackIcon,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: eventList == null
              ?  Center(child: CustomIndicator('Comm_Gene_0001'.tr()))
              : eventList.length==0 ? const NoItemFound(title: '이벤트가 없습니다.', icon: IconPath.noPostIcon,padding: 0,) : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return eventItem(context, eventList[index], false);
                  },
                  itemCount: eventList.length,
                ),
        ),
      ),
    );
  }
}

Widget eventItem(BuildContext context, Event eventData, bool isDetail) {
  return GestureDetector(
    onTap: isDetail
        ? null
        : () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return EventDetail(
                eventDate: eventData,
              );
            }));
            ///이벤트 뷰카운트 상승 함수 여기
            ViewCountRepository viewCountRepository = ViewCountRepository();
            viewCountRepository.increaseViewCount(null, eventData.event_id, null, null,null);

          },
    child: Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CustomContainer(
        width: double.infinity,
        radius: 12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 143.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: eventData.image ?? '',
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    fit: BoxFit.cover,
                  ),

                  /* Image.network(
                      eventData.image,
                      fit: BoxFit.cover,
                    )*/
                ),
              ),
              hSize(12),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 12.h, 6.w, 12.h),
                    child:
                    SizedBox(width: 310.w,
                      child: Text(
                        eventData.title_text,
                        style: CustomTextStyle.headerS.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  wSize(6.w),
                  CustomContainer(
                    containerColor: eventData.status == 'inprogress' ? CustomColor.blue : CustomColor.lightDark,
                    radius: 14,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                      child: eventData.status == 'inprogress'
                          ? Text(
                              "Side_Even_0001".tr(),
                              style: CustomTextStyle.nicknameM.copyWith(color: Colors.white),
                            )
                          : Text(
                              'Side_Even_0003'.tr(),
                              style: CustomTextStyle.nicknameM.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class EventDetail extends StatelessWidget {
  const EventDetail({
    Key? key,
    required this.eventDate,
  }) : super(key: key);

  final Event eventDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: CustomAppBar(
          title: 'Side_Even_0004'.tr(),
          onTap: () {
            context.pop();
          },
          iconPath: IconPath.leftBackIcon,
        ),
      ),
      body: Stack(alignment: Alignment.topCenter ,
        children: [
          Container(height: double.infinity,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                shrinkWrap: true,
                children: [
                  eventItem(context, eventDate, true),
                  CustomContainer(
                    width: double.infinity,
                    radius: 12,
                    child: Html(
                      data: eventDate.body_text.replaceAll("</figure><figure class=\"image\">", "<br>").
                      replaceAll("<blockquote>", "").
                      replaceAll("<figure class=\"image\">", "").
                      replaceAll("</figure>", "").
                      replaceAll("</blockquote>", ""),
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
                  )
                ],
              ),
            ),
          ),

          Positioned(bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.h),
              child: GestureDetector(
                onTap: eventDate.status=='inprogress'?() async {
                  final url = Uri.parse(eventDate.invoked_link);
                  if (await canLaunchUrl(url)) {
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    // ignore: avoid_print
                    print("Can't launch $url");
                  }
                }:null,
                child: CustomContainer(
                 width: 320.w, height: 44.h,
                  containerColor: eventDate.status=='inprogress'?CustomColor.primary:CustomColor.primary.withOpacity(0.5),
                  child: Center(
                    child:  eventDate.status=='inprogress'?
                    Text('Side_Even_0002'.tr(),style: CustomTextStyle.buttonM.copyWith(color: Colors.white),):
                    Text('Side_Even_0003'.tr(),style: CustomTextStyle.buttonM.copyWith(color: Colors.white),),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
