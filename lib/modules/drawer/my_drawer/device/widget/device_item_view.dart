import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/models/my_drawer/userproduct.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class DeviceItemView extends StatelessWidget {
  DeviceItemView({Key? key,this.onTap,this.onTapSetting,required this.product,required this.settingIcon}) : super(key: key);

  VoidCallback? onTap;
  VoidCallback? onTapSetting;
  UserProduct product;
  bool settingIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapSetting,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColor.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
        child: Stack(alignment: Alignment.topRight,
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
            Visibility(
              visible: settingIcon,
              child: InkWell(
                  onTap: onTapSetting,
                  child: SvgPicture.asset(IconPath.setting,width: 20.w,)),
            ),
          ],
        ),
      )

      // Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(11),
      //     color: CustomColor.white,
      //   ),
      //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Image.asset(
      //         IconPath.productItem1,
      //         height: 98.w,
      //         width: 98.w,
      //       ),
      //       SizedBox(
      //         width: 16.w,
      //       ),
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                 Expanded(
      //                   child: Text(
      //                     product.product.name??"",
      //                     style: CustomTextStyle.headerS,
      //                   ),
      //                 ),
      //
      //                 InkWell(
      //                     onTap: onTapSetting,
      //                     child: SvgPicture.asset(IconPath.setting,width: 20.w,)),
      //               ],
      //             ),
      //             hSize(2),
      //             Text(
      //               product.product.description??"",
      //               maxLines: 3,
      //               overflow: TextOverflow.ellipsis,
      //               style: CustomTextStyle.textStyle(
      //                   height: 1.3,
      //                   color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 14.sp),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
