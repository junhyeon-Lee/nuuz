import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class OneResult extends ConsumerStatefulWidget {
  const OneResult({super.key, required this.selectedId});

  final String selectedId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OneResultState();
}

class _OneResultState extends ConsumerState<OneResult> with TickerProviderStateMixin {
  final carouselController = CarouselController();

  // late final TabController tabController;
  // int? otherSelectedIndex;
  // // int _currentIndex = 0;
  bool isExpanded = false;

  // // int? currentId;
  late String _selectedResultId;

  // int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // _currentIndex = widget.selectedIndex;
    // tabController = TabController(length: 2, vsync: this);
    _selectedResultId = widget.selectedId;
  }

  // void onResultTileSelect(int index) {
  //   setState(() {
  //     otherSelectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final resultList = ref.watch(resultProvider);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: CustomColor.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.close)),
        title: Text(
          'Talk_Post_0002'.tr(),
          style: CustomTextStyle.headerL,
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         context.pushNamed('edit-post');
        //       },
        //       icon: SvgPicture.asset(IconPath.post)),
        // ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            child: resultList.when(
              skipLoadingOnRefresh: false,
              data: (results) {
                // currentId = data[0].program!.progaram_id;
                var data = results.where((e) => e.result_image == null).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 1.05.sw,
                      // width: 1.sw,
                      child: Container(
                        decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(builder: (context, constraints) {
                              return SizedBox(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth,
                                // width: 0.95.sw,
                                // height: 0.95.sw,
                                child: Stack(
                                  children: [
                                    CarouselSlider.builder(
                                      carouselController: carouselController,
                                      itemCount: data.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                          child: data[index].result_image != null
                                              ? Image.network(
                                                  data[index].result_image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  IconPath.nuuzAppIcon,
                                                  fit: BoxFit.cover,
                                                ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        onPageChanged: (index, reason) {
                                          // _currentIndex = index;
                                          _selectedResultId = data[index].result_id!;
                                          setState(() {});
                                        },
                                        aspectRatio: 1,
                                        viewportFraction: 1,
                                        // height: 400.h,
                                        // enlargeFactor: 2,
                                        initialPage: data.indexWhere((element) => element.result_id == widget.selectedId),
                                        enableInfiniteScroll: false,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: IconButton(
                                        onPressed: () => carouselController.previousPage(),
                                        icon: Icon(
                                          CupertinoIcons.chevron_left,
                                          color: CustomColor.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: IconButton(
                                        onPressed: () {
                                          carouselController.nextPage();
                                        },
                                        icon: Icon(
                                          CupertinoIcons.chevron_right,
                                          color: CustomColor.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColor.dark,
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text(
                                    DateFormat('yyyy.MM.dd')
                                        .format(DateTime.parse(data.firstWhere((element) => element.result_id == _selectedResultId).date!)),
                                    // '2023.07.14',
                                    style: CustomTextStyle.headerM.copyWith(
                                      color: CustomColor.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            // hSize(12),
                            // SizedBox(
                            //   height: 60.w,
                            //   child: ListView.separated(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: data.length,
                            //     separatorBuilder: (context, index) => wSize(4),
                            //     itemBuilder: (context, index) {
                            //       return GestureDetector(
                            //           onTap: () {
                            //             carouselController.animateToPage(index);
                            //           },
                            //           child: Container(
                            //             height: 60.h,
                            //             width: 60.w,
                            //             decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(10),
                            //                 border: _selectedResultId == data[index].result_id //see this
                            //                     ? Border.all(width: 2, color: CustomColor.blue)
                            //                     : Border.all(color: Colors.transparent),
                            //                 image: DecorationImage(fit: BoxFit.cover, image: data[index].result_image != null ? NetworkImage(data[index].result_image!) : const AssetImage(IconPath.rectangle) as ImageProvider)),
                            //           ));
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // hSize(12),
                    Material(
                      color: CustomColor.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Care_Resu_0005'.tr(),
                                      style: CustomTextStyle.buttonM.copyWith(color: CustomColor.primary),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            ),

                            // child: TabBar(
                            //   controller: tabController,
                            //   unselectedLabelStyle: CustomTextStyle.buttonM,
                            //   indicatorSize: TabBarIndicatorSize.label,
                            //   indicatorColor: CustomColor.primary,
                            //   unselectedLabelColor: Colors.black,

                            //   labelColor: CustomColor.primary,
                            //   labelStyle: CustomTextStyle.buttonM,
                            //   dividerColor: CustomColor.black,
                            //   onTap: (value) {
                            //     setState(() {
                            //       _selectedTabIndex = value;
                            //     });
                            //   },
                            //   tabs: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Text(
                            //         'Care_Resu_0005'.tr(),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Text(
                            //         'Mynu_Deta_0008'.tr(),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                    width: 60.w,
                                    height: 6.h,
                                    color: CustomColor.primary,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColor.white,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hSize(20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mynu_Deta_0001'.tr(),
                                      style: CustomTextStyle.headerL,
                                    ),
                                    hSize(4),
                                    Text(
                                      'Mynu_Deta_0002'.tr(),
                                      style: CustomTextStyle.descriptionM,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    var programList = ref.watch(programController);
                                    return programList.when(
                                      data: (programs) {
                                        var firstData = programs.firstWhere((element) {
                                          return element.id ==
                                              data.firstWhere((element) => element.result_id == _selectedResultId).program!.progaram_id;
                                        });
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 24.h),
                                                  if (firstData.subprograms != null)
                                                    ...firstData.subprograms!.map(
                                                      (e) => Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 220.w,
                                                                height: 88.h,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(24),
                                                                  color: CustomColor.background,
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(top: 4.h),
                                                                  child: Image.asset(IconPath.product),
                                                                ),
                                                              ),
                                                              wSize(10),
                                                              Container(
                                                                width: 88.w,
                                                                height: 88.h,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(24), color: CustomColor.background),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(top: 4.h),
                                                                        child: Text(
                                                                          'Comm_Gene_0019'.tr(),
                                                                          style: CustomTextStyle.descriptionM,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        e.expectedShots != null ? e.expectedShots.toString() : '-',
                                                                        style: CustomTextStyle.headerL.copyWith(color: CustomColor.primary),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          hSize(6),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            if (isExpanded) ...[
                                              // SizedBox(height: 20.h),
                                              _renderProgramPartDetails(firstData),
                                            ],
                                            SizedBox(height: 10.h),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isExpanded = !isExpanded;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isExpanded ? CustomColor.darkWhite : CustomColor.primary,
                                                  borderRadius: const BorderRadius.vertical(
                                                    bottom: Radius.circular(12),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: isExpanded
                                                      ? Icon(CupertinoIcons.chevron_up, color: CustomColor.primary)
                                                      : Icon(CupertinoIcons.chevron_down, color: CustomColor.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      error: (error, stackTrace) => const Text('error occured'),
                                      loading: () => const CustomIndicator(''),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => const Text('err'),
              loading: () => loadingScreen(),
            ),
          ),
        ),
      ),
    );
  }

  NuuzContainer _renderProgramPartDetails(Program firstData) {
    return NuuzContainer(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Column(
            children: firstData.subprograms!
                .map(
                  (e) => Column(
                    children: e.partDetails.map(
                      (e) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      children: [
                                    Container(
                                      height: 36.w,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        border: Border.all(
                                          color: CustomColor.primary.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        // child: Placeholder(),
                                        child: Image.network(e.imageUrl!),
                                        // child: SvgPicture.asset(IconPath.face),
                                      ),
                                    ),
                                    wSize(12),
                                    Text(e.title.tr(), style: CustomTextStyle.headerXS),
                                  ]),
                                  Row(
                                    children: [
                                      Text(
                                        e.cartridgeType,
                                        style: CustomTextStyle.descriptionM,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        e.shots.toString(),
                                        style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.primary),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              hSize(20),
                              // const Divider(height: 24),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
