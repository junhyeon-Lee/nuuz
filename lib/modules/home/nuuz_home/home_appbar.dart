import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/notice_screen.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_controller.dart';

class NuuzBanner extends ConsumerStatefulWidget {
  const NuuzBanner({Key? key}) : super(key: key);

  @override
  ConsumerState<NuuzBanner> createState() => _NuuzBannerState();
}

class _NuuzBannerState extends ConsumerState<NuuzBanner> with TickerProviderStateMixin {
  @override
  void initState() {
    ///배너들을 세팅
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      Future.delayed(const Duration(milliseconds: 100), () {
        ref.watch(bannerProvider.notifier).changeIndex(0);
        ref.watch(bannerIndexProvider.notifier).changeBannerIndex(0);
      });
    });

    pageNotice = true;
  }



  bool pageNotice = false;

  PageController pageController = PageController(initialPage: 100);

  @override
  Widget build(BuildContext context) {




    ///배너 위젯
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final controller = ref.watch(bannerListProvider.notifier);
        CarouselController carouselController = CarouselController();

        Future<void> bannerAction(BannerImage i, BuildContext context) async {
          if(i.link=="web"){
            final url = Uri.parse(i.url!);
            if (await canLaunchUrl(url)) {
          launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
          // ignore: avoid_print
          print("Can't launch $url");
          }
          }else if(i.link=="Nuuz Talk"){
            ///뉴즈 톡 검색
            if(i.url!=null){
              await ref.watch(trendItemProvider.notifier).getTrendItemData(i.url!);
            }
            await ref.watch(commentLengthProvider.notifier).setCommentLength(ref.watch(trendItemProvider)!.commentsCount);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>PreviewPostScreen(
                        isEditingPost: false,
                        userPost: ref.watch(trendItemProvider)!,
                        reviews: const [],
                        programs: const [],
                        products: const [],
                        isShowProducts: true,
                        userImage: "",
                        index: 0,
                        isCreatePost: false,
                        isShowMenu: true,
                        onTapMenu: () {context.pop();},
                        postId: ref.watch(trendItemProvider)!.postId)
                )
            );
          }else if(i.link=="Notice"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>NoticeScreen()
                )
            );
          }else if(i.link=="Event"){
          ///이벤트 검색 처리
            if(i.url!=null){
              Event? singleEvent = await ref.watch(eventProvider.notifier).getSingleEvent(i.url!);
              if(singleEvent!=null){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  EventDetail(eventDate: singleEvent!)
                    )
                );
                ViewCountRepository viewCountRepository = ViewCountRepository();
                viewCountRepository.increaseViewCount(null, singleEvent.event_id, null, null,null);
              }
            }

            safePrint('이벤트 베너');
          }
        }

        return SizedBox(
          height: 300.h,
          child: Stack(alignment: Alignment.bottomCenter,
            children: [


              SizedBox(height: 300.h,
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    disableCenter: true,
                    viewportFraction: 1,
                    enlargeCenterPage: false,

                    padEnds:false,

                    onPageChanged: (index, reason) {
                      for(int i=0; i<controller.bannerState.length; i++){
                        controller.bannerState[i]=false;
                      }
                      controller.bannerState[index]=true;
                      setState(() {});
                    },
                  ),
                  items: controller.bannerImagesList!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () async {
                            if(i.url!=null){
                              // final url = Uri.parse(i.url!
                              // );
                              // if (await canLaunchUrl(url)) {
                              //   launchUrl(url, mode: LaunchMode.externalApplication);
                              // } else {
                              //   // ignore: avoid_print
                              //   print("Can't launch $url");
                              // }
                              bannerAction(i,context);
                            }
                            ViewCountRepository viewCountRepository = ViewCountRepository();
                            viewCountRepository.increaseViewCount(null,null, null, null, ref.watch(bannerListProvider)[0].banner_id);


                          },
                          child: Stack(alignment: Alignment.center,
                            children: [
                              Image.asset(i.bgImage,width: 390.w,height:300.h,fit: BoxFit.cover,),
                              CachedNetworkImage(
                                imageUrl: i.banner,
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  height: 300.h, width: 390.w, fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 10.h,
                child: Padding(
                  padding: EdgeInsets.only(top: 178.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h, width: (26+10*(controller.bannerState.length)).w,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.bannerState.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                  child: bannerIndicator(controller.bannerState[index]),
                                );
                              }
                          )
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}



Widget bannerIndicator(bool active){
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    width: active ? 32.w : 6.w,
    height: 5.h,
    decoration: BoxDecoration(
      border: Border.all(color: CustomColor.primary, width: 1.w),
      borderRadius: const BorderRadius.all(Radius.circular(3)),
      color: active ? Colors.transparent : CustomColor.primary,
    ),
  );
}

class BannerImage {
  String banner;
  String bgImage;
  String? url;
  String? link;

  BannerImage(this.banner, this.bgImage, this.url, this.link);
}




