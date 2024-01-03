import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CareProgramCard extends StatelessWidget {
  const CareProgramCard({
    Key? key, required this.name, this.description, this.imageUrl,
  }) : super(key: key);

  final String name;
  final String? description;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.h,
      width: 222.w,
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(12),
        image: imageUrl != null
            ? imageUrl!.toLowerCase().contains('http') ? DecorationImage(image:  NetworkImage(imageUrl!))
            : DecorationImage(image:  AssetImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: Stack(
        children: [
           Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(description ?? "", style: CustomTextStyle.descriptionS, maxLines: 2,)
                // LargeDescriptionText(text: description ?? "test description")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 222.w, height: 122.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.83),
                    ],
                  )
              ),
            ),
          ),
          Positioned(
              top: 24.h, left: 14.w,
              child: SvgPicture.asset(IconPath.nuuzMeLogo)),
          Positioned(
              bottom: 16.h, left: 13.w,
              child: Text(name,style: CustomTextStyle.buttonM.copyWith(color: Colors.white),))
        ],
      ),
    );
  }
}
