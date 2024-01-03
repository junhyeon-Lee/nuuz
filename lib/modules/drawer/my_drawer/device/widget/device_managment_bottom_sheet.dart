
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/widget/delete_management_bottom_sheet.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import 'device_item_view.dart';

Future<void> deviceManagementBottomSheet({
  required BuildContext context,
  VoidCallback? onTapUse,Function,
  Function(bool data)? isDeleted,
  var product,

}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
                child: Stack(alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: product.product.imageUrl[0] ?? '',
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                height: 100.w,
                                width: 100.w,fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    CachedNetworkImage(
                                      imageUrl: product.product.imageUrl[1] ?? '',
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                      height: 46.h,
                                      width: 200.w,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    SizedBox(width: 200.w,
                                      child: Text(
                                        product.product.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.descriptionL,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                       if(product.product_code!=null)
                       hSize(12),
                        if(product.product_code!=null)
                       CustomContainer(
                         width: double.infinity,
                         radius: 12,
                         borderColor: CustomColor.primary,
                         child: Padding(
                           padding: EdgeInsets.fromLTRB(12.w,8.h,12.w,8.h),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   SvgPicture.asset(IconPath.event,color: CustomColor.primary,),
                                   wSize(6),
                                   Text(
                                     product.product_code.substring(0, 4) + "-" + product.product_code.substring(4, 8) + "-" + product.product_code.substring(8, product.product_code.length)
                                     ,style: CustomTextStyle.headerM.copyWith(color: CustomColor.primary),),
                                 ],
                               ),
                               Text(product.created_at.toString().substring(0,10),style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.lightDark),)
                             ],
                           ),
                         ),
                       )
                      ],
                    ),



                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              child: Container(color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.5.h),
                      child: Text('Devi_Mana_0000'.tr(), style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700,fontSize: 21,color: CustomColor.dark),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      width: double.infinity, height: 1,
                      color: const Color(0xffebeae9),
                    ),
                    hSize(26),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // managementButton(IconPath.information,'Devi_Mana_0001',(){},false),
                          managementButton(IconPath.productcode,'Devi_Regi_0009',(){},true),
                          managementButton(IconPath.use,'Devi_Mana_0002',onTapUse!,false),
                          managementButton(IconPath.delete,'Comm_Gene_0017',(){
                            context.pop();
                            deleteManagementBottomSheet(context: context,isDeleteButton: true,isDeleted:isDeleted );
                          },false),
                        ],),
                    ),
                    // hSize(24),
                    // Row(
                    //   children: [
                    //     wSize(30),
                    //
                    //   ],
                    // ),
                    hSize(32),
                    CustomButton(horizontalPadding :44.w,title: 'Comm_Gene_0006',onTap: (){
                      safePrint('탭');
                      context.pop();
                    },borderRadius: 14.w,),
                    hSize(28)
                  ],
                ),
              ),
            ),

          ],
        );
      });
}


Widget managementButton(String icon, String title,VoidCallback onTap,bool isDisable){
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 92.w,
      height: 92.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 64.w, height: 64.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(IconPath.customSquare, color: CustomColor.lightGray),
                SvgPicture.asset(icon,color: isDisable?CustomColor.lightDark.withOpacity(0.5):null,),
              ],
            ),
          ),
          Text(title.tr(),style: CustomTextStyle.descriptionM.copyWith(
color:
              isDisable?CustomColor.lightDark.withOpacity(0.5):null
          ),)
        ],
      ),
    ),
  );
}