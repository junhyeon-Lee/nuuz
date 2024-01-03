import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class SimpleAppbar extends AppBar implements PreferredSizeWidget {
  SimpleAppbar({super.key, required BuildContext context, required String title, bool? isHelp})
      : super(
          title: Text(title, style: CustomTextStyle.headerL),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset(IconPath.appbarBack)),
          actions: [
            Visibility(
              visible: isHelp ?? false,
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainer(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.w,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        hSize(20.h),
                                        Row(
                                          children: [
                                            Text(
                                              'Prod_Poin_0020'.tr(),
                                              style: CustomTextStyle.headerS,
                                            ),
                                          ],
                                        ),
                                        hSize(20.h),
                                        Text(
                                          '${'Prod_Poin_0021'.tr()}\n${'Prod_Poin_0022'.tr()}\n${'Prod_Poin_0023'.tr()}\n${'Prod_Poin_0024'.tr()}\n'
                                          '${'Prod_Poin_0025'.tr()}\n${'Prod_Poin_0026'.tr()}\n${'Prod_Poin_0027'.tr()}\n${'Prod_Poin_0028'.tr()}',
                                          style: CustomTextStyle.descriptionM,
                                        ),
                                        hSize(25),
                                        GestureDetector(
                                          onTap: () {
                                            context.pop();
                                          },
                                          child: CustomContainer(
                                            width: double.infinity,
                                            height: 46.h,
                                            containerColor: CustomColor.primary,
                                            child: Center(
                                              child: Text(
                                                'Comm_Gene_0034'.tr(),
                                                style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        hSize(30.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: CustomContainer(
                      width: 20.w,
                      height: 20.w,
                      containerColor: CustomColor.background,
                      borderColor: CustomColor.dark,
                      child: Center(
                          child: Text(
                        'i',
                        style: CustomTextStyle.descriptionS,
                      )),
                    ),
                  ),
                  wSize(20.w)
                ],
              ),
            )
          ],
          centerTitle: true,
        );

  @override
  Size get preferredSize => Size.fromHeight(Platform.isAndroid ? 58.h : 44.h);
// Size get preferredSize =>   Size.fromHeight(44.h);
}
