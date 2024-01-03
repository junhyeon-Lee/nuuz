
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/bottom_sheet/complete_bottom_sheet.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/constants.dart';



Future<void> deletePostBottomSheet({required BuildContext context, required String postId}) async {
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
                'Talk_Post_0008'.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark,height: 1.4),
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
                      title: 'Comm_Gene_0017',
                      onTap: () async {
                        LocalDB localDB = LocalDB();
                        LoginResponse? loginResponse = await localDB.findAuthInfo();

                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                          bool? value = await UserPostRepository()
                              .deleteUserPost(token: loginResponse!.accessToken, postId: postId,context: context);
                          if(value?? false){
                            completeBottomSheet(context: context, description: 'Talk_Post_0009', onTap: (){
                              Constants.isAPICall=true;
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },);
                          }
                        });

                      },
                      horizontalPadding: 0,
                      bgColor: CustomColor.primary,
                      borderColor: CustomColor.primary,
                      textColor: CustomColor.white,
                    ),),
                ],
              ),
            ),
            hSize(28)
          ],
        );
      });

}

