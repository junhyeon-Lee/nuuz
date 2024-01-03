import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/friends_provider.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/followers_screen.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/following_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  FriendsScreen({Key? key, required this.userId, required this.selectedIndex}) : super(key: key);

  final String userId;
  int selectedIndex;

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserData? userData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(widget.selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocalDB localDB = LocalDB();
      userData = await localDB.findUserInfo();

      ref.watch(followingNotifier(widget.userId).notifier).getUserConnection(userId: widget.userId, isFollower: false);
      ref.watch(followerNotifier(widget.userId).notifier).getUserConnection(userId: widget.userId, isFollower: true);

      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
/*    ref.invalidate(followingNotifier(widget.userId));
    ref.exists(followingNotifier(widget.userId));
    ref.invalidate(followerNotifier(widget.userId));
    ref.exists(followerNotifier(widget.userId));*/
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Talk_Prof_0011',
                fontSize: 22.sp,
                horizontalPadding: 0,
                onTap: () {
                  context.pop();
                },
                iconPath: IconPath.leftBackIcon,
              ),
              hSize(10),
              tapBar(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FollowersScreen(userId: widget.userId,),
                      FollowingScreen(userId: widget.userId,isCurrentUser: widget.userId==userData?.user_id ? true : false,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tapBar() {
    return Container(
      height: 49.h,
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        isScrollable: false,
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: CustomColor.primary,
        indicatorColor: CustomColor.primary,
        unselectedLabelColor: CustomColor.dark,
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 0),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        tabs: [
          Text(
            'Talk_Prof_0000'.tr(),
          ),
          Text(
            'Talk_Prof_0001'.tr(),
          ),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;
}
