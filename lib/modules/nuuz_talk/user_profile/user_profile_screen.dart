import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/edit_profile.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/nuuz_talk/comment/commets_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/friends_provider.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/friends_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/report/report_bottomsheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/toast_helper.dart';

import '../providers/user_profile/user_profile_provider.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  UserData? userData;
  UserData? profileData;
  List<ConnectionList>? followingList;
  List<ConnectionList>? followerList;
  List<UserPost>? postList;
  List<UserComment>? commentList;
  bool isCurrentUser = false;
  bool isWithdrawUser = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocalDB localDB = LocalDB();
      userData = await localDB.findUserInfo();

      if (widget.userId == userData?.user_id) {
        isCurrentUser = true;
      }
      await ref.watch(profileNotifier(widget.userId).notifier).getUserProfile(userId: widget.userId);
      ref.watch(followingNotifier(widget.userId).notifier).getUserConnection(userId: widget.userId, isFollower: false);
      ref.watch(followerNotifier(widget.userId).notifier).getUserConnection(userId: widget.userId, isFollower: true);
      ref.watch(userProfileCommentNotifier(widget.userId).notifier).getComment(userId: widget.userId);
      ref.watch(userProfilePostNotifier(widget.userId).notifier).getPosts(userId: widget.userId);
      ref
          .watch(followUnfollowNotifier(widget.userId).notifier)
          .getUserConnection(currentUserId: userData?.user_id ?? '', userId: widget.userId);

      UserData? data = ref.watch(profileNotifier(widget.userId));
      if (data == null) {
        isWithdrawUser = true;
      } else {
        isWithdrawUser = false;
      }
    });
  }

  @override
  void dispose() {
    // ref.invalidate(followingNotifier(widget.userId));
    ref.exists(followingNotifier(widget.userId));
    // ref.invalidate(followerNotifier(widget.userId));
    ref.exists(followerNotifier(widget.userId));
    // ref.invalidate(userProfileCommentNotifier(widget.userId));
    ref.exists(userProfileCommentNotifier(widget.userId));
    // ref.invalidate(userProfilePostNotifier(widget.userId));
    ref.exists(userProfilePostNotifier(widget.userId));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    profileData = ref.watch(profileNotifier(widget.userId));
    followerList = ref.watch(followerNotifier(widget.userId));
    followingList = ref.watch(followingNotifier(widget.userId));
    postList = ref.watch(userProfilePostNotifier(widget.userId));
    commentList = ref.watch(userProfileCommentNotifier(widget.userId));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColor.background,
      ),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomAppBar(
                  title: isWithdrawUser ? 'Talk_Prof_0007' : profileData?.nick_name ?? '',
                  fontSize: 22.sp,
                  horizontalPadding: 0,
                  onTap: () {
                    context.pop();
                  },
                  isWithdrawUser: false,
                  iconPath: IconPath.leftBackIcon,
                  rightIconPath: isCurrentUser ? null : IconPath.report,
                  rightIconOnTap: isCurrentUser
                      ? () {}
                      : () {
                          if (!isWithdrawUser) {
                            showReport(context: context, isUserReport: true, userId: widget.userId, isPostReport: false);
                          }
                        },
                ),
                hSize(6),
                profileView(),
                hSize(12),
                tapBar(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        postView(),
                        commentView(),
                      ],
                    ),
                  ),
                ),
                hSize(5)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileView() {
    bool isFollow = ref.watch(followUnfollowNotifier(widget.userId));
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.only(top: 48.h),
          padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 18.w, top: 58.h),
          child: Column(
            children: [
              profileData?.introduction==null?
             Container():Text(
                profileData!.introduction=='pending'?"":
                profileData!.introduction!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark, height: 1.25),
              ),
              hSize(25),
              Row(
                children: [
                  followerFollowingView(
                      title: 'Talk_Prof_0000',
                      onTap: () {
                        if (!isWithdrawUser) {
                          ref.invalidate(followerNotifier(widget.userId));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FriendsScreen(
                                userId: widget.userId,
                                selectedIndex: 0,
                              ),
                            ),
                          );
                        }
                      },
                      count: followerList?.length ?? 0),
                  wSize(12),
                  followerFollowingView(
                      title: 'Talk_Prof_0001',
                      onTap: () {
                        if (!isWithdrawUser) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FriendsScreen(
                                userId: widget.userId,
                                selectedIndex: 1,
                              ),
                            ),
                          );
                        }
                      },
                      count: followingList?.length ?? 0),
                ],
              ),
              SizedBox(
                height: 18.w,
              ),
              isCurrentUser
                  ? followButton(
                      title: 'Talk_Prof_0010',
                      icon: IconPath.editNote,
                      isFollow: false,
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        )
                            .then((value) {
                          if (ref.watch(editProfileNotifier.notifier).isSuccess) {
                            ref.watch(profileNotifier(widget.userId).notifier).getUserProfile(userId: widget.userId);
                          }
                        });
                      })
                  : followButton(
                      title: isFollow ? 'Talk_Prof_0003' : 'Talk_Prof_0002',
                      icon: isFollow ? IconPath.unFollowIcon : IconPath.followIcon,
                      isFollow: isFollow,
                      onTap: () {
                        ref
                            .watch(followUnfollowNotifier(widget.userId).notifier)
                            .connectionUpdate(userId: widget.userId, isFollow: !isFollow, context: context, ref: ref);
                      })

              /* widget.isCurrentUser
                  ? followButton(title: 'Talk_Prof_0010', icon: IconPath.editNote, isFollow: true)
                  : followButton(title: 'Talk_Prof_0002', icon: IconPath.followIcon, isFollow: true),*/
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 98.h,
            width: 98.h,
            decoration: BoxDecoration(
              color: CustomColor.white,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: isWithdrawUser
                  ? Container(
                      color: const Color(0xffd9d9d9),
                    )
                  : CachedNetworkImage(
                      imageUrl: profileData?.profile_image ?? '',
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Center(child: Image.asset(IconPath.noProfile)),
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        )
      ],
    );
  }

  Widget followerFollowingView({required String title, required VoidCallback onTap, required int count}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: CustomColor.lightWhite,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(width: 0.8, color: CustomColor.gray),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark, height: 1.5),
              ),
              Text(
                isWithdrawUser ? '-' : Constants.numberCounter(count.toString()),
                textAlign: TextAlign.center,
                style:
                    CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 22, color: CustomColor.primary, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget followButton({required bool isFollow, required String icon, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: isWithdrawUser ? null : onTap,
      child: Container(
        height: 47.h,
        decoration: BoxDecoration(
          color: isFollow
              ? CustomColor.lightDark
              : isWithdrawUser
                  ? CustomColor.primary.withOpacity(0.42)
                  : CustomColor.primary,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 25.h,
              color: CustomColor.white,
            ),
            wSize(9),
            Text(
              title.tr(),
              style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 16, color: CustomColor.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget tapBar() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        isScrollable: false,
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: CustomColor.primary,
        indicatorColor: CustomColor.primary,
        unselectedLabelColor: CustomColor.dark,
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 0),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        tabs: [
          Text(
            'Comm_Gene_0045'.tr(),
          ),
          Text(
            'Comm_Gene_0042'.tr(),
          ),
        ],
      ),
    );
  }

  Widget postView() {
    return isWithdrawUser
        ? noViewFound(title: 'Talk_Prof_0006', icon: IconPath.privateViewIcon)
        : profileData?.privacy_settings?.posts == Constants.private && !isCurrentUser
            ? noViewFound(title: 'Talk_Prof_0004', icon: IconPath.privateViewIcon)
            : postList?.length == null
                ? const Center(
                    child: CustomIndicator(''),
                  )
                : postList!.isEmpty
                    ? noViewFound(title: 'Talk_Prof_0008', icon: IconPath.noPostIcon)
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (380.w - 20.w) / 5 / 104.h,
                            crossAxisSpacing: 15.h,
                            mainAxisSpacing: 18.h),
                        itemCount: postList?.length ?? 0,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () async {
                              await ref.watch(commentLengthProvider.notifier).setCommentLength(postList![i].commentsCount);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewPostScreen(
                                        isEditingPost: false,
                                        userPost: postList![i],
                                        reviews: const [],
                                        programs: const [],
                                        products: const [],
                                        userImage: "",
                                        isCreatePost: false,
                                        isShowProducts: true,
                                        postId: postList?[i].postId ?? ''),
                                  )).then((value) {
                                if (value != null) {
                                  UserPost userPost = value;
                                  postList![i] =
                                      postList![i].copyWith(isLiked: userPost.isLiked, likesCount: userPost.likesCount, reactId: userPost.reactId);
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
                                      child: (postList?[i].imageUrls.length ?? 0) > 0
                                          ? CachedNetworkImage(
                                              imageUrl: postList?[i].imageUrls[0] ?? '',
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                              errorWidget: (context, url, error) => Image.asset(
                                                Constants.getImageFromCategory(categoryId: postList?[i].category.id ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              Constants.getImageFromCategory(categoryId: postList?[i].category.id ?? ''),
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
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl: postList?[i].user?.profile_image ?? '',
                                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                  errorWidget: (context, url, error) =>
                                                      Center(child: Image.asset(IconPath.noProfile)),
                                                  width: 18,
                                                  height: 18,
                                                ),
                                              ),
                                              wSize(8),
                                              Expanded(
                                                child: Text(
                                                  '${postList?[i].name}',
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
                                                  if (!ref
                                                      .watch(userProfilePostNotifier(widget.userId).notifier)
                                                      .isCallReactAPI) {
                                                    ref.watch(userProfilePostNotifier(widget.userId).notifier).isCallReactAPI =
                                                        true;
                                                    if (postList?[i].reactId !=null) {
                                                      await ref
                                                          .watch(userProfilePostNotifier(widget.userId).notifier)
                                                          .deleteReaction(context: context, userPost: postList![i], index: i);
                                                    } else {
                                                      await ref
                                                          .watch(userProfilePostNotifier(widget.userId).notifier)
                                                          .createReaction(context: context, userPost: postList![i], index: i,ref: ref);
                                                    }
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    postList?[i].reactId !=null
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
                                                      (postList?[i].likesCount).toString(),
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
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(80),topLeft: Radius.circular(80)),
                                                    ),
                                                    isDismissible: true,
                                                    isScrollControlled: true,
                                                    builder: (context) => UserPOstCommentBottomSheet(
                                                      postId: postList?[i].postId ?? '',
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
                                                      (postList?[i].commentsCount ?? 0).toString(),
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
                                                      categoryId: (postList?[i].category.id ?? '')),
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: Text(
                                                (postList?[i].category.name.toString() ?? '').tr(),
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
                                                (postList?[i].title ?? '').toString(),
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
                            ),
                          );
                        },
                      );
  }

  Widget commentView() {
    return isWithdrawUser
        ? noViewFound(title: 'Talk_Prof_0006', icon: IconPath.privateViewIcon)
        : profileData?.privacy_settings?.comments == Constants.private && !isCurrentUser
            ? noViewFound(title: 'Talk_Prof_0005', icon: IconPath.privateViewIcon)
            : commentList?.length == null
                ? const Center(
                    child: CustomIndicator(''),
                  )
                : commentList!.isEmpty
                    ? noViewFound(title: 'Talk_Prof_0009', icon: IconPath.noPostIcon)
                    :
    Container(
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () async {
                                List<UserPost> posts = await ref
                                    .watch(userProfileCommentNotifier(widget.userId).notifier)
                                    .getPosts(postId: commentList?[i].post_id ?? '',userId: commentList?[i].user_id ?? '', context: context);

                                await ref.watch(trendItemProvider.notifier).getTrendItemData(commentList![i].post_id!);

                                if (posts.isNotEmpty) {
                                  try{
                                    await ref.watch(commentLengthProvider.notifier).setCommentLength(ref.watch(trendItemProvider)!.commentsCount);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>PreviewPostScreen(
                                                isEditingPost: (userData?.user_id == ref.watch(trendItemProvider)!.userId),
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
                                  }catch(e){
                                    AppToast.showSnackBar(message: 'Talk_Post_0017'.tr(), context: context);
                                  }
                                } else {
                                  AppToast.showSnackBar(message: 'Talk_Post_0017'.tr(), context: context);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commentList?[i].categoryId != null
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: Constants.getColorFromCategory(
                                                        categoryId: commentList?[i].categoryId ?? ''),
                                                    borderRadius: BorderRadius.circular(50)),
                                                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
                                                child: Text(
                                                  (commentList?[i].categoryName ?? '').tr(),
                                                  style: CustomTextStyle.textStyle(
                                                      fontWeight: FontWeight.w400, fontSize: 12, color: CustomColor.white),
                                                ),
                                              )
                                            : const SizedBox(),
                                        Text(
                                          Constants.convertSpecificFormat(date: commentList?[i].created_at, format: 'yyyy.MM.dd'),
                                          style: CustomTextStyle.textStyle(
                                              fontWeight: FontWeight.w400, fontSize: 12, color: CustomColor.lightDark),
                                        ),
                                      ],
                                    ),
                                    hSize(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 30,
                                                  child: Text(
                                                    commentList?[i].description ?? '',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: CustomTextStyle.textStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: CustomColor.dark,
                                                        height: 1.3),
                                                  )),
                                              hSize(16),
                                              InkWell(
                                                onTap: () {
                                                  if(!ref.watch(userProfileCommentNotifier(widget.userId).notifier).isCallReactAPI) {
                                                    ref.watch(userProfileCommentNotifier(widget.userId).notifier).isCallReactAPI=true;
                                                    ref.watch(userProfileCommentNotifier(widget.userId).notifier).likeUnlike(
                                                      position: i,
                                                      comment: commentList![i],
                                                      context: context,
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      IconPath.heartFilled,
                                                      width: 18.w,
                                                      color: commentList?[i].reactId != null
                                                          ? CustomColor.primary
                                                          : CustomColor.gray,
                                                    ),
                                                    wSize(8),
                                                    Text(
                                                      (commentList?[i].reactions ?? 0).toString(),
                                                      style: CustomTextStyle.textStyle(
                                                          fontWeight: FontWeight.w400, fontSize: 12, color: CustomColor.dark),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        (commentList?[i].postImage ?? '').isEmpty
                                            ? SizedBox()
                                            : ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  imageUrl: commentList?[i].postImage ?? '',
                                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                                  fit: BoxFit.fill,
                                                  height: 74.w,
                                                  width: 72.w,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) {
                            return Container(
                              height: 1.h,
                              color: CustomColor.grayLine,
                              margin: EdgeInsets.only(bottom: 18.h, top: 11.h),
                            );
                          },
                          itemCount: commentList?.length ?? 0,
                        ),
                      );



    /*   print('-----====----->${commentList?.length}');
    return commentList == null ? const Center(
      child: CustomIndicator(''),
    ) : commentList.length ==0 ? const NotFoundView(title: 'There is Comment not found',) : Container(
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,i){
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Constants.getColorFromCategory(categoryId: '111'),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 6.h),
                      child: Text('Question',style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400,fontSize: 12,color: CustomColor.white),),
                    ),

                    Text( Constants.convertSpecificFormat(date: commentList[i].created_at),style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400,fontSize: 12,color: CustomColor.lightDark),),
                  ],
                ),

                hSize(5),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(commentList[i].description ?? '',maxLines: 2,overflow: TextOverflow.ellipsis,style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400,fontSize: 14,color: CustomColor.dark,height: 1.3),),
                          hSize(16),
                          Row(
                            children: [
                              SvgPicture.asset(IconPath.heartFilled,width: 18.w, color: commentList[i].is_liked==Constants.isLiked ? CustomColor.primary : CustomColor.gray,),
                              wSize(8),
                              Text((commentList[i].reactions ?? 0).toString(),style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400,fontSize: 12,color: CustomColor.dark),),
                            ],
                          ),

                        ],
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg",
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        fit: BoxFit.fill,
                        height: 74.w,
                        width: 72.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
      }, separatorBuilder: (context,i){
        return Container(
          height: 1.h,
          color: CustomColor.grayLine,
          margin: EdgeInsets.only(bottom: 18.h,top: 11.h),
        );
      }, itemCount: commentList.length,),
    );*/
  }

  Widget noViewFound({required String title, required String icon}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 18.w),
          margin: EdgeInsets.symmetric(vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 65.h,
                height: 65.h,
              ),
              hSize(10),
              Text(
                title.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CustomColor.lightDark),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool get wantKeepAlive => true;
}
