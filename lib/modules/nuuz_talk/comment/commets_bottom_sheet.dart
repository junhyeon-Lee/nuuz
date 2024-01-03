import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/nuuz_talk/comment/update_comment_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/comment/comment_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/user_profile_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/not_found_view.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/report/report_bottomsheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';

import '../providers/latest_comment/latest_comment_provider.dart';

class UserPOstCommentBottomSheet extends ConsumerStatefulWidget {
  UserPOstCommentBottomSheet({Key? key, required this.postId}) : super(key: key);

  String postId;

  @override
  ConsumerState<UserPOstCommentBottomSheet> createState() => _UserPOstCommentBottomSheetState();
}

class _UserPOstCommentBottomSheetState extends ConsumerState<UserPOstCommentBottomSheet> {
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();
  UserData? user;
  bool isEditComment=false;
  String editCommentId='';
  final focus = FocusNode();
  double inputPadding = 27.h;
  double intputOutsidePadding = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(getCommentNotifier.notifier).getComment(postId: widget.postId);
      final commentList = ref.watch(getCommentNotifier);
      safePrint('코멘트 리스트');
      safePrint(commentList);
      if(commentList!=null){
        for(int i=0; i<commentList.length; i++){
          isCommentLikeState.add(commentList?[0].is_liked == Constants.isLiked?true:false);
          commentLikeCount.add(commentList[i].reactions??0);
        }
        safePrint('리스트');
        safePrint(isCommentLikeState);
        safePrint(commentLikeCount);
      }

      ref.watch(getCommentNotifier.notifier).getComment(postId: widget.postId);
      LocalDB localDB = LocalDB();
      user = await localDB.findUserInfo();
      scrollDown();
    });
    super.initState();
  }

  List<bool> isCommentLikeState=[];
  List<int> commentLikeCount=[];

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }



  @override
  void dispose() {
    ref.invalidate(getCommentNotifier);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final commentList = ref.watch(getCommentNotifier);
    if (commentList?.length != null) {
      scrollDown();
    }
    return SafeArea(
      child: Column(
        children: [
          hSize(70),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: NuuzContainer(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    IconPath.close,
                                    height: 25.h,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Comm_Gene_0042'.tr(),
                                      style: CustomTextStyle.headerM,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 25.h,
                                )
                              ],
                            ),
                            hSize(16),
                            const Divider(
                              height: 1,
                            ),
                            Expanded(
                              child: commentList == null
                                  ? const Center(
                                child: CustomIndicator(''),
                              )
                                  : commentList.length == 0
                                  ? const NotFoundView(
                                title: '작성된 댓글이 없습니다.',
                              )
                                  : ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  controller: scrollController,
                                  padding: EdgeInsets.only(bottom: 104.w),
                                  itemCount: commentList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        hSize(10),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => UserProfileScreen(
                                                      userId: commentList[index].user?.user_id ?? '',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(40),
                                                    child: CachedNetworkImage(
                                                      height: 38,
                                                      width: 38,
                                                      imageUrl: commentList[index].user?.profile_image ?? '',
                                                      placeholder: (context, url) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) =>
                                                          Center(child: Image.asset(IconPath.noProfile)),
                                                    ),
                                                  ),
                                                  wSize(15),
                                                  Text(
                                                    commentList[index].user?.nick_name ?? '',
                                                    style: CustomTextStyle.headerM,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              Constants.convertSpecificFormat(date: commentList[index].created_at,format: 'yyyy.MM.dd'),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                buildEditPostBottomSheet(
                                                  context1: context,
                                                  comment: commentList[index].description,
                                                  isCurrentUser: user?.user_id == commentList[index].user?.user_id ? true : false,
                                                  commentId: commentList[index].comment_id ?? '',
                                                  userId: commentList[index].user_id ?? '',
                                                  currentUserId: user?.user_id ?? '',
                                                );
                                              },
                                              child: Icon(
                                                Icons.more_vert,
                                                color: CustomColor.gray,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          commentList[index].description ?? '',
                                          style: TextStyle(fontSize: 14.sp, color: CustomColor.black),
                                        ),
                                        hSize(10),
                                        InkWell(
                                          onTap: () {

                                            if(isCommentLikeState[index]){
                                              isCommentLikeState[index]=false;
                                              commentLikeCount[index]--;
                                            }else{
                                              isCommentLikeState[index]=true;
                                              commentLikeCount[index]++;
                                            }
                                            setState(() {});

                                            if(!ref.watch(getCommentNotifier.notifier).isCallReactAPI) {
                                              ref.watch(getCommentNotifier.notifier).isCallReactAPI=true;
                                              ref.watch(getCommentNotifier.notifier).likeUnlike(
                                                  position: index,
                                                  comment: commentList[index],
                                                  context: context,
                                                  postId: widget.postId);
                                            }


                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                IconPath.heartFilled,
                                                color: isCommentLikeState[index]??false
                                                    ? CustomColor.primary
                                                    : CustomColor.gray,
                                                height: 18.h,
                                              ),
                                              wSize(5),
                                              Text(
                                                (commentLikeCount[index]??0).toString(),
                                                style: TextStyle(color: Colors.black, fontSize: 12.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                        hSize(2),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container( color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(35.w,35.h,35.w,35.w),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: CustomColor.darkWhite),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          child: Focus(
                            child: TextField(
                              controller: commentController,
                              focusNode: focus,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      WidgetsBinding.instance.addPostFrameCallback((_) async {

                                        if(isEditComment) {

                                          CommentSuccessModel? value = await UserPostRepository().updateComments(context:context,  commentId:editCommentId,comment:commentController.text);

                                          if(value.status ?? false){
                                            ref.watch(getCommentNotifier.notifier).getComment(postId: widget.postId);
                                            commentController.text = '';
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            isEditComment=false;
                                          }

                                        }else {
                                          isCommentLikeState.add(false);
                                          commentLikeCount.add(0);
                                          ref
                                              .watch(addCommentNotifier.notifier)
                                              .addComment(
                                              postId: widget.postId, description: commentController.text.toString(), context: context)
                                              .then((value) async {
                                            ref.watch(getCommentNotifier.notifier).getComment(postId: widget.postId);
                                            await ref.watch(singlePostUserPostProvider.notifier).setSingleUserPost(widget.postId);
                                            final userPost = ref.watch(singlePostUserPostProvider);
                                            ref.read(latestCommentNotifier(userPost?.latestComment?.commentId ?? '').notifier).getLatestComment(commentId: userPost?.latestComment?.commentId ?? '');
                                            commentController.text = '';
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          });
                                          ref.watch(commentLengthProvider.notifier).increaseCommentLength();
                                        }



                                      });
                                    },
                                    child: SvgPicture.asset(
                                      IconPath.send,
                                      height: 5,
                                      width: 5,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: "Talk_Comm_0000".tr()),
                            ),
                            onFocusChange: (hasFocus) {
                              if(hasFocus) {
                                setState(() {
                                  intputOutsidePadding=500.h;
                                });
                                safePrint('포커스 변경');
                                safePrint(intputOutsidePadding);
                                setState(() {

                                });
                              }else{
                                safePrint('포커스 끄기');
                                setState(() {
                                  intputOutsidePadding=0.h;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                  ///댓글 입력창
                  ,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buildEditPostBottomSheet(
      {required BuildContext context1,
      required String commentId,
      required bool isCurrentUser,
      String? comment,
      required String userId,
      required String currentUserId}) {
    showModalBottomSheet(
      context: context1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0.h)),
      ),
      builder: (context) => NuuzContainer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        IconPath.close,
                        height: 25.h,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Comm_Gene_0043".tr(),
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 40.h,
                  thickness: 1.h,
                ),
                Visibility(
                  visible: !isCurrentUser,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                userId: userId,
                                //isCurrentUser: currentUserId == userId ? true : false,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              alignment: Alignment.center,
                              child: Image.asset(
                                IconPath.userProfile,
                                width: 24.w,
                              ),
                            ),
                            wSize(5),
                            Text(
                              "Comm_Gene_0044".tr(),
                              style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 15, color: CustomColor.dark),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          showReport(
                              isUserReport:false, isPostReport:false,
                              commentId: commentId, context: context, postId: widget.postId);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                IconPath.report,
                                color: CustomColor.black,
                              ),
                            ),
                            wSize(5),
                            Text(
                              "Talk_Comm_0001".tr(),
                              style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 15, color: CustomColor.dark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isCurrentUser,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          /* updateCommentBottomSheet(
                          context: context, commentId: commentId, comment: comment ?? '', postId: widget.postId);*/

                          isEditComment=true;
                          editCommentId=commentId;
                          commentController.text=comment ?? '';
                          context.pop();
                          FocusScope.of(context1).requestFocus(focus);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(IconPath.editNote),
                            ),
                            wSize(5),
                            Text(
                              "Talk_Comm_0002".tr(),
                              style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 15, color: CustomColor.dark),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          deleteCommentBottomSheet(context: context, isDeleteButton: true, commentId: commentId);
                          ref.watch(commentLengthProvider.notifier).decreaseCommentLength();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                IconPath.trash,
                                color: CustomColor.black,
                              ),
                            ),
                            wSize(5),
                            Text(
                              "Talk_Comm_0003".tr(),
                              style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 15, color: CustomColor.dark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: CustomColor.white,
                              border: Border.all(color: CustomColor.black)),
                          child: Text(
                            "Comm_Gene_0013".tr(),
                            style: CustomTextStyle.textStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CustomColor.dark),
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

  Future<void> deleteCommentBottomSheet(
      {required BuildContext context, bool? isDeleteButton, Function(bool data)? isDeleted, String? commentId}) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13.5.h),
                child: Text(
                  'Comm_Gene_0052'.tr(),
                  style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: double.infinity,
                height: 1,
                color: const Color(0xffebeae9),
              ),
              hSize(19),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  (isDeleteButton ?? false) ? 'Talk_Comm_0004'.tr() : 'Talk_Comm_0005'.tr(),
                  textAlign: TextAlign.center,
                  style:
                  CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark, height: 1.4),
                ),
              ),
              hSize(58),
              (isDeleteButton ?? false)
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 72.w),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        horizontalPadding: 0,
                        title: 'Comm_Gene_0006',
                        onTap: () {
                          context.pop();
                        },
                      ),
                    ),
                    wSize(17),
                    Expanded(
                      child: CustomButton(
                        title: 'Comm_Gene_0017',
                        onTap: () async {
                          LocalDB localDB = LocalDB();
                          LoginResponse? loginResponse = await localDB.findAuthInfo();

                          CommentSuccessModel? value = await UserPostRepository().deleteComments(
                              token: loginResponse?.accessToken ?? '', commentId: commentId ?? '', context: context);
                          if (value.status ?? false) {
                            context.pop();
                            context.pop();
                            deleteCommentBottomSheet(context: context, isDeleteButton: false);
                          }
                        },
                        horizontalPadding: 0,
                        bgColor: CustomColor.primary,
                        borderColor: CustomColor.primary,
                        textColor: CustomColor.white,
                      ),
                    ),
                  ],
                ),
              )
                  : CustomButton(
                horizontalPadding: 44.w,
                title: 'Comm_Gene_0034',
                onTap: () {
                  context.pop();
                },
                bgColor: CustomColor.primary,
                borderColor: CustomColor.primary,
                textColor: CustomColor.white,
              ),
              hSize(28)
            ],
          );
        }).then((value) {
      if ((isDeleted ?? false) == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          ref.watch(getCommentNotifier.notifier).getComment(postId: widget.postId);
          scrollDown();
        });
      }
    });
  }

  bool get wantKeepAlive => true;
}