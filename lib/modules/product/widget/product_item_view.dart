import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/price_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class ProductIemView extends StatelessWidget {
  const ProductIemView({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: CustomColor.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              IconPath.productItem1,
              height: 100.w,
              width: 100.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'nuuz me',
                    style: CustomTextStyle.headerS,
                  ),
                  hSize(2),
                  Text(
                    'You can preview the product description.Up to 50 characters are shown in the pre',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textStyle(
                        height: 1.3, color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                  hSize(7),
                  PriceButton(
                    verticalPadding: 4,
                    iconSize: 20.w,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
