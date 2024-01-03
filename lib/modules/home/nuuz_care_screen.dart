import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/connection/connection/connection_bottomsheet.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/home/nuuz_my_screen.dart';
import 'package:nuuz/modules/home/service_providers/favorites_program/favorites_care_program_provider.dart';
import 'package:nuuz/modules/home/service_providers/featured_program/featured_program_provider.dart';
import 'package:nuuz/modules/home/service_providers/popular_care_programs/popular_care_program_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_card.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/modules/self_diagnosis/self_diagnosis_home.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/reserve_care_program.dart';
import 'package:nuuz/ui/common_widget/upcoming_care_program.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:scidart/numdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NuuzCareScreen extends ConsumerStatefulWidget {
  const NuuzCareScreen({
    super.key,
  });

  @override
  ConsumerState<NuuzCareScreen> createState() => _NuuzCareScreenState();
}

class _NuuzCareScreenState extends ConsumerState<NuuzCareScreen> with AutomaticKeepAliveClientMixin<NuuzCareScreen> {
  late LocalDB _localDB;
  late Future<UserData?> user;
  final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _localDB = LocalDB();
    user = _localDB.findUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(userProductController.notifier).fetchUserProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ///이 함수가 유저의 등록 여부를 판단하는 함수 같습니다.
    final userProducts = ref.watch(userProductController);
    safePrint('유저 프로덕트의 길이를 확인해보자');
    safePrint(userProducts?.length);
    final userCarePrograms = ref.watch(userCareProgramProvider);
    final featuredCarePrograms = ref.watch(featuredCareProgramProvider);
    final popularCarePrograms = ref.watch(popularCareProgramProvider);
    final favoriteCarePrograms = ref.watch(favoriteCareProgramProvider);

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView(
        children: [
          hSize(6),
          userProducts.isNotEmpty?_renderRegisteredBlock() : _renderNewRegisterationBlock(),

          // userProducts.when(
          //   data: (data) {
          //     return data.isNotEmpty ? _renderRegisteredBlock() : _renderNewRegisterationBlock();
          //   },
          //   error: (error, stackTrace) => Text(error.toString()),
          //   loading: () => loadingScreen(),
          // ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Home_Main_0003'.tr(),
              style: CustomTextStyle.headerM,
            ),
          ),
          hSize(6.h),
          userCarePrograms.when(
            data: (data) {
              if (data.isEmpty) {
                return Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // setState(() {
                          ref.read(mainPageIndexProvider.notifier).changeTab(1);
                          ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                          ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                        //  });
                        },
                        child: CustomContainer(
                          width: double.infinity,
                          height: 138.h,
                          radius: 12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Prog_Rese_0000'.tr(),
                                  style: CustomTextStyle.descriptionM,
                                  textAlign: TextAlign.center,
                                ),
                                CustomContainer(
                                  width: 250.w,
                                  height: 44,
                                  radius: 12,
                                  borderColor: CustomColor.dark,
                                  child: Center(
                                      child: Text(
                                    'Comm_Gene_0008'.tr(),
                                    style: CustomTextStyle.buttonM,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                UserCareProgram? upcomingProgram = data.cast<UserCareProgram?>().firstWhere(
                      (element) => !(DateTime.tryParse(element!.startDate)?.isBefore(today) ?? true) && element.status != 'completed',
                      orElse: () => null,
                    );
                if (upcomingProgram == null) {
                  return Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // setState(() {
                            ref.read(mainPageIndexProvider.notifier).changeTab(1);
                            ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                            ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                            // });
                          },
                          child: CustomContainer(
                            width: double.infinity,
                            height: 138.h,
                            radius: 12,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prog_Rese_0000'.tr(),
                                    style: CustomTextStyle.descriptionM,
                                    textAlign: TextAlign.center,
                                  ),
                                  CustomContainer(
                                    width: 250.w,
                                    height: 44,
                                    radius: 12,
                                    borderColor: CustomColor.dark,
                                    child: Center(
                                        child: Text(
                                      'Comm_Gene_0008'.tr(),
                                      style: CustomTextStyle.buttonM,
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  // );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: UpcomingCareProgram(
                      userCareProgram: upcomingProgram,
                      onOutlineButtonTap: () {
                        ref.read(mainPageIndexProvider.notifier).changeTab(1);
                        ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                        ref.read(selectedDateProvider.notifier).update((state) => upcomingProgram.startDate);
                      },
                    ),
                  );
                }
              }
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => loadingScreen(),
          ),
          hSize(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://youtu.be/XIMn7g6BzVQ',
                  );
                  if (await canLaunchUrl(url)) {
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    // ignore: avoid_print
                    print("Can't launch $url");
                  }
                },
                child: Image.asset(IconPath.tv)),
          ),
          hSize(20),
          Column(
            children: [
              Row(
                children: [
                  wSize(20),
                  Text(
                    'Care_Main_0004'.tr(),
                    style: CustomTextStyle.headerM.copyWith(height: 1),
                  ),
                ],
              ),
              hSize(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SizedBox(
                  height: 220.h,
                  child: featuredCarePrograms.when(
                    data: (data) => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => context.pushNamed('program-details', queryParams: {
                                "care_program_id": data[index].id.toString()
                              }),
                              child: CareProgramCard(
                                name: data[index].name.tr(),
                                //description: data[index].description!.tr(),
                                //imageUrl: data[index].image,
                                imageUrl: index % 4 == 0
                                    ? 'assets/images/nuuz_4170_1.png'
                                    : index % 4 == 1
                                        ? 'assets/images/nuuz_4928_1.png'
                                        : index % 4 == 2
                                            ? 'assets/images/nuuz_5501_1.png'
                                            : 'assets/images/nuuz_5954_1.png',
                              ),
                            ),
                        separatorBuilder: (context, index) => wSize(12),
                        itemCount: data.length),
                    error: (error, _) => const Text('Error occured'),
                    loading: () => loadingScreen(),
                  ),
                ),
              )
            ],
          ),
          hSize(12),
          GestureDetector(
            onTap: () async {
              final url = Uri.parse(
                'https://www.instagram.com/nuuz_official/',
              );
              if (await canLaunchUrl(url)) {
                launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                // ignore: avoid_print
                print("Can't launch $url");
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: [
                    wSize(16),
                    SizedBox(width: 32.w, child: Image.asset(IconPath.instar)),
                    wSize(12),
                    SizedBox(height: 20.h, child: Image.asset(IconPath.instarLogo)),
                    wSize(4),
                    Text(
                      'Instagram',
                      style: CustomTextStyle.headerS,
                    )
                  ],
                ),
              ),
            ),
          ),
          hSize(12),
          Column(
            children: [
              Row(
                children: [
                  wSize(20),
                  Text(
                    'Home_Main_0007'.tr(),
                    style: CustomTextStyle.headerM.copyWith(height: 1),
                  ),
                ],
              ),
              hSize(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SizedBox(
                  height: 220.h,
                  child: popularCarePrograms.when(
                    data: (data) => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => context.pushNamed('program-details', queryParams: {
                                "care_program_id": data[index].id.toString()
                              }),
                              child: CareProgramCard(
                                name: data[index].name.tr(),
                                //description: data[index].description!.tr(),
                                // imageUrl: data[index].image,
                                imageUrl: index % 4 == 0
                                    ? 'assets/images/nuuz_5954_1.png'
                                    : index % 4 == 1
                                        ? 'assets/images/nuuz_5501_1.png'
                                        : index % 4 == 2
                                            ? 'assets/images/nuuz_4928_1.png'
                                            : 'assets/images/nuuz_4170_1.png',
                              ),
                            ),
                        separatorBuilder: (context, index) => wSize(12),
                        itemCount: data.length),
                    error: (error, _) => const Text('Error occured'),
                    loading: () => loadingScreen(),
                  ),
                ),
              )
            ],
          ),
          hSize(12),
          Column(
            children: [
              Row(
                children: [
                  wSize(20),
                  Text(
                    'MyIn_Favo_0000'.tr(),
                    style: CustomTextStyle.headerM.copyWith(height: 1),
                  ),
                ],
              ),
              hSize(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                // child: Image.asset(IconPath.likeProgram),
                child: favoriteCarePrograms.when(
                  data: (data) => Column(
                    children: data
                        .map((e) => Column(
                              children: [
                                NuuzContainer(
                                    child: GestureDetector(
                                  onTap: () => context.pushNamed('program-details', queryParams: {
                                    "care_program_id": e.id.toString()
                                  }),
                                  child: CareProgramListItem(
                                    name: e.name.tr(),
                                    description: e.description!.tr(),
                                    imageUrl: e.image,
                                  ),
                                )),
                                hSize(12),
                              ],
                            ))
                        .toList(),
                  ),
                  error: (error, _) => const Text('Error occured'),
                  loading: () => loadingScreen(),
                ),
              ),
            ],
          ),
          hSize(12),
        ],
      ),
    );
  }

  Widget _renderNewRegisterationBlock() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.white,
        ),
        width: 350.w,
        height: 130.h,
        child: GestureDetector(
          onTap: () {
            context.go("/select");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSize(16),
                    Text(
                      'Comm_Gene_0015'.tr(),
                      style: CustomTextStyle.headerM,
                    ),
                    hSize(5),
                    SizedBox(
                      width: 206.w,
                      child: Text(
                        'Care_Main_0000'.tr(),
                        style: CustomTextStyle.descriptionS,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 42.h),
                  child: Ink(
                      decoration: BoxDecoration(
                        color: CustomColor.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () {
                            context.goNamed("select-product");
                          },
                          icon: Icon(
                            Icons.add,
                            color: CustomColor.white,
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderRegisteredBlock() {
    final connectionState = ref.watch(connectProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: connectionState == null
            ? () {
                showConnection(context);
              }
            : null,
        child: NuuzContainer(
          containerColor: CustomColor.white,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CustomColor.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(IconPath.nuuzMeLogo),
                          SizedBox(width: 12.w),
                          connectionState == null
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    backgroundColor: CustomColor.darkRed_10,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Blue_Tooth_0010'.tr(),
                                    style: Theme.of(context).textTheme.button!.copyWith(color: CustomColor.darkRed),
                                  ))
                              : TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    backgroundColor: CustomColor.greenVariant1,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Blue_Tooth_0011'.tr(),
                                    style: Theme.of(context).textTheme.button!.copyWith(color: CustomColor.greenVariant2),
                                  ))
                        ],
                      ),
                      SizedBox(
                        width: 215.w,
                        child: Text(
                          connectionState == null ? 'Care_Main_0002'.tr() : 'Care_Main_0001'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(height: 150.h, child: Image.asset(IconPath.demoProduct)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
