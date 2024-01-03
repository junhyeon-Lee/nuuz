import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/friends_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/user_profile_provider.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/common_widget/user_item_view.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class FollowersScreen extends ConsumerStatefulWidget {
  const FollowersScreen({Key? key,required this.userId}) : super(key: key);

  final String userId;

  @override
  ConsumerState<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends ConsumerState<FollowersScreen> {
  List<ConnectionList>? followerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      followerList = ref.watch(followerNotifier(widget.userId));
      setState(() {

      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    followerList = ref.watch(followerNotifier(widget.userId));

    return followerList==null ? const Center(
      child: CustomIndicator(''),
    ) : (followerList?.length?? 0)==0 ? const NoItemFound(title: 'There is no followers users', icon: IconPath.noPostIcon,padding: 0,): ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return UserItemView(item: followerList![i]);
      },
      separatorBuilder: (context, i) {
        return hSize(13);
      },
      itemCount: followerList?.length ?? 0,
    );
  }
}
