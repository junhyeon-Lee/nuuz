import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/nuuz_talk/userpostlist.dart';
import 'package:nuuz/modules/home/nuuz_talk_screen.dart';
import 'package:nuuz/modules/nuuz_talk/comment/commets_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/nuuz_talk_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/nuuz_talk_search_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ui/common/padding_sizedbox.dart';
import '../../../ui/theme/color_style.dart';
import '../../../ui/theme/icon_path.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

final TextEditingController _searchController = TextEditingController();

class _SearchScreenState extends ConsumerState<SearchScreen> {
  LocalDB localDB = LocalDB();
  List recentSearches = [

  ];

  var productdetail2;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(userAllPostNotifier.notifier).getAllPosts(context: context);
      productdetail2 = ref.watch(userAllPostNotifier);
      setState(() {});
      safePrint("posts-------->$productdetail2");
      result = await ref.watch(nuuzTalkSearchKeyProvider);
      await localDB.getRecentSearches().then((value) {
        setState(() {
          recentSearches = value;
          safePrint("recentSearches---->${recentSearches}");
        });
      });
    });
  }
  List<UserPost> result = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Constants.isRefresh=true;
        setState(() {
          _searchController.text = "";
        });
        Navigator.of(context, rootNavigator: true).pop();
       // context.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.text = "";
                    });
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: CustomColor.black,
                  ));
            }),
            centerTitle: true,
            backgroundColor: CustomColor.background,
            title: Text(
              "Comm_Gene_0037".tr(),
              style: CustomTextStyle.headerL,
            )),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final searchData = ref.watch(nuuzTalkSearchKeyProvider);
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hSize(10.h),
                  Container(
                    height: 55.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: CustomColor.white),
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextField(
                        controller: _searchController,
                        onEditingComplete: () {

                        },
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () async {
                                await ref.watch(nuuzTalkSearchKeyProvider.notifier).getSearch(_searchController.text);
                                setState(() {

                                });
                              },
                              child: SvgPicture.asset(
                                IconPath.search,
                                height: 5,
                                width: 5,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                            hintText: "Talk_Serc_0001".tr()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),




                  searchData.isNotEmpty ? Text(
                    'Talk_Serc_0004'.tr().replaceAll('{}', searchData.length.toString()),
                    style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700,fontSize: 15),
                  ) : const SizedBox(),

                  SizedBox(
                    height: 12.h,
                  ),

                  searchData.isEmpty && _searchController.text.isNotEmpty
                      ? Container(
                    width: 350.w,
                    //height: 130.h,
                    decoration:
                    BoxDecoration(color: CustomColor.lightGray, borderRadius: const BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          hSize(22),
                          SvgPicture.asset(
                            IconPath.noData,
                            color: CustomColor.lightDark,
                          ),
                          hSize(13),
                          Text(
                            'Talk_Serc_0002'.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColor.lightDark),
                          ),
                        ],
                      ),
                    ),
                  )
                      : searchData.isEmpty && _searchController.text.isEmpty
                      ?recentSearches.isEmpty ?const SizedBox.shrink():RecentSearches(
                    recentSearches: recentSearches,
                    onTap: (data) {
                      setState(() {
                        safePrint("_searchController.text====>${_searchController.text}");
                      });
                    },
                  )
                      :
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (380.w - 20.w) / 5 / 104.h,
                          crossAxisSpacing: 15.h,
                          mainAxisSpacing: 18.h,
                        ),
                        itemCount: ref.watch(nuuzTalkSearchKeyProvider).length,
                        itemBuilder: (context, i) {
                          return buildPostWidget(ref.watch(nuuzTalkSearchKeyProvider), i);
                        },
                      );
                    },
                  )





                ],
              );

            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildPostWidget(data, int i) {
    return GestureDetector(
        onTap: () async {

          Constants.isAPICall = false;
          await ref.watch(commentLengthProvider.notifier).setCommentLength(data[i].commentsCount);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewPostScreen(
                    isEditingPost: false,
                    userPost: data[i],
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
                        //callPostAPI();
                      }
                    },
                    postId: data[i].postId),
              )).then((value) {
            if (Constants.isAPICall) {
             // callPostAPI();
            } else {
              if (value != null) {
                UserPost userPost = value;
                ref.read(getPostsProvider.notifier).updateData(index: i, userPost: userPost);
              }
            }
          });
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

}

class RecentSearches extends StatefulWidget {
  final List recentSearches;
  Function(String text) onTap;

  RecentSearches({super.key, required this.recentSearches, required this.onTap});

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {
  LocalDB db = LocalDB();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: CustomColor.white),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MediumHeaderText(text: 'Talk_Serc_0007'.tr()),
            hSize(10.h),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < widget.recentSearches.length; i++)
                      Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: InkWell(
                          onTap: () {
                            _searchController.text = widget.recentSearches[i];
                            widget.onTap(widget.recentSearches[i]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LargeDescriptionText(text: widget.recentSearches[i]),
                              InkWell(
                                  onTap: () {
                                    widget.recentSearches.remove(widget.recentSearches[i]);
                                    db.updateRecent(widget.recentSearches);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.close))
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResults extends StatefulWidget {
  final List result;
  WidgetRef ref;

  SearchResults({super.key, required this.result, required this.ref});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (380.w - 20.w) / 5 / 104.h,
              crossAxisSpacing: 15.h,
              mainAxisSpacing: 18.h,),
            itemCount: widget.result.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                  onTap: () async {
                    await ref.watch(commentLengthProvider.notifier).setCommentLength(widget.result[i].commentsCount);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewPostScreen(
                              isEditingPost: false,
                              userPost: widget.result[i],
                              reviews: const [],
                              programs: const [],
                              products: const [],
                              userImage: "",
                              isCreatePost: false,
                              isShowProducts: true,
                              postId: widget.result[i].postId ?? ''),
                        )).then((value) {
                      if (value != null) {
                        UserPost userPost = value;
                        widget.result[i] =
                            widget.result[i].copyWith(isLiked: userPost.isLiked, likesCount: userPost.likesCount, reactId: userPost.reactId);
                        setState(() {

                        });
                      }
                    });
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
                            child: widget.result[i].imageUrls.length > 0
                                ? CachedNetworkImage(
                              imageUrl: widget.result[i].imageUrls[0],
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Image.asset(
                                Constants.getImageFromCategory(categoryId: widget.result[i].category.id),
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              Constants.getImageFromCategory(categoryId: widget.result[i].category.id),
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
                          ),),




                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40.h,
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
                                        imageUrl: widget.result[i].user?.profile_image ?? '',
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Center(child: Image.asset(IconPath.noProfile)),
                                        width: 18,
                                        height: 18,
                                      ),
                                    ),
                                    wSize(8),
                                    Expanded(
                                      child: Text(
                                        '${widget.result[i].name}',
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

                                        if (!widget.ref.read(nuuzTalkSearchProvider.notifier).isCallReactAPI) {
                                          widget.ref.read(nuuzTalkSearchProvider.notifier).isCallReactAPI = true;
                                          if (widget.result[i].reactId != null) {
                                            bool isUpdate = await widget.ref
                                                .watch(nuuzTalkSearchProvider.notifier)
                                                .deleteReaction(userPost: widget.result[i], index: i);
                                            if (isUpdate) {
                                              widget.result[i] =
                                                  widget.result[i].copyWith(isLiked: false, likesCount: widget.result[i].likesCount - 1, reactId: null);
                                            }
                                          } else {
                                            bool isUpdate = await widget.ref
                                                .watch(nuuzTalkSearchProvider.notifier)
                                                .createReaction( userPost: widget.result[i], index: i);
                                            if (isUpdate) {
                                              List<UserPost> pos =
                                              await widget.ref.watch(userPostsProvider.notifier).getPosts(postId: widget.result[i].postId,userId: widget.result[i].userId);
                                              if (pos.length > 0) {
                                                widget.result[i] = widget.result[i]
                                                    .copyWith(isLiked: true, likesCount: widget.result[i].likesCount + 1, reactId: pos[0].reactId);
                                              }
                                            }
                                          }

                                          widget.ref.read(nuuzTalkSearchProvider.notifier).isCallReactAPI = false;
                                          setState(() {

                                          });
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          widget.result[i].reactId !=null
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
                                            (widget.result[i].likesCount).toString(),
                                            textAlign: TextAlign.start,
                                            style: CustomTextStyle.textStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: CustomColor.white,
                                                height: 1.2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          useSafeArea: true,
                                          context: context,
                                          backgroundColor: CustomColor.black.withOpacity(0.4),
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          builder: (context) => UserPOstCommentBottomSheet(
                                            postId: widget.result[i].postId ?? '',
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            IconPath.chat,
                                            width: 16,
                                          ),
                                          Text(
                                            (widget.result[i].commentsCount ?? 0).toString(),
                                            style: CustomTextStyle.textStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: CustomColor.white,
                                                height: 1.2),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                        color: Constants.getColorFromCategory(
                                            categoryId: (widget.result[i].category.id ?? '')),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      (widget.result[i].category.name.toString() ?? '').tr(),
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyle.textStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 8,
                                          color: CustomColor.white,
                                          height: 1.2),
                                    ),

                                  ),
                                  Container(
                                    width: 144.w,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 10.h, right: 10.h, bottom: 10.h, top: 3.h),
                                    child: Text(
                                      (widget.result[i].title ?? '').toString(),
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.textStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: CustomColor.white,
                                          height: 1.38),
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
        );
      },
    );
  }

  Wrap buildWrap() {
    return Wrap(
      spacing: 15.h,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        for (int i = 0; i < widget.result.length; i++)
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      widget.result[i].imageUrls[0],
                    ),
                    fit: BoxFit.cover),
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(20)),
            width: 170.h,
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 45.h,
                      width: 170.h,
                      decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              IconPath.noProfile,
                              width: 30,
                            ),
                            wSize(10),
                            SizedBox(
                              width: 110.h,
                              child: Text(
                                '${widget.result[i].name}',
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          IconPath.heart,
                          width: 20,
                        ),
                      ),
                      Text(
                        widget.result[i].likesCount == 0 ? '' : widget.result[i].likesCount.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(color: CustomColor.white),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          IconPath.chat,
                          width: 20,
                        ),
                      ),
                      Text(
                        widget.result[i].commentsCount == 0 ? "" : widget.result[i].commentsCount.toString(),
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Container(
                          height: 26.h,
                          width: 70.h,
                          decoration:
                              BoxDecoration(color: CustomColor.blue.withOpacity(0.9), borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              widget.result[i].category.name.toString().tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: CustomColor.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: SizedBox(
                          width: 189.h,
                          child: Text(
                            widget.result[i].title.toString(),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style:
                                TextStyle(overflow: TextOverflow.ellipsis, color: CustomColor.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}


final nuuzTalkSearchKeyProvider = StateNotifierProvider<NuuzTalkSearchKeyProvider, List<UserPost>>((ref) {
  return NuuzTalkSearchKeyProvider();
});

class NuuzTalkSearchKeyProvider extends StateNotifier<List<UserPost>> {
  NuuzTalkSearchKeyProvider() : super([]);

  NuuzTalkSearchRepository nuuzTalkSearchRepository = NuuzTalkSearchRepository();

  getSearch(String keyword) async {
    List<UserPost>? result = await nuuzTalkSearchRepository.getSearch(keyword);
    if(result!=null){
      if(result.isNotEmpty){
        state = result;
      }
    }
    safePrint('검색작업완료');
    safePrint(result?.length??9999);
  }

}



class NuuzTalkSearchRepository {
  static final NuuzTalkSearchRepository _repository = NuuzTalkSearchRepository._intrnal();

  factory NuuzTalkSearchRepository() => _repository;

  NuuzTalkSearchRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<List<UserPost>?> getSearch(String keyword) async {
    var queryParameters = {
      "limit": 10000,
      "page": 1,
      "keyword": keyword,
    };

    try {
      final response = await dio.get('/post/all',
          queryParameters: queryParameters);
      if (response.statusCode == 200) {

        final result = UserPostList.fromJson(response.data);
        return result.postData?.records;
      }
    } catch (e) {
      safePrint('검색에 문제가 있습니다.');
      safePrint(e);
      return null;
    }
    return null;
  }


}