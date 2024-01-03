// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/home/nuuz_home/products.dart';
import 'package:nuuz/modules/nuuz_talk/bottom_sheet/complete_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/bottom_sheet/delete_post_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/comment/commets_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/edit_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/latest_comment/latest_comment_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/preview_post_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/user_profile_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/loader.dart';
import 'package:nuuz/ui/report/report_bottomsheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';

import 'preview_post_screen.dart';
import 'providers/user_post/repository/user_post_repository.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({
    super.key,
    required this.programs,
    required this.reviews,
    required this.products,
    required this.isEditingPost,
    required this.userImage,
    required this.postId,
    required this.isCreatePost,
    this.isShowMenu,
    this.index,
    this.isShowProducts,
    this.onTapMenu,
  });

  final String userImage;
  final bool isEditingPost;
  final List<Program> programs;
  final List<Result> reviews;
  final List<Product> products;
  final String postId;
  final bool? isCreatePost;
  final bool? isShowMenu;
  final bool? isShowProducts;
  final int? index;
  final VoidCallback? onTapMenu;

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final carouselController = CarouselController();
  int selectedImagesIndex = 0;
  UserData? user;
  LoginResponse? loginResponse;
  List<UserPost>? postList;
  var commentList;
  List<Program> programs = [];
  List<Result> reviews = [];
  List<Product> products = [];
  bool isLoadingItem = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final userPost = ref.watch(singlePostUserPostProvider);

      LocalDB localDB = LocalDB();
      loginResponse = await localDB.findAuthInfo();
      user = await localDB.findUserInfo();

      if ((widget.isCreatePost ?? false) == false) {
        ref.watch(previewPostNotifier(widget.postId).notifier).setUserPost(userPost:userPost!);
        if (userPost!.latestComment!=null && userPost!.latestComment?.commentId!=null) {
          ref.watch(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).getLatestComment(commentId: userPost!.latestComment?.commentId ?? '');
        }

        if (widget.isShowProducts ?? false) {
          if (userPost!.productIds != null) {
            for (var id in userPost!.productIds) {
              Product? product = await ref.watch(productController.notifier).fetchProductById(id);
              if (product != null) {
                products.add(product);
              }
            }
          }

          if (userPost!.programIds != null) {
            for (var id in userPost!.programIds) {
              Program? prog = await ref.watch(programController.notifier).getProgramByID(id);
              if (prog != null) {
                programs.add(prog);
              }
            }
          }

          if (userPost!.reviewIds != null) {
            LocalDB localDB = LocalDB();
            LoginResponse? loginResponse = await localDB.findAuthInfo();

            for (var id in userPost!.reviewIds) {
              Result? review = await ref.watch(resultProvider.notifier).fetchResultById(id, loginResponse?.accessToken ?? '');
              if (review != null) {
                reviews.add(review);
              }
            }
          }
        }
      }
      isLoadingItem = false;

      await ref.watch(commentLengthProvider.notifier).setCommentLength(userPost!.commentsCount);


      if(userPost?.reactId!=null){
        isLikeState=true;
      }else{
        isLikeState=false;
      }
      if(userPost?.likesCount!=null){
        likeCount = userPost!.likesCount!;
      }else{
        likeCount = 0;
      }
      if(commentList?[0].is_liked == Constants.isLiked){
        isCommentLikeState=true;
      }else{
        isCommentLikeState=false;
      }
      if(commentList?[0].reactions){
        commentLikeCount = userPost!.likesCount!;
      }else{
        commentLikeCount = 0;
      }
      setState(() {});
    });
  }

  bool isLikeState=false;
  int likeCount =0;
  bool isCommentLikeState=false;
  int commentLikeCount =0;
  int commentCount=0;

  @override
  void dispose() {
    final userPost = ref.watch(singlePostUserPostProvider);
    ref.invalidate(previewPostNotifier(widget.postId));
    ref.invalidate(latestCommentNotifier(userPost!.latestComment?.commentId ?? ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    final userPost = ref.watch(singlePostUserPostProvider);

    safePrint('좋아요 상태 확인');
    safePrint(userPost?.likesCount);
    safePrint(userPost?.reactId);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColor.background,
      ),
      child: WillPopScope(
        onWillPop: () async{
          Navigator.pop(context, userPost);
          return true;
        },
        child: Scaffold(
          backgroundColor: CustomColor.background,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context, userPost);
                      },
                      child: SizedBox(
                        width: 30.w,
                        child: SvgPicture.asset(
                          IconPath.appbarBack,
                        ),
                      ),
                    ),


                    Expanded(child: Center(
                      child: Text(
                        (widget.isCreatePost ?? false) ? "Talk_Post_0003".tr() : userPost?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textStyle(fontSize: 22.sp,fontWeight: FontWeight.w700,color: CustomColor.dark,height: 1),
                      ),
                    ),),
                    userPost!.userId == user?.user_id && !widget.isEditingPost
                        ? IconButton(
                        onPressed: () {
                          safePrint("call delete post====> ${userPost!.postId}");
                          buildEditPostBottomSheet(
                            context,
                            onTapDeletePost: () async {
                              deletePostBottomSheet(context: context, postId: userPost!.postId);
                            },
                            onTapEditPost: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPostScreen(userPostId: userPost!.postId),
                                  ));
                            },
                          );
                        },
                        icon: SizedBox(
                            width: 30.w,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(IconPath.post))))
                        :
                    widget.isCreatePost!=true?
                    IconButton(onPressed: (){
                      showReport(context: context,
                        isUserReport: false,
                        isPostReport: true,
                        postId: widget.postId??"",
                      );
                    }, icon: SvgPicture.asset(
                      IconPath.report,
                      color: CustomColor.black,
                    )
                    ):Container() ],
                ),
              )
          ),
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: NuuzContainer(
                          containerColor: CustomColor.background,
                          borderColor: CustomColor.background,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hSize(12),
                                NuuzContainer(
                                  child: Column(
                                    children: [
                                      userPost.imageUrls.isEmpty
                                          ? const SizedBox()
                                          : Column(
                                        children: [
                                          CarouselSlider.builder(
                                            carouselController: carouselController,
                                            itemCount: userPost.imageUrls.length,
                                            itemBuilder: (context, index, realIndex) {
                                              safePrint("this is real index and normal index  $realIndex  $index");
                                              return SizedBox(
                                                width: 350.w,
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: userPost.imageUrls[index] ?? '',
                                                    placeholder: (context, url) =>
                                                    Container(),
                                                    errorWidget: (context, url, error) =>
                                                    const Center(child: Icon(Icons.error)),
                                                    width: 350.w,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              );
                                            },
                                            options: CarouselOptions(
                                              onPageChanged: (index, reason) {
                                                // _currentIndex = index;

                                                setState(() {
                                                  selectedImagesIndex = index;
                                                });
                                              },
                                              viewportFraction: 1,
                                              height: 350.h,
                                              enlargeFactor: 1,
                                              enableInfiniteScroll: false,
                                            ),
                                          ),
                                          hSize(12),
                                          SizedBox(
                                            height: 5.h,
                                            child: ListView.builder(
                                              itemCount: userPost.imageUrls.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return AnimatedContainer(
                                                  margin: EdgeInsets.only(right: 3.h),
                                                  duration: const Duration(milliseconds: 150),
                                                  width: selectedImagesIndex == index ? 32.w : 6.w,
                                                  height: 5.h,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: CustomColor.primary, width: 1.w),
                                                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                    color:
                                                    selectedImagesIndex == index ? Colors.transparent : CustomColor.primary,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          hSize(12),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) => UserProfileScreen(
                                                            userId: userPost.userId,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(children: [
                                                      SizedBox(
                                                        height: 40.h,
                                                        width: 40.h,
                                                        child: ClipRRect(
                                                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                          child: CachedNetworkImage(
                                                            imageUrl: (widget.isCreatePost ?? false)
                                                                ? widget.userImage
                                                                : userPost.user?.profile_image ?? '',
                                                            placeholder: (context, url) =>
                                                            Container(),
                                                            errorWidget: (context, url, error) =>
                                                                Center(child: Image.asset(IconPath.noProfile)),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      wSize(6),
                                                      Expanded(
                                                        child: Text(
                                                          userPost.name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: CustomTextStyle.headerS,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Constants.getColorFromCategory(categoryId: userPost.category.id),
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                                                  child: Text(
                                                    userPost.category.name.tr(),
                                                    style: CustomTextStyle.textStyle(
                                                        fontSize: 10, fontWeight: FontWeight.w400, color: CustomColor.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                            hSize(6),

                                            //                             Text(
                                            //                                   widget.userPost.title!.replaceAll('\\n', '\n')??"",
                                            //                                     style: CustomTextStyle.descriptionM
                                            //                                   ),
                                            //                                     if(widget.userPost.html!=null)
                                            //                                         Text(
                                            //                                               widget.userPost.html!.replaceAll('\\n', '\n')??"",
                                            //                                                   style: CustomTextStyle.descriptionM
                                            //                                             ),

                                            // Text((widget.userPost.title ?? '').replaceAll('\\n', '\n'),
                                            //     style: CustomTextStyle.descriptionM),
                                            Text((userPost.html ?? '').replaceAll('\\n', '\n'),
                                                style: CustomTextStyle.descriptionM),

                                            hSize(12),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    ///색바꾸기
                                                    if(isLikeState){
                                                      isLikeState=false;
                                                      likeCount--;
                                                    }else{
                                                      isLikeState=true;
                                                      likeCount++;
                                                    }
                                                    setState(() {

                                                    });
                                                    if ((widget.isCreatePost ?? false) == false && !ref.read(previewPostNotifier(widget.postId).notifier).isReactionApiCall) {
                                                      ref.read(previewPostNotifier(widget.postId).notifier).isReactionApiCall=true;
                                                      if (userPost?.reactId !=null) {
                                                        ref.read(previewPostNotifier(widget.postId).notifier).deleteReaction(
                                                            userPost: userPost, context: context, reactionId: userPost?.reactId ??' ');
                                                      } else {
                                                        ref.read(previewPostNotifier(widget.postId).notifier)
                                                            .createReaction(userPost: userPost, context: context,ref: ref);
                                                      }
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        IconPath.heartFilled,
                                                        color: isLikeState ? CustomColor.primary : CustomColor.gray,
                                                        height: 20.h,
                                                      ),
                                                      wSize(4),
                                                      Text((likeCount).toString(),  style: CustomTextStyle.textStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                                    ],
                                                  ),
                                                ),
                                                wSize(30),
                                                InkWell(
                                                  onTap: () {
                                                    if ((widget.isCreatePost ?? false) == false) {
                                                      showModalBottomSheet(
                                                        useSafeArea: false,
                                                        context: context,
                                                        backgroundColor: CustomColor.black.withOpacity(0.4),
                                                        isDismissible: true,
                                                        isScrollControlled: true,
                                                        builder: (context) => UserPOstCommentBottomSheet(
                                                          postId: widget.postId,
                                                        ),
                                                      ).then((value) {
                                                        if (userPost.latestComment!=null && userPost.latestComment?.commentId!=null) {
                                                          ref.read(latestCommentNotifier(userPost.latestComment?.commentId ?? '').notifier).getLatestComment(commentId: userPost.latestComment?.commentId ?? '');
                                                        }
                                                      });
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        IconPath.chat,
                                                        color: CustomColor.dark,
                                                        height: 20.h,
                                                      ),
                                                      wSize(4),
                                                      Text(ref.watch(commentLengthProvider).toString(),  style: CustomTextStyle.textStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  Constants.convertSpecificFormat(
                                                      date: userPost.createdAt??DateTime.now().toString(), format: "yyyy.MM.dd"),
                                                  style: CustomTextStyle.textStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                hSize(12),
                                (widget.isCreatePost ?? false) ?
                                noCommentView() :
                                userPost.latestComment?.commentId!=null ?
                                commentView(commentId: userPost.latestComment?.commentId ?? '') : noCommentView(),

                                if (isLoadingItem&&(widget.isCreatePost !=true)) ...[ Center(child: Container())],
                                if (widget.isShowProducts ?? false) ...[
                                  showUserProductProgramReviews()
                                ] else ...[
                                  showUserProductProgram()
                                ],
                                hSize(5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // user?.user_id == _userPost?.userId && user?.user_id!=null
                    (widget.isCreatePost ?? false) || (widget.isEditingPost)
                        ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 120.w,
                                  child: CommonOutlinedButton(
                                      onPressed: () => Navigator.of(context).pop(), child: Text("Comm_Gene_0006".tr()))),
                              SizedBox(
                                  width: 120.w,
                                  child: CommonButton(
                                      onPressed: () async {
                                        if (widget.isCreatePost ?? false) {
                                          widget.reviews.forEach((element) async {
                                            Map<String, dynamic> updateResultData = {
                                              "privacy": "public",
                                              "date": DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                                            };
                                            await UserPostRepository().updateReviewResult(updateResultData, element.result_id);
                                          });

                                          Map<String, dynamic> data = {
                                            "name": (user?.nick_name ?? '').trim(),
                                            "category": userPost.category.id.trim(),
                                            "title":"title",
                                            "html" :userPost.title??"".trim(),
                                            "image": userPost.imageUrls,
                                            "likesCount": userPost.likesCount,
                                            "commentsCount": userPost.commentsCount,
                                            "hashtag": userPost.hashtag ?? [],
                                            "items": userPost.items ?? [],
                                            "productId": userPost.productIds ?? [],
                                            "programId":userPost.programIds ?? [],
                                            "reviewId": userPost.reviewIds ?? [],
                                          };


                                          appLoader(context);
                                          await ref.watch(createPostProvider.notifier).createPost(data, context);
                                          var responseData = ref.watch(createPostProvider);
                                          removeAppLoader();
                                          if (responseData != null && responseData) {
                                            completeBottomSheet(
                                                context: context,
                                                description: 'Talk_Post_0010',
                                                onTap: () {
                                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                "something went to wrong",
                                                style: CustomTextStyle.textStyle(
                                                    color: CustomColor.primary, fontWeight: FontWeight.w700, fontSize: 14.sp),
                                              ),
                                              backgroundColor: CustomColor.white,
                                            ));
                                          }
                                        }
                                        else {
                                          widget.reviews.forEach((element) async {
                                            Map<String, dynamic> updateResultData = {
                                              "privacy": "public",
                                              "date": DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                                            };
                                            await UserPostRepository().updateReviewResult(updateResultData, element.result_id);
                                          });

                                          Map<String, dynamic> data = {
                                            "name": (user?.nick_name ?? '').trim(),
                                            "category": userPost!.category.id.trim(),
                                            "title":"title",
                                            "html" :userPost!.title??"".trim(),
                                            "image": userPost!.imageUrls,
                                            "hashtag": userPost!.hashtag ?? [],
                                            "items": userPost!.items ?? [],
                                            "productId": userPost!.productIds ?? [],
                                            "programId": userPost!.programIds ?? [],
                                            "reviewId": userPost!.reviewIds ?? [],
                                          };

                                          appLoader(context);
                                          await ref
                                              .watch(createPostProvider.notifier)
                                              .updatePost(data: data, postId: widget.postId);
                                          var responseData = ref.watch(createPostProvider);

                                          removeAppLoader();
                                          if (responseData != null && responseData) {
                                            completeBottomSheet(
                                                context: context,
                                                description: 'Talk_Post_0009',
                                                onTap: () async {
                                                  Constants.isAPICall = true;
                                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                "something went to wrong",
                                                style: CustomTextStyle.textStyle(
                                                    color: CustomColor.primary, fontWeight: FontWeight.w700, fontSize: 14.sp),
                                              ),
                                              backgroundColor: CustomColor.white,
                                            ));
                                          }
                                        }
                                      },
                                      text: "Comm_Gene_0028".tr())),
                            ],
                          ),
                        ))
                        : const SizedBox()
                  ],
                ),
              ),




              Positioned(
                bottom: 70.h,
                right: 20.w,
                child: (widget.isShowMenu ?? false)
                    ? Container(
                  decoration: BoxDecoration(
                    color: CustomColor.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(15.w),
                  child: InkWell(
                    onTap: widget.onTapMenu,
                    child: SvgPicture.asset(
                      IconPath.menuIcon,
                      color: CustomColor.dark,
                      height: 24.h,
                    ),
                  ),
                )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future<bool> onLikeButtonTapped(bool isLiked) async{
    final userPost = ref.watch(singlePostUserPostProvider);
    if ((widget.isCreatePost ?? false) == false && !ref.read(previewPostNotifier(widget.postId).notifier).isReactionApiCall) {
      ref.read(previewPostNotifier(widget.postId).notifier).isReactionApiCall=true;
      if (userPost?.reactId !=null) {
        await ref.read(previewPostNotifier(widget.postId).notifier).deleteReaction(
            userPost: userPost, context: context, reactionId: userPost?.reactId ??' ');
      } else {
        await ref.read(previewPostNotifier(widget.postId).notifier)
            .createReaction(userPost: userPost, context: context,ref: ref);
      }
    }
    return userPost?.reactId !=null ? true : false;
  }


  Widget commentView({required String commentId}) {
    final userPost = ref.watch(singlePostUserPostProvider);
    commentList = ref.watch(latestCommentNotifier(userPost!.latestComment?.commentId ?? ''));
    return commentList?.length == null
        ? noCommentView()
        : (commentList?.length ?? 0) == 0
        ? noCommentView()
        : InkWell(
      onTap: () {
        showModalBottomSheet(
          useSafeArea: false,
          context: context,
          backgroundColor: CustomColor.black.withOpacity(0.4),
          isDismissible: true,
          isScrollControlled: true,
          builder: (context) => UserPOstCommentBottomSheet(
            postId: widget.postId,
          ),
        ).then((value) {
          if (userPost!.latestComment!=null && userPost!.latestComment?.commentId!=null) {
            ref.read(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).getLatestComment(commentId: userPost.latestComment?.commentId ?? '');
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        margin: EdgeInsets.only(bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      userId: userPost!.userId,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      height: 34.w,
                      width: 34.w,
                      fit: BoxFit.cover,
                      imageUrl: commentList?[0].user?.profile_image ?? '',
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Center(child: Image.asset(IconPath.noProfile)),
                    ),
                  ),
                  wSize(10),
                  Text(
                    commentList?[0].user?.nick_name ?? '',
                    style: CustomTextStyle.textStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            hSize(7),
            Text(
              commentList?[0].description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.3),
            ),
            hSize(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if(isCommentLikeState){
                      isCommentLikeState=false;
                      commentLikeCount--;
                    }else{
                      isCommentLikeState=true;
                      commentLikeCount++;
                    }
                    setState(() {});

                    if(!ref.read(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).isReactionApiCall) {
                      ref.read(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).isReactionApiCall=true;
                      ref.read(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).likeUnlike(comment: commentList?[0], context: context);
                    }

                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconPath.heartFilled,
                        width: 19.w,
                        color: isCommentLikeState ? CustomColor.primary : CustomColor.gray,
                      ),
                      wSize(8),
                      Text(
                        (commentLikeCount).toString(),
                        style: CustomTextStyle.textStyle(
                            fontWeight: FontWeight.w400, fontSize: 12, color: CustomColor.dark),
                      ),
                    ],
                  ),
                ),
                Text(
                  Constants.convertSpecificFormat(date: commentList?[0].created_at ?? '', format: "yyyy.MM.dd"),
                  style: CustomTextStyle.textStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: CustomColor.lightDark),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void buildEditPostBottomSheet(BuildContext context, {required VoidCallback onTapDeletePost, required Function onTapEditPost}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0.h)),
      ),
      builder: (context) => NuuzContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          IconPath.close,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Comm_Gene_0043".tr(),
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.textStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30.h,
                  thickness: 1.h,
                ),
                InkWell(
                  onTap: () => onTapEditPost.call(),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(IconPath.post),
                      ),
                      wSize(8),
                      Text(
                        "Talk_Post_0000".tr(),
                        style: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () => onTapDeletePost.call(),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          IconPath.delete,
                          color: CustomColor.black,
                        ),
                      ),
                      wSize(8),
                      Text(
                        "Talk_Post_0001".tr(),
                        style: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 17.h,
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: CustomColor.white,
                              border: Border.all(color: CustomColor.black)),
                          child: Text(
                            "Comm_Gene_0013".tr(),
                            style: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget noCommentView() {
    final userPost = ref.watch(singlePostUserPostProvider);
    return DottedBorder(
      color: CustomColor.gray,
      radius: const Radius.circular(14),
      strokeWidth: 2.w,
      strokeCap: StrokeCap.round,
      dashPattern: [3.w, 6.w],
      borderType: BorderType.RRect,
      child: InkWell(
        onTap: (){


          showModalBottomSheet(useSafeArea: false,
            context: context,
            backgroundColor: CustomColor.black.withOpacity(0.4),
            isDismissible: true,
            isScrollControlled: true,
            builder: (context) => UserPOstCommentBottomSheet(
              postId: widget.postId,
            ),
          ).then((value) {
            if (userPost?.latestComment!=null && userPost!.latestComment?.commentId!=null) {
              ref.watch(latestCommentNotifier(userPost!.latestComment?.commentId ?? '').notifier).getLatestComment(commentId: userPost.latestComment?.commentId ?? '');
            }
          });
        },
        child: Container(
          height: 130.h,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  IconPath.noCommentIcon,
                  height: 90.h,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 20.w,
                right: 20.w,
                child: Center(
                  child: Text(
                    'Talk_Post_0016'.tr(),
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.textStyle(
                        fontWeight: FontWeight.w700, fontSize: 15, color: CustomColor.lightDark, height: 1.4),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showUserProductProgram() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.programs.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0039".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...widget.programs
              .map(
                (e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: NuuzContainer(
                child: CareProgramListItem(
                  name: e.name,
                  description: e.description,
                  imageUrl: e.image,
                ),
              ),
            ),
          )
              .toList(),
        ],
        if (widget.reviews.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0040".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...widget.reviews
              .map(
                (e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: NuuzContainer(
                child: CareProgramListItem(
                  name: e.program!.care_program_name!,
                  description: e.program!.description,
                  imageUrl: e.result_image,
                ),
              ),
            ),
          )
              .toList()
        ],
        if (widget.products.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0011".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...widget.products.map((e) => productsItem(e)).toList(),
        ],
      ],
    );
  }

  Widget showUserProductProgramReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (programs.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0039".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...programs
              .map(
                (e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: NuuzContainer(
                child: CareProgramListItem(
                  name: e.name,
                  description: e.description,
                  imageUrl: e.image,
                ),
              ),
            ),
          )
              .toList(),
        ],
        if (reviews.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0040".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...reviews
              .map(
                (e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: NuuzContainer(
                child: CareProgramListItem(
                  name: e.program!.care_program_name!,
                  description: e.program!.description,
                  imageUrl: e.result_image,
                ),
              ),
            ),
          )
              .toList()
        ],
        if (products.isNotEmpty ?? false) ...[
          hSize(12),
          Text(
            "Comm_Gene_0011".tr(),
            style: CustomTextStyle.headerS,
          ),
          hSize(12),
          ...products.map((e) => productsItem(e)).toList(),
        ],
      ],
    );
  }
}







final singlePostUserPostProvider = StateNotifierProvider<SinglePostUserPostProvider, UserPost?>((ref) {
  return SinglePostUserPostProvider();
});

class SinglePostUserPostProvider extends StateNotifier<UserPost?> {
  SinglePostUserPostProvider() : super(null);

  UserPostRepository userPostRepository = UserPostRepository();

  setSingleUserPost(String? postId) async {
    ///포스트 아이디로 유저포스트 세팅해야함
    if(postId!=null){
      state = await userPostRepository.getUserPost(postId);
    }

  }

}