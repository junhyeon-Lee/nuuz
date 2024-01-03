import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/comment/comment_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> updateCommentBottomSheet({required BuildContext context,required String commentId,required String comment,required String postId}) async {
  TextEditingController editingController=TextEditingController(text: comment);

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Text(
                      'Talk_Comm_0002'.tr(),
                      style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xffebeae9),
                  ),
                  hSize(30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: CustomColor.darkWhite),
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: TextField(
                        controller: editingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: "Talk_Comm_0000".tr()),
                      ),
                    ),
                  ),
                  hSize(58),
                  Padding(
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
                            title: 'Update',
                            onTap: () async {

                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                CommentSuccessModel? value = await UserPostRepository().updateComments(context:context,  commentId:commentId,comment:editingController.text);

                                if(value.status ?? false){
                                  context.pop();
                                  context.pop();
                                  ref.watch(getCommentNotifier.notifier).getComment(postId: postId);
                                }
                              });

                            },
                            horizontalPadding: 0,
                            bgColor: CustomColor.primary,
                            borderColor: CustomColor.primary,
                            textColor: CustomColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hSize(28)
                ],
              ),
            );
          },
        );
      });
}
