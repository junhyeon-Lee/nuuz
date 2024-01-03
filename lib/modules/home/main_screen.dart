import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/main.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/noti_drawer/noti_drawer.dart';
import 'package:nuuz/modules/home/nuuz_profile_screen.dart';
import 'package:nuuz/modules/home/nuuz_my_screen.dart';
import 'package:nuuz/modules/home/nuuz_talk_screen.dart';
import 'package:nuuz/modules/home/nuuz_care_screen.dart';
import 'package:nuuz/modules/home/nuuz_home_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/nuuz_talk_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/trend/trend_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_app_bar.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';
import 'package:rive/rive.dart';

import '../nuuz_talk/nuuz_talk_search.dart';
import 'nuuz_home/home_controller.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(nuuzTalkCategoryProvider.notifier).getCategory();
      await ref.watch(trendProvider.notifier).getTrends(context: context);
      await ref.watch(userPostsProvider.notifier).getAllPosts("Prog_Part_0012".tr(), 1, context);
      ref.watch(getPostsProvider.notifier).setData(ref.read(userPostsProvider) ?? []);
    });
  }

  @override
  void dispose() {
    ref.invalidate(trendProvider);
    ref.invalidate(myDrawerProvider);
    ref.invalidate(userPostsProvider);
    super.dispose();
  }


  bool isBack = false;

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(mainPageProvider);
    final selectedTab = ref.watch(mainPageIndexProvider);
    final items = <BottomNavigationBarItem>[
      // const BottomNavigationBarItem(icon: ImageIcon(AssetImage(IconPath.home)), label: 'home'),

      BottomNavigationBarItem(
        icon:
        SizedBox(width:28.w, height:28.h,
            child:  RiveAnimation.asset(selectedTab==0?IconPath.mainBottomNav01riv:IconPath.mainBottomNav01)),
        label: 'home',
      ),
      BottomNavigationBarItem(
        icon:
        SizedBox(width:28.w, height:28.h,
            child:  RiveAnimation.asset(selectedTab==1?IconPath.mainBottomNav02riv:IconPath.mainBottomNav02)),
        label: 'my nuuz',
      ),
      BottomNavigationBarItem(
        icon:
        SizedBox(width:28.w, height:28.h,
            child:  RiveAnimation.asset(selectedTab==2?IconPath.mainBottomNav03riv:IconPath.mainBottomNav03)),
        label: 'nuuz care',
      ),
      BottomNavigationBarItem(
        icon:
        SizedBox(width:28.w, height:28.h,
            child:  RiveAnimation.asset(selectedTab==3?IconPath.mainBottomNav04riv:IconPath.mainBottomNav04)),
        label: 'nuuz talk',
      ),
      BottomNavigationBarItem(
        icon:
        SizedBox(width:28.w, height:28.h,
            child:  RiveAnimation.asset(selectedTab==4?IconPath.mainBottomNav05riv:IconPath.mainBottomNav05)),
        label: 'product',
      ),
    ];

    var screens = <Widget>[
      const NuuzHomeScreen(),
      const NuuzMyScreen(),
      const NuuzCareScreen(),
      const NuuzTalkScreen(),
      const NuuzProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {

        if(isBack){
          return true;
        }else{
          if(selectedTab!=0){
            ref.watch(mainPageIndexProvider.notifier).changeTab(0);
            ref.watch(mainPageProvider.notifier).pagingMainScreen(0);
          }else{
            setState(() {  isBack =true;});
            Future.delayed(const Duration(seconds: 1),(){
              setState(() {
                isBack = false;
              });
            });
          }
        }
        return false;
      },
      child: Stack(alignment: Alignment.center,
        children: [
          Scaffold(
            key: scaffoldKey,
            appBar: NuuzAppBar(
              index: selectedTab,
              context: context,
              onSearchCallBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context1) => SearchScreen(),
                    ));
              },
            ),
            drawer: const MyDrawer(),
            endDrawer: const NotiDrawer(),
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
              // child: screens[_selectedTab],
            ),
            bottomNavigationBar: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return BottomNavigationBar(
                  items: items,
                  currentIndex: selectedTab,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    ref.watch(mainPageIndexProvider.notifier).changeTab(value);
                    ref.watch(mainPageProvider.notifier).pagingMainScreen(value);
                  },
                );
              },
            ),
          ),
          loadingScreen(),

          Positioned(
            bottom: 86.h,
            child: AnimatedOpacity(
              opacity: isBack?1:0,
              duration: const Duration(milliseconds: 200),
              child: CustomContainer(
                containerColor: CustomColor.lightDark,
                radius: 16, height: 32.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Image.asset(IconPath.nuuzAppIcon, width: 22.w, height: 22.h,),
                      wSize(8),
                      NickNameMText( text: 'Comm_Gene_0057'.tr(),color: CustomColor.white,),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final mainPageProvider = StateNotifierProvider<MainPageProvider, PageController>((ref) {
  return MainPageProvider();
});

class MainPageProvider extends StateNotifier<PageController> {
  MainPageProvider() : super(PageController());

  void pagingMainScreen(int index) {
    state.jumpToPage(index);
  }

  void switchToNuuzTalk() {
    state.jumpToPage(1);
  }
}

final mainPageIndexProvider = StateNotifierProvider<MainPageIndexProvider, int>((ref) {
  return MainPageIndexProvider();
});

class MainPageIndexProvider extends StateNotifier<int> {
  MainPageIndexProvider() : super(0);

  void changeTab(int index) {
    state = index;
  }
}
