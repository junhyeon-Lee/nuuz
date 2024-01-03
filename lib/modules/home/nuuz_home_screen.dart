import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/cheer_up_animation.dart';
import 'package:nuuz/models/home/cheerup.dart';
import 'package:nuuz/models/home/cheeruplist.dart';
import 'package:nuuz/models/home/mycheeruplist.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/device_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/notice_screen.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/home/nuuz_home/home_controller.dart';
import 'package:nuuz/modules/home/nuuz_home/products.dart';
import 'package:nuuz/modules/home/nuuz_my_screen.dart';
import 'package:nuuz/modules/home/nuuz_profile_screen.dart';
import 'package:nuuz/modules/nuuz_talk/post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/nuuz_talk_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/trend/trend_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_card.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/modules/product/controller/product_controller.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/upcoming_care_program.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nuuz_home/cheer_up_widget.dart';
import 'nuuz_home/home_appbar.dart';
import 'service_providers/popular_care_programs/popular_care_program_provider.dart';

class NuuzHomeScreen extends ConsumerStatefulWidget {
  const NuuzHomeScreen({super.key});

  @override
  ConsumerState<NuuzHomeScreen> createState() => _NuuzHomeScreenState();
}

class _NuuzHomeScreenState extends ConsumerState<NuuzHomeScreen> with AutomaticKeepAliveClientMixin<NuuzHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(myDrawerProvider.notifier).getUserData();
      userData = ref.watch(myDrawerProvider);
      // ref.watch(getProductProvider.notifier).getProgram();
      ref.watch(userProductController.notifier).fetchUserProducts();
      bool loginState = await ref.watch(nuuzTrendProvider.notifier).getTrends(context: context);
      if(loginState==false){
        LocalDB localDB = LocalDB();
        await localDB.logout();
        context.go('/signscreen');
      }
      final startDate = ref.watch(myNuuzStartDateProvider);
      final endDate = ref.watch(myNuuzEndDateProvider);
      final selectedDay = ref.watch(selectedDateProvider);


       await ref.watch(popularPostProvider.notifier).getAllPosts();

      ///응원하기 가져오기


      safePrint('응원하기 가져오기 시작');
      /*List<CheerUp>? cheerUpData =*/ await ref.watch(cheerUpGetProvider.notifier).getAvailableCheerUp();

      safePrint('나의 응원하기 가져오기 시작');
      /*MyCheerUpList? myCheerUpList =*/ await ref.watch(myCheerUpGetProvider.notifier).getCheerUp();

      setState(() {});


    });
    super.initState();
  }
  var userData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {

        final trendsList = ref.watch(nuuzTrendProvider);
        final productList = ref.watch(getProductProvider);
        final userCarePrograms = ref.watch(userCareProgramProvider);
        final userProduct = ref.watch(userProductController);
        final popularCarePrograms = ref.watch(popularCareProgramProvider);
        final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            shrinkWrap: true,
            children: [
              const NuuzBanner(),
              // ongoingCareProgram(context),

              // TextButton(
              //     onPressed: (){
              //EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
              //       EasyLocalization.of(context)!.deleteSaveLocale();
              //     },
              //     child: const Text('영문 변환하기')),

              hSize(12),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap:       userProduct.isNotEmpty?(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CareProgramListScreen(
                            reservationDate: DateTime.now().toString()
                        ),
                      ));
                  // context.pushNamed('program-list',
                  //     queryParams: {
                  //       'reservation_date': DateTime.now(),
                  //     });
                }:(){

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => CommonMessageBottomSheet(
                      headerText: "Comm_Gene_0002".tr(),
                      descriptionText: "Care_Main_0000".tr(),
                      primaryButtonText: "Comm_Gene_0035".tr(),
                      secondaryButtonText: "Devi_Regi_0000".tr(),
                      onSecondaryButtonPressed: () {
                        context.goNamed('/DeviceScreenHome');
                      },
                    ),
                  );

                },
                child: Stack(alignment: Alignment.center,
                  children: [
                    Container(
                      width: 350.w, height: 120.h,
                      decoration: BoxDecoration(
                          color:Colors.white.withOpacity(0.6),
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                    ),
                    Positioned(
                        top: 14.h, left: 50.w,
                        child: Text('Comm_Gene_0059'.tr(), style: CustomTextStyle.headerS,)),
                    Positioned(
                        bottom: 20.h,
                        child: Stack(alignment: Alignment.center,
                          children: [
                            Image.asset(IconPath.homeStartButton,width: 300.w,fit: BoxFit.fitWidth,),
                            Positioned(
                                child: Text('Comm_Gene_0060'.tr(),style: CustomTextStyle.headerL.copyWith(color: Colors.white),))
                          ],
                        )),
                  ],
                ),
              ),

              hSize(12),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Home_Main_0003'.tr(),
                  style: CustomTextStyle.headerM,
                ),
              ),
              hSize(6.h),
              userCarePrograms.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              // setState(() {
                              ref.read(mainPageIndexProvider.notifier).changeTab(1);
                              ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                              ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                              // });
                            },
                            child: CustomContainer(
                              width: double.infinity,
                              height: 138.h,
                              radius: 12,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Prog_Rese_0000'.tr(),
                                      style: CustomTextStyle.descriptionM,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomContainer(
                                      width: 250.w,
                                      height: 44,
                                      radius: 12,
                                      borderColor: CustomColor.dark,
                                      child: Center(
                                          child: Text(
                                            'Comm_Gene_0016'.tr(),
                                            style: CustomTextStyle.buttonM,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    UserCareProgram? upcomingProgram = data.cast<UserCareProgram?>().firstWhere((element) => !(DateTime.tryParse(element!.startDate)?.isBefore(today) ?? true) && element.status != 'completed', orElse: () => null);
                    if (upcomingProgram == null) {
                      return Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                // setState(() {
                                ref.read(mainPageIndexProvider.notifier).changeTab(1);
                                ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                                ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                                // });
                              },
                              child: CustomContainer(
                                width: double.infinity,
                                height: 138.h,
                                radius: 12,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Prog_Rese_0000'.tr(),
                                        style: CustomTextStyle.descriptionM,
                                        textAlign: TextAlign.center,
                                      ),
                                      CustomContainer(
                                        width: 250.w,
                                        height: 44,
                                        radius: 12,
                                        borderColor: CustomColor.dark,
                                        child: Center(
                                            child: Text(
                                              'Comm_Gene_0016'.tr(),
                                              style: CustomTextStyle.buttonM,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: UpcomingCareProgram(
                          userCareProgram: upcomingProgram,
                          onOutlineButtonTap: () {
                            ref.read(mainPageIndexProvider.notifier).changeTab(1);
                            ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                            ref.read(selectedDateProvider.notifier).update((state) => upcomingProgram.startDate);
                          },
                        ),
                      );
                    }
                  }
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // setState(() {
                          ref.read(mainPageIndexProvider.notifier).changeTab(1);
                          ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                          ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                          // });
                        },
                        child: CustomContainer(
                          width: double.infinity,
                          height: 138.h,
                          radius: 12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Prog_Rese_0000'.tr(),
                                  style: CustomTextStyle.descriptionM,
                                  textAlign: TextAlign.center,
                                ),
                                CustomContainer(
                                  width: 250.w,
                                  height: 44,
                                  radius: 12,
                                  borderColor: CustomColor.dark,
                                  child: Center(
                                      child: Text(
                                        'Comm_Gene_0016'.tr(),
                                        style: CustomTextStyle.buttonM,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              hSize(12),

              Visibility(
                  visible: ref.watch(cheerUpGetProvider).isNotEmpty,
                  child: const CheerUpWidget()),
              hSize(12.h),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Home_Main_0004'.tr(),
                  style: CustomTextStyle.headerM,
                ),
              ),
              hSize(6.h),

              trendsList?.length == null
                  ? const Center(
                child: CustomIndicator(''),
              )
                  : trendsList!.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                height: 260.h,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible : trendsList?[index].status=='active',
                        child: InkWell(
                          onTap: () async {
                            ViewCountRepository viewCountRepository = ViewCountRepository();
                            viewCountRepository.increaseViewCount(null, null, trendsList?[index].trend_id, null,null);
                            ref.watch(loadingProvider.notifier).isLoadingTrue();
                            if (trendsList?[index].link_type == "web") {
                              final url = Uri.parse(trendsList![index].link_value!);
                              if (await canLaunchUrl(url)) {
                                launchUrl(url, mode: LaunchMode.externalApplication);
                              }
                            } else if (trendsList?[index].link_type == "app") {
                              await ref
                                  .watch(trendItemProvider.notifier)
                                  .getTrendItemData(trendsList![index].additional_information!);
                              await ref.watch(commentLengthProvider.notifier).setCommentLength(ref.watch(trendItemProvider)!.commentsCount);

                              //싱글 포스트 세
                              await ref.watch(singlePostUserPostProvider.notifier).setSingleUserPost(trendsList[index].additional_information);
                              final singleUserPostState = ref.watch(singlePostUserPostProvider);

                              if(singleUserPostState!=null){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostScreen(
                                            isEditingPost: (userData?.user_id == ref.watch(trendItemProvider)!.userId),
                                            reviews: const [],
                                            programs: const [],
                                            products: const [],
                                            isShowProducts: true,
                                            userImage: "",
                                            index: 0,
                                            isCreatePost: false,
                                            isShowMenu: true,
                                            onTapMenu: () {
                                              context.pop();
                                            },
                                            postId: ref.watch(trendItemProvider)!.postId)));
                              }






                            } else {
                              safePrint('트렌드 에러 있습니다');
                            }
                            ref.watch(loadingProvider.notifier).isLoadingFalse();
                            setState(() {

                            });
                          },
                          child: Container(
                            width: 216.w,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              // image: (trendsList?[index].banner_image ?? '').toLowerCase().contains('http')
                              //     ? DecorationImage(
                              //     image: NetworkImage(trendsList?[index].banner_image ?? ''),
                              //     fit: BoxFit.cover)
                              //     : DecorationImage(
                              //     image: AssetImage(trendsList?[index].banner_image ?? ''),
                              //     fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [

                                Positioned.fill(
                                    child: (trendsList?[index].banner_image ?? '').toLowerCase().contains('http') ?
                                    CachedNetworkImage(
                                      imageUrl: trendsList?[index].banner_image ?? '',
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                      height: 168.h,fit: BoxFit.cover,
                                    ):Image.asset(trendsList?[index].banner_image ?? '',  fit: BoxFit.cover)
                                ),








                                Column(
                                  children: [
                                    const Spacer(),
                                    Container(
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            CustomColor.black.withOpacity(0),
                                            CustomColor.black.withOpacity(0.82)
                                          ],
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12.w, bottom: 20.h),
                                          child: Text(
                                            trendsList?[index].title ?? '',
                                            style: CustomTextStyle.headerXS.copyWith(color: CustomColor.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => wSize(14),
                    itemCount: trendsList?.length ?? 0),
              ),
              hSize(24),


              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final data = ref.watch(popularPostProvider);
                  return Visibility(
                     visible: data.length>3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            wSize(20),
                            Text(
                              'Home_Main_0006'.tr(),
                              style: CustomTextStyle.headerM.copyWith(height: 1),
                            ),
                          ],
                        ),
                        hSize(12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: SizedBox(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 168 /240,
                                crossAxisSpacing: 14.h,
                                mainAxisSpacing: 20.h,
                              ),
                              itemCount: 4,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                    onTap: () async {

                                      ViewCountRepository viewCountRepository = ViewCountRepository();
                                      viewCountRepository.increaseViewCount(data![i].postId, null, null, null,null);

                                      Constants.isAPICall = false;
                                      await ref.watch(commentLengthProvider.notifier).setCommentLength(data[i].commentsCount);
                                      await ref.watch(singlePostUserPostProvider.notifier).setSingleUserPost(data[i].postId);
                                      final userPost = ref.watch(singlePostUserPostProvider);

                                      if(userPost!=null){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PostScreen(
                                                  isEditingPost: false,
                                                  reviews: const [],
                                                  programs: const [],
                                                  products: const [],
                                                  isShowProducts: true,
                                                  userImage: "",
                                                  index: i,
                                                  isCreatePost: false,
                                                  isShowMenu: true,
                                                  onTapMenu: () {
                                                    context.pop();
                                                    final int foundIndex = ref
                                                        .watch(nuuzTalkCategoryProvider.notifier)
                                                        .talkCategoryList
                                                        .indexWhere((cat) => cat.id == data[i].category.id);
                                                    if (foundIndex != -1) {
                                                      ref.read(getPostsProvider.notifier).selectedIndex = foundIndex;
                                                      callPostAPI();
                                                    }
                                                  },
                                                  postId: data[i].postId),
                                            )).then((value) {
                                          if (Constants.isAPICall) {
                                            callPostAPI();
                                          } else {
                                            if (value != null) {
                                              UserPost userPost = value;
                                              ref.read(getPostsProvider.notifier).updateData(index: i, userPost: userPost);
                                            }
                                          }
                                        });
                                      }


                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: CustomColor.white, borderRadius: BorderRadius.circular(10)),
                                      width: 170.h,
                                      height: 300.h,
                                      child: Stack(
                                        children: [

                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: data![i].imageUrls.length > 0
                                                  ? CachedNetworkImage(
                                                imageUrl: data[i].imageUrls[0],
                                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                                errorWidget: (context, url, error) => Image.asset(
                                                  Constants.getImageFromCategory(categoryId: data[i].category.id),
                                                  fit: BoxFit.cover,
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                                  : Image.asset(
                                                Constants.getImageFromCategory(categoryId: data[i].category.id),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Image.asset(
                                                IconPath.postTransIcon,
                                                fit: BoxFit.fill,
                                              )),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 40.h,
                                                // width: 170.h,
                                                decoration: BoxDecoration(
                                                    color: CustomColor.white,
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(100),
                                                        child: CachedNetworkImage(
                                                          imageUrl: data?[i].user?.profile_image ?? '',
                                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => Center(child: Image.asset(IconPath.noProfile)),
                                                          width: 18,
                                                          height: 18,
                                                        ),
                                                      ),
                                                      wSize(8),
                                                      Expanded(
                                                        child: Text(
                                                          '${data[i].name}',
                                                          style: CustomTextStyle.textStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          if (!ref.watch(userPostsProvider.notifier).isCallReactAPI) {
                                                            ref.watch(userPostsProvider.notifier).isCallReactAPI = true;
                                                            if (data[i].reactId != null) {
                                                              bool isUpdate = await ref
                                                                  .watch(userPostsProvider.notifier)
                                                                  .deleteReaction(context: context, userPost: data[i], index: i);
                                                              if (isUpdate) {
                                                                ref.read(getPostsProvider.notifier).updateLikeData(index: i, isLike: true);
                                                              }
                                                            } else {
                                                              bool isUpdate = await ref
                                                                  .watch(userPostsProvider.notifier)
                                                                  .createReaction(context: context, userPost: data[i], index: i);
                                                              if (isUpdate) {
                                                                List<UserPost> pos = await ref
                                                                    .watch(userPostsProvider.notifier)
                                                                    .getPosts(postId: data[i].postId, userId: data[i].userId);
                                                                if (pos.length > 0) {
                                                                  ref.read(getPostsProvider.notifier).updateLikeData(index: i, isLike: false,rectId: pos[0].reactId);
                                                                } else {
                                                                  ref.read(getPostsProvider.notifier).updateLikeData(index: i, isLike: false);
                                                                }
                                                              }
                                                            }

                                                            ref.watch(userPostsProvider.notifier).isCallReactAPI = false;
                                                          }
                                                        },
                                                        child: Column(
                                                          children: [
                                                            (data[i].reactId != null)
                                                                ? SvgPicture.asset(
                                                              IconPath.heartFilled,
                                                              color: CustomColor.primary,
                                                              width: 16,
                                                            )
                                                                : SvgPicture.asset(
                                                              IconPath.postHeartIcon,
                                                              width: 16,
                                                            ),
                                                            Text(
                                                              data[i].likesCount == 0 ? '0' : data[i].likesCount.toString(),
                                                              textAlign: TextAlign.start,
                                                              style: CustomTextStyle.textStyle(
                                                                  fontWeight: FontWeight.w400, fontSize: 10, color: CustomColor.white, height: 1.2),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      hSize(5),
                                                      // InkWell(
                                                      //   onTap: () {
                                                      //     showModalBottomSheet(
                                                      //       useSafeArea: false,
                                                      //       context: context,
                                                      //       backgroundColor: CustomColor.black.withOpacity(0.4),
                                                      //       isDismissible: true,
                                                      //       isScrollControlled: true,
                                                      //       builder: (context) => UserPOstCommentBottomSheet(
                                                      //         postId: data[i].postId,
                                                      //       ),
                                                      //     );
                                                      //   },
                                                      //   child: Column(
                                                      //     children: [
                                                      //       SvgPicture.asset(
                                                      //         IconPath.chat,
                                                      //         width: 16,
                                                      //       ),
                                                      //       const SizedBox(
                                                      //         height: 0.7,
                                                      //       ),
                                                      //       Text(
                                                      //         data[i].commentsCount == 0 ? "0" : data[i].commentsCount.toString(),
                                                      //         style: CustomTextStyle.textStyle(
                                                      //             fontWeight: FontWeight.w400, fontSize: 10, color: CustomColor.white, height: 1.2),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                                                      margin: EdgeInsets.only(left: 10.h),
                                                      decoration: BoxDecoration(
                                                          color: Constants.getColorFromCategory(categoryId: data[i].category.id),
                                                          borderRadius: BorderRadius.circular(20)),
                                                      child: Text(
                                                        (data[i].category.name.toString()).tr(),
                                                        textAlign: TextAlign.center,
                                                        style: CustomTextStyle.textStyle(
                                                            fontWeight: FontWeight.w700, fontSize: 8, color: CustomColor.white, height: 1.2),
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: 189.h,
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(left: 10.h, right: 10.h, bottom: 10.h, top: 3.h),
                                                      child: Text(
                                                        data[i].html==null? "":
                                                        data[i].html.toString().replaceAll('\\n', '\n'),
                                                        textAlign: TextAlign.start,
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: CustomTextStyle.textStyle(
                                                            fontWeight: FontWeight.w400, fontSize: 12, color: CustomColor.white, height: 1.38),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              hSize(24),

              ///인기 프로그램
              Column(
                children: [
                  Row(
                    children: [
                      wSize(20),
                      Text(
                        'Home_Main_0007'.tr(),
                        style: CustomTextStyle.headerM.copyWith(height: 1),
                      ),
                    ],
                  ),
                  hSize(12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: SizedBox(
                      height: 220.h,
                      child: popularCarePrograms.when(
                        data: (data) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => context.pushNamed('program-details', queryParams: {
                                "care_program_id": data[index].id.toString()
                              }),
                              child: CareProgramCard(
                                name: data[index].name.tr(),
                                //description: data[index].description!.tr(),
                                // imageUrl: data[index].image,
                                imageUrl: index % 4 == 0
                                    ? 'assets/images/nuuz_5954_1.png'
                                    : index % 4 == 1
                                    ? 'assets/images/nuuz_5501_1.png'
                                    : index % 4 == 2
                                    ? 'assets/images/nuuz_4928_1.png'
                                    : 'assets/images/nuuz_4170_1.png',
                              ),
                            ),
                            separatorBuilder: (context, index) => wSize(12),
                            itemCount: data.length),
                        error: (error, _) => const Text('Error occured'),
                        loading: () => loadingScreen(),
                      ),
                    ),
                  )
                ],
              ),


              hSize(12),
              productList == null ? Center(child: CustomIndicator('Comm_Gene_0001'.tr())) : productView(productList, context, 3),
            ],
          ),
        );
      },
    );
  }

  Future<void> callPostAPI() async {
    ref.read(getPostsProvider.notifier).skip = 1;
    ref.read(getPostsProvider.notifier).state = null;


    await ref.watch(userPostsProvider.notifier).getAllPosts(
        ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList[ref.read(getPostsProvider.notifier).selectedIndex].id,
        ref.read(getPostsProvider.notifier).skip,
        context);
    ref.read(getPostsProvider.notifier).setData( ref.watch(userPostsProvider) ?? []);
  }


  @override
  bool get wantKeepAlive => true;
}









final popularPostProvider = StateNotifierProvider<PopularPostProvider, List<UserPost>>((ref) {
  return PopularPostProvider();
});
class PopularPostProvider extends StateNotifier<List<UserPost>> {
  PopularPostProvider() : super([]);
  List<UserPost> popularPost = [];
  List<UserPost> post = [];


  Future<void> getAllPosts() async {
    safePrint('겟 올 포스트');
    //state.clear();
    try {
      post = await UserPostRepository().getPopularPosts();
      safePrint('포스트 길이');
      safePrint(post.length);

      for(int i=0;i<post.length; i++){
        if(post[i].is_popular==1){
          popularPost.add(post[i]);
        }
      }
      state = popularPost;
    } catch (e) {
      safePrint(e);
    }
  }




}