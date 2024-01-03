import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/user_profile_screen.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class UserItemView extends StatelessWidget {
  const UserItemView({Key? key, required this.item}) : super(key: key);
  final ConnectionList item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(
              userId: item.user_id ?? '',
              //isCurrentUser: currentUserId == userId ? true : false,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      item.profile_image == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: item.profile_image == null || (item.profile_image ?? '').isEmpty
                                  ? Image.asset(
                                      IconPath.noProfile,
                                      height: 34.w,
                                      width: 34.w,
                                    )
                                  : CachedNetworkImage(
                                      height: 34.w,
                                      width: 34.w,
                                      fit: BoxFit.cover,
                                      imageUrl: item.profile_image ?? IconPath.noProfileNetwork,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                    ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: 34.w,
                                width: 34.w,
                                fit: BoxFit.cover,
                                imageUrl: IconPath.noProfileNetwork,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              ),
                            ),
                      wSize(10),
                      Text(
                        item.nick_name ?? '',
                        style: CustomTextStyle.textStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  hSize(8),
                  Text(
                    item.introduction ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.3, color: CustomColor.dark.withOpacity(0.9)),
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
