import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class CareProgramResultListItem extends StatefulWidget {
  const CareProgramResultListItem({
    super.key,
    required this.name,
    this.description,
    this.imageUrl,
    required this.date,
    this.trailingAdd,
    this.trailingDelete,
    this.onTrailingButtonTap,
  }) : assert(
          trailingAdd == null || trailingDelete == null,
          'You can only pass trailingAdd or trailingDelete, not both.',
        );

  final String name;
  final String? description;
  final String? imageUrl;
  final String date;
  final bool? trailingAdd;
  final bool? trailingDelete;
  final Function? onTrailingButtonTap;

  @override
  State<CareProgramResultListItem> createState() => _CareProgramResultListItemState();
}

class _CareProgramResultListItemState extends State<CareProgramResultListItem> {

  @override
  void initState() {
    if(widget.name=='Prog_Titl_0006'){
      noImage = 'https://nuuz-image-storage.s3.amazonaws.com/care-program/1_Total_Care_Program_Neck.png';
    }else if(widget.name=='Prog_Titl_0007'){
      noImage = 'https://nuuz-image-storage.s3.amazonaws.com/care-program/2_Intensive_Care_Program.png';
    }else if(widget.name=='Prog_Titl_0008'){
      noImage = 'https://nuuz-image-storage.s3.amazonaws.com/care-program/3_Multi_Care_Program.png';
    }else{
      noImage = 'https://nuuz-image-storage.s3.amazonaws.com/care-program/0_Total_Care_Program_Face.png';
    }
    super.initState();
  }
  String noImage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120.h,
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          wSize(10),
          Container(
            width: 90.w,
            height: 90.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: CustomColor.lightGray,
              border: Border.all(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            child: widget.imageUrl != null
                ?
            widget.imageUrl=='https//nuuz-image-storage.s3.amazonaws.com/profile/1ebd32c3-967a-4acf-bd8b-adecaa22d336.jpeg'?
                Image.network('https://nuuz-image-storage.s3.amazonaws.com/care-program/0_Total_Care_Program_Face.png'):
            Image.network(
              widget.imageUrl ?? '',
                    fit: BoxFit.cover,
                  )
                : Image.asset(IconPath.nuuzAppIcon),
          ),
          wSize(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSize(10),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      widget.name.tr(),
                      style: CustomTextStyle.headerS,
                      overflow: TextOverflow.ellipsis,
                    )),
                    if (widget.trailingAdd ?? false)
                      GestureDetector(
                        onTap: () => widget.onTrailingButtonTap?.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              IconPath.add,
                              color: CustomColor.white,
                            ),
                          ),
                        ),
                      ),
                    if (widget.trailingDelete ?? false)
                      GestureDetector(
                        onTap: () => widget.onTrailingButtonTap?.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              IconPath.trash,
                              color: CustomColor.dark,
                            ),
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
                        text: (widget.description?.tr() ?? "").tr(),
                        style: CustomTextStyle.descriptionS.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      overflow: TextOverflow.ellipsis),
                ),





                hSize(10),
                Row(
                  children: [
                    SizedBox(
                      width: 48.w,
                      child: Image.asset(IconPath.programLogo),
                    ),
                    wSize(12),
                    Text(
                      DateFormat('MMMM d, yyyy').format(DateTime.tryParse(widget.date)?? DateTime.now()),
                      style: CustomTextStyle.descriptionS,
                    )
                  ],
                ),
                hSize(10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
