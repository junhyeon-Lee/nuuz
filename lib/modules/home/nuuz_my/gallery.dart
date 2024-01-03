import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_compare_slider/image_compare_slider.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_result_list_item.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../../../models/program.dart';
import '../../nuzz_care/care_program/program_controller.dart';
import '../../../ui/common_widget/common_text_widget.dart';

class Gallery extends ConsumerWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultList = ref.watch(resultProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.close)),
        title: Text(
          '갤러리',
          style: CustomTextStyle.headerL,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: resultList.when(
          skipLoadingOnRefresh: false,
          data: (data) => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              itemBuilder: (context, index) => Visibility(
                    visible: data[index].result_image != null,
                    child: GestureDetector(
                        onTap: () {
                          // context.goNamed('/detailGallery');
                          context.goNamed('/detailGallery', queryParams: {
                            'selectedId': data[index].result_id
                          });
                        },
                        child: CareProgramResultListItem(
                          name: data[index].program!.care_program_name!,
                          date: data[index].date!,
                          description: data[index].program!.description,
                          imageUrl: data[index].result_image,
                          trailingDelete: true,
                        )),
                  ),
              separatorBuilder: (context, index) => hSize(12),
              itemCount: data.length),
          error: (error, stackTrace) => const Text('err'),
          loading: () => const CustomIndicator(''),
        ),
      ),
    );
  }
}

class DetailGallery extends ConsumerStatefulWidget {
  const DetailGallery({super.key, required this.selectedId});

  final String selectedId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailGalleryState();
}

class _DetailGalleryState extends ConsumerState<DetailGallery> with TickerProviderStateMixin {
  final carouselController = CarouselController();
  late final TabController tabController;
  String? _secondaryResultId;

  // int _currentIndex = 0;
  bool isExpanded = false;

  // int? currentId;
  late String _selectedResultId;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // _currentIndex = widget.selectedIndex;
    tabController = TabController(length: 2, vsync: this);
    _selectedResultId = widget.selectedId;
  }

  void onResultTileSelect(String resultId) {
    setState(() {
      _secondaryResultId = resultId;
    });
  }

  void onPrimaryResultTileSelect(String resultId) {
    setState(() {
      _selectedResultId = resultId;
    });
  }

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
                var data = results.where((element) => element.result_image != null).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 1.05.sw,
                      // width: 1.sw,
                      child: Container(
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                            Column(
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
                                            safePrint("this is real index and normal index  $realIndex  $index");
                                            return ClipRRect(
                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                              child: data[index].result_image != null
                                                  ? Image.network(
                                                      data[index].result_image!,
                                                      // 'https://picsum.photos/id/2/200',
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
                                        DateFormat('yyyy.MM.dd').format(DateTime.parse(data.firstWhere((element) => element.result_id == _selectedResultId).date!)),
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
                            Column(
                              children: [
                                LayoutBuilder(builder: (context, constraints) {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: SizedBox(
                                      width: constraints.maxWidth,
                                      height: constraints.maxWidth,
                                      child: ImageCompareSlider(
                                        handlePosition: 0.97,
                                        fillHandle: true,
                                        // itemOneBuilder: (child, context) => Stack(
                                        //   children: [
                                        //     AspectRatio(aspectRatio: 1, child: child),
                                        //     if (otherSelectedIndex == null)
                                        //       Align(
                                        //           alignment: Alignment.centerLeft,
                                        //           child: Padding(
                                        //             padding: const EdgeInsets.only(left: 12),
                                        //             child: SizedBox(
                                        //                 width: 150.w,
                                        //                 child: Text(
                                        //                   'Mynu_Deta_0006'.tr(),
                                        //                   style: CustomTextStyle.descriptionL.copyWith(color: CustomColor.white),
                                        //                 )),
                                        //           )),
                                        //   ],
                                        // ),
                                        // itemTwoBuilder: (child, context) => AspectRatio(aspectRatio: 1, child: child),
                                        itemOne: _secondaryResultId != null
                                            ? Image.network(
                                              data.firstWhere((element) => element.result_id == _secondaryResultId).result_image!,
                                                // data[_secondaryResultId!].result_image!,
                                              )
                                            : Image.asset(
                                                IconPath.nuuzAppIcon,
                                              ),
                                        itemTwo: data.firstWhere((element) => element.result_id == _selectedResultId).result_image != null
                                            ? Image.network(
                                                data.firstWhere((element) => element.result_id == _selectedResultId).result_image!,
                                              )
                                            : Image.asset(
                                                IconPath.nuuzAppIcon,
                                              ),

                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColor.dark,
                                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Row(
                                      children: [
                                        _secondaryResultId != null
                                            ? Text(
                                                DateFormat('MM.dd').format(DateTime.parse(data.firstWhere((element) => element.result_id == _secondaryResultId).date!)),
                                                style: CustomTextStyle.headerM.copyWith(
                                                  color: CustomColor.white.withOpacity(0.7),
                                                ),
                                              )
                                            : Text(
                                                'Mynu_Deta_0004'.tr(),
                                                style: CustomTextStyle.headerM.copyWith(
                                                  color: CustomColor.white.withOpacity(0.7),
                                                ),
                                              ),
                                        const Spacer(),
                                        Center(
                                          child: Text(
                                            DateFormat('MM.dd').format(DateTime.parse(data.firstWhere((element) => element.result_id == _selectedResultId).date!)),
                                            // '2023.07.14',
                                            style: CustomTextStyle.headerM.copyWith(
                                              color: CustomColor.white.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                // Row(
                                //   children: [
                                //     if (otherSelectedIndex != null) Text(DateFormat('MMMM d').format(DateTime.parse(data[otherSelectedIndex!].date!))),
                                //     const Spacer(),
                                //     Text(DateFormat('MMMM d').format(DateTime.parse(data.firstWhere((element) => element.result_id == _selectedResultId).date!)))
                                //   ],
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // hSize(12),
                    Material(
                      color: CustomColor.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelStyle: CustomTextStyle.buttonM,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: CustomColor.primary,
                          unselectedLabelColor: Colors.black,
                          labelColor: CustomColor.primary,
                          labelStyle: CustomTextStyle.buttonM,
                          dividerColor: CustomColor.black,
                          onTap: (value) {
                            setState(() {
                              _selectedTabIndex = value;
                            });
                          },
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Care_Resu_0005'.tr(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Mynu_Deta_0008'.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
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
                                              return element.id == data.firstWhere((element) => element.result_id == _selectedResultId).program!.progaram_id;
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
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: CustomColor.background),
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
                                                                          LargeHeaderText(color: CustomColor.primary, text: e.expectedShots != null ? e.expectedShots.toString() : '-'),
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
                                                      child: isExpanded ? Icon(CupertinoIcons.chevron_up, color: CustomColor.primary) : Icon(CupertinoIcons.chevron_down, color: CustomColor.white),
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
                          SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColor.white,
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mynu_Deta_0000'.tr(),
                                          style: CustomTextStyle.headerL,
                                        ),
                                        Text(
                                          'Mynu_Deta_0003'.tr(),
                                          style: CustomTextStyle.descriptionM,
                                        ),
                                        hSize(12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _showGalleryBottomSheet(context, data, _selectedResultId, onResultTileSelect);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text(_secondaryResultId == null ? 'Mynu_Deta_0004'.tr() : DateFormat('MMMM d').format(DateTime.parse(data.firstWhere((element) => element.result_id == _secondaryResultId).date!)), style: CustomTextStyle.nicknameM),
                                                      SvgPicture.asset(IconPath.calendar2)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            wSize(12),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _showGalleryBottomSheet(context, data, _secondaryResultId, onPrimaryResultTileSelect);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text(
                                                        '${DateFormat('MMMM dd').format(DateTime.parse(data.firstWhere((element) => element.result_id == _selectedResultId).date!))}일',
                                                        style: CustomTextStyle.nicknameM,
                                                      ),
                                                      SvgPicture.asset(IconPath.calendar2)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        hSize(12),
                                        CommonButton(
                                          onPressed: _secondaryResultId == null
                                              ? null
                                              : () {
                                                  setState(() {
                                                    _secondaryResultId = null;
                                                  });
                                                },
                                          text: 'Mynu_Deta_0005'.tr(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
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
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          child: Column(
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
                                  SizedBox(width: 12.w),
                                  Expanded(flex: 20, child: Text(
                                      e.title.tr(), style: CustomTextStyle.headerXS)),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        e.cartridgeType,
                                        style: CustomTextStyle.descriptionM,
                                      )),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        e.shots.toString(),
                                        style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.primary),
                                      ),
                                    ),
                                  ),
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

Future<void> _showGalleryBottomSheet(
  BuildContext context,
  List<Result> results,
  String? selectedId,
  Function tapCallback,
) async {
  safePrint('출력부');
  safePrint(results);


  final filteredList = results.where((element) => element.result_id != selectedId && element.result_image != null).toList();

  if (filteredList.isNotEmpty) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 0.9.sh),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return SizedBox(
            // height: 758.h,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: SvgPicture.asset(IconPath.close)),
                            Text(
                              '선택',
                              style: CustomTextStyle.headerL,
                            ),
                            wSize(24),
                          ],
                        ),
                        hSize(20),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xffebeae9),
                        ),
                        ...filteredList.map((e) {
                          // if (e.result_id == selectedId || e.result_image == null) {
                          //   return const SizedBox();
                          // } else {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  tapCallback(e.result_id);
                                  context.pop();
                                },
                                child: CareProgramResultListItem(
                                  name: e.program?.care_program_name??"",
                                  description: e.program?.description??"",
                                  imageUrl: e.result_image,
                                  date: e.date!,
                                ),
                              ),
                              hSize(12),
                            ],
                          );
                          // }
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 320.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(13)),
                          border: Border.all(
                            color: CustomColor.dark,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '취소',
                            style: CustomTextStyle.buttonM,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CommonMessageBottomSheet(headerText: 'Comm_Gene_0005'.tr(), descriptionText: 'Mynu_Deta_0009'.tr()),
    );
  }
}
