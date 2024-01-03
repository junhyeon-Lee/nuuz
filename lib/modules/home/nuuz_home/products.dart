import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Widget products(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Comm_Gene_0011'.tr(),
              style: CustomTextStyle.headerM,
            ),
            Text(
              ///button
              'Comm_Gene_0010'.tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14.sp, color: CustomColor.primary),
            ),
          ],
        ),
        hSize(12),
        SizedBox(
          height: 400.h,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: productsItem(index),
              );
            },
            itemCount: 3,
          ),
        )
      ],
    ),
  );
}

Widget productsItem(data,{bool? isRemoveIcon,Function? onButtonTap }) {
  return Container(
    width: double.infinity,
    height: 120.h,
    margin: EdgeInsets.only(bottom: 10.h),
    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), color: CustomColor.white),
    child: Padding(
      padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96.w,
            height: 96.w,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: data.imageUrl.length >0 ? data.imageUrl[0].toString() : '',
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          wSize(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSize(1),
                Text(
                  data.name ?? "",
                  style: CustomTextStyle.headerXS,
                ),
                hSize(10),
                Flexible(
                  child: Text(
                    data.description ?? "",
                    maxLines: 4,
                    style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.lightDark),
                  ),
                )
              ],
            ),
          ),
          if (isRemoveIcon ?? false)
          InkWell(
            onTap: () => onButtonTap!.call(),
            child: Padding(
              padding:  EdgeInsets.only(left: 12.w,bottom: 3.w),
              child: SvgPicture.asset(
                IconPath.itemRemove,
                width: 18.w,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
