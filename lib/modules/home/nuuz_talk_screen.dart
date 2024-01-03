import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/home/service_providers/article/article_provider.dart';
import 'package:nuuz/modules/nuuz_talk/comment/commets_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/edit_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/nuuz_talk_controller.dart';
import 'package:nuuz/modules/nuuz_talk/nuuz_talk_search.dart';
import 'package:nuuz/modules/nuuz_talk/post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/nuuz_talk_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/trend/trend_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_controller.dart';
import 'package:nuuz/modules/nuzz_care/face_detection_guide/cartridge_screen.dart';
import 'package:nuuz/modules/nuzz_care/result/my_nuuz_reservation_sheet.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/loader.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/%20statistics/view_count_controller.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/program.dart';
import '../nuzz_care/result/providers/result/result_provider.dart';

class NuuzTalkScreen extends ConsumerStatefulWidget {
  const NuuzTalkScreen({super.key});

  @override
  ConsumerState<NuuzTalkScreen> createState() => NuuzTalkScreenState();
}

class NuuzTalkScreenState extends ConsumerState<NuuzTalkScreen> with AutomaticKeepAliveClientMixin<NuuzTalkScreen>{
  bool isLazyLoading = false;
  var userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(myDrawerProvider.notifier).getUserData();
      userData = ref.watch(myDrawerProvider);
      // ref.watch(trendProvider.notifier).getTrends(context: context);
      // ref.watch(nuuzTalkCategoryProvider.notifier).getCategory();
      // await ref.watch(userPostsProvider.notifier).getAllPosts("Prog_Part_0012".tr(), skip, context);
      // posts = ref.watch(userPostsProvider);
      // setState(() {});
      // safePrint("posts---->${posts}");
    });
  }



  @override
  Widget build(BuildContext context) {
    final trendsList = ref.watch(trendProvider);
    final postList = ref.watch(getPostsProvider);

    return Stack(
      children: [
        Stack(
          children: [
            LazyLoadScrollView(
              onEndOfPage: () async {
                ref.read(getPostsProvider.notifier).skip += 1;
                isLazyLoading = true;

                await ref.read(userPostsProvider.notifier).getAllPosts(
                    ref
                        .read(nuuzTalkCategoryProvider.notifier)
                        .talkCategoryList[ref.read(getPostsProvider.notifier).selectedIndex]
                        .id,
                    ref.read(getPostsProvider.notifier).skip,
                    context);

                 ref.watch(getPostsProvider.notifier).addList(ref.watch(userPostsProvider) ?? []);
                isLazyLoading = false;
              },
              // isLoading: isLazyLoading,
              child: RefreshIndicator(
                color: CustomColor.dark,
                onRefresh: () async {
                  ref.read(trendProvider)?.clear();
                  ref.read(getPostsProvider.notifier).state = null;
                  ref.watch(trendProvider.notifier).state = null;

                  await ref.watch(trendProvider.notifier).getTrends(context: context);
                  ref.read(getPostsProvider.notifier).skip = 1;

                  await ref.watch(userPostsProvider.notifier).getAllPosts(
                      ref
                          .watch(nuuzTalkCategoryProvider.notifier)
                          .talkCategoryList[ref.read(getPostsProvider.notifier).selectedIndex]
                          .id,
                      ref.read(getPostsProvider.notifier).skip,
                      context);
                  ref.watch(getPostsProvider.notifier).setData(ref.watch(userPostsProvider) ?? []);

                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // shrinkWrap: true,
                    children: [
                      trendsList?.length == null
                          ? const Center(
                        child: CustomIndicator(''),
                      )
                          : trendsList?.length == 0
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
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          left: 0,
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child:
                                          (trendsList?[index].banner_image ?? '').toLowerCase().contains('http')
                                              ? CachedNetworkImage(
                                            imageUrl: trendsList?[index].banner_image ?? '',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(
                                              color: CustomColor.gray.withOpacity(0.3),
                                            ),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),

                                          )
                                              : Image.asset(
                                            trendsList?[index].banner_image ?? '',
                                            fit: BoxFit.cover,
                                          ),
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
                                                    style:
                                                    CustomTextStyle.headerXS.copyWith(color: CustomColor.white),
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
                      hSize(20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          height: 98.h,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: (380.w - 20.w) / 5 / 98.h,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () async {
                                    ref.read(getPostsProvider.notifier).skip = 1;
                                    ref.read(getPostsProvider.notifier).state = null;
                                    ref.read(getPostsProvider.notifier).selectedIndex = index;

                                    await ref.watch(userPostsProvider.notifier).getAllPosts(
                                        ref
                                            .watch(nuuzTalkCategoryProvider.notifier)
                                            .talkCategoryList[ref.read(getPostsProvider.notifier).selectedIndex]
                                            .id,
                                        ref.read(getPostsProvider.notifier).skip,
                                        context);
                                    safePrint('데이터 확인하기');
                                    safePrint(ref.watch(userPostsProvider));
                                    ref.read(getPostsProvider.notifier).setData(ref.watch(userPostsProvider) ?? []);
                                    ///여기입니다.
                                    setState(() {

                                    });
                                  },
                                  child: categoryItem(
                                      ref.read(getPostsProvider.notifier).selectedIndex == index ? true : false, index));
                            },
                            itemCount: ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList.length,
                          ),
                        ),
                      ),
                      hSize(12),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList.isNotEmpty
                              ? ref
                              .watch(nuuzTalkCategoryProvider.notifier)
                              .talkCategoryList[ref.read(getPostsProvider.notifier).selectedIndex]
                              .title
                              .tr()
                              : '',
                          style: CustomTextStyle.textStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      hSize(12),
                      postList == null
                          ? Container(
                        // height: MediaQuery.of(context).size.height - 200,
                          alignment: Alignment.center,
                          child: CustomIndicator('Comm_Gene_0001'.tr()))
                          : postList.length == 0
                          ? NoItemFound(title: 'Talk_Prof_0008'.tr(), icon: IconPath.noPostIcon)
                          : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (380.w - 20.w) / 5 / 104.h,
                            crossAxisSpacing: 15.h,
                            mainAxisSpacing: 18.h,
                          ),
                          itemCount: postList.length,
                          itemBuilder: (context, i) {
                            return buildPostWidget(postList, i);
                          },
                        ),
                      ),
                      hSize(36)
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditPostScreen(),
                        )).then((value) {
                      if (Constants.isAPICall) {
                        callPostAPI();
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.elliptical(20, 18)),
                      color: CustomColor.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset(IconPath.edit),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        loadingScreen()
      ],
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

  Widget categoryItem(bool isSelected, int index) {
    return SizedBox(
      width: 62.w,
      height: 98.h,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 62.w,
            height: 62.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(IconPath.customSquare, color: isSelected ? Colors.black : Colors.white),
                isSelected
                    ? SvgPicture.asset(ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList[index].onIcon)
                    : SvgPicture.asset(ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList[index].icon),
              ],
            ),
          ),
          SizedBox(
            width: 62.w,
            height: 36.h,
            child: Center(
              child: RichText(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: ref.watch(nuuzTalkCategoryProvider.notifier).talkCategoryList[index].title.tr(),
                    style: CustomTextStyle.textStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: isSelected ? CustomColor.dark : CustomColor.lightDark,
                        height: 1.3),
                  ),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildPostWidget(data, int i) {
    return GestureDetector(
        onTap: () async {

          ViewCountRepository viewCountRepository = ViewCountRepository();
          viewCountRepository.increaseViewCount(data[i].postId, null, null, null,null);

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
                  child: data[i].imageUrls.length > 0
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
                              fit: BoxFit.cover,
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
  }

  bool get wantKeepAlive => true;
}