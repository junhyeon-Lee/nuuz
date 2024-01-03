import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/friends_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/user_profile_provider.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/common_widget/user_item_view.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class FollowingScreen extends ConsumerStatefulWidget {
  FollowingScreen({Key? key, required this.userId, required this.isCurrentUser}) : super(key: key);

  final String userId;
  bool isCurrentUser;


  @override
  ConsumerState<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends ConsumerState<FollowingScreen> {
  List<ConnectionList>? followingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      followingList = ref.watch(followingNotifier(widget.userId));
      setState(() {

      });
    });*/

  }

  @override
  Widget build(BuildContext context) {
    followingList = ref.watch(followingNotifier(widget.userId));
    return followingList?.length==null ? const Center(
      child: CustomIndicator(''),
    ) : (followingList?.length?? 0)==0 ? const NoItemFound(title: 'There is no followers users', icon: IconPath.noPostIcon,padding: 0,): ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return Slidable(
          key: Key(followingList?[i].user_id ?? ''),
          enabled: widget.isCurrentUser ? true : false,
          endActionPane: ActionPane(
            extentRatio: 0.28,
            motion: const ScrollMotion(),
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                      bool value=await ref.watch(followingNotifier(widget.userId).notifier).connectionUpdate(userId: followingList![i].user_id ?? '', index: i,context: context);
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 45.w,
                    width: 45.w,
                    margin: EdgeInsets.symmetric(horizontal: 23.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColor.primary,
                    ),
                    padding: EdgeInsets.all(9.w),
                    child: Image.asset(
                      IconPath.deleteIcon,
                      color: CustomColor.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          child: UserItemView(item: followingList![i]),
        );
      },
      separatorBuilder: (context, i) {
        return hSize(13);
      },
      itemCount: followingList?.length ?? 0,
    );
  }
}
