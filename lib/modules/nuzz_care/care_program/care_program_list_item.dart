import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CareProgramListItem extends StatelessWidget {
  const CareProgramListItem({
    super.key,
    required this.name,
    this.description,
    this.imageUrl,
    this.trailingAdd,
    this.trailingDelete,
    this.trailingRemove,
    this.postItemRemove,
    this.onTrailingButtonTap,
    this.time,
  }) : assert(
          trailingAdd == null || trailingDelete == null || trailingRemove == null,
          'You can only pass one of trailingAdd or trailingDelete or trailingRemove',
        );

  final String name;
  final String? description;
  final String? imageUrl;
  final bool? trailingAdd;
  final bool? trailingDelete;
  final bool? trailingRemove;
  final bool? postItemRemove;
  final Function? onTrailingButtonTap;
  final String? time;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Row(
        children: [
          wSize(10),
          Container(
            width: 96.h,
            height: 96.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(9)),
              color: CustomColor.lightGray,
              border: Border.all(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            child: imageUrl == null
                ? ClipRRect(
                borderRadius:const BorderRadius.all(Radius.circular(9)),
              child: CachedNetworkImage(imageUrl:IconPath.nuuzDefaultImage!, fit: BoxFit.contain,errorWidget: (context, url, error) => Image.asset(IconPath.nuuzAppIcon),))
                :   CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.contain, errorWidget: (context, url, error) => ClipRRect(
                borderRadius:const BorderRadius.all(Radius.circular(9)),child: Image.asset(IconPath.nuuzAppIcon)),),

          ),
          wSize(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSize(14),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      name.tr(),
                      style: CustomTextStyle.buttonM,
                      overflow: TextOverflow.ellipsis,
                    )),
                    if (trailingAdd ?? false)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColor.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            IconPath.add,
                            // size: 14,
                            color: CustomColor.white,
                          ),
                        ),
                      ),
                    if (trailingDelete ?? false)
                      GestureDetector(
                        onTap: () => onTrailingButtonTap!.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              IconPath.trash,
                              // size: 14,
                              color: CustomColor.dark,
                            ),
                          ),
                        ),
                      ),
                    if (trailingRemove ?? false)
                      GestureDetector(
                        onTap: () => onTrailingButtonTap!.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.dark,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              IconPath.remove,
                              // size: 14,
                              color: CustomColor.white,
                            ),
                          ),
                        ),
                      ),

                    if (postItemRemove ?? false)
                      InkWell(
                        onTap: () => onTrailingButtonTap!.call(),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 12.w,bottom: 3.w),
                          child: SvgPicture.asset(
                            IconPath.itemRemove,
                             width: 18.w,
                          ),
                        ),
                      ),
                    wSize(12),
                  ],
                ),
                hSize(10),
                SizedBox(
                  width: 205.w,
                  child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: (description ?? "").tr(),
                        style: CustomTextStyle.descriptionM.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      overflow: TextOverflow.ellipsis),
                ),
                hSize(10),
                SizedBox(width: 48.w, child: Image.asset(IconPath.programLogo)),
                hSize(10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
