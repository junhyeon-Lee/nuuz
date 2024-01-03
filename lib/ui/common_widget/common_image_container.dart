import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class CommonImageContainer extends StatelessWidget {
  const CommonImageContainer({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColor.primary.withOpacity(0.3)),
        color: CustomColor.lightPink,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imageUrl == null
            ? Image.asset(IconPath.nuuzAppIcon)
            : imageUrl != null
                ? imageUrl!.toLowerCase().contains("http")
                    ? CachedNetworkImage(
                        imageUrl: imageUrl!,
                      )
                    : SvgPicture.asset(imageUrl!)
                : Placeholder(),
      ),
    );
  }
}
