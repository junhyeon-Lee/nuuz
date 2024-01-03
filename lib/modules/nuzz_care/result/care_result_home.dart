import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_image_container.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class CareResultHome extends ConsumerStatefulWidget {
  const CareResultHome({super.key, required this.careProgramId, required this.image});

  final int careProgramId;
  final String? image;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CareResultHomeState();
}

class _CareResultHomeState extends ConsumerState<CareResultHome> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final usercare = ref.watch(userCareProgramProvider);
    safePrint("<><<<<<>>>>>>>>>>>>>>>>>>   $usercare");

    return Material(
      child: SingleChildScrollView(
        child: NuuzContainer(
          containerColor: CustomColor.background,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: CustomColor.lightWhite,
                  automaticallyImplyLeading: false,
                  // leading: GestureDetector(
                  //   onTap: context.pop,
                  //   child: Padding(
                  //       padding: EdgeInsets.all(12.0),
                  //       child: Icon(
                  //         CupertinoIcons.clear,
                  //         color: CustomColor.dark,
                  //       )),
                  // ),
                  title: Text(
                    'Comm_Gene_0009'.tr(),
                    style: CustomTextStyle.headerL,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Care_Resu_0012".tr(),
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.descriptionM,
                ),
                SizedBox(height: 12.h),
                Consumer(builder: (context, ref, child) {
                  var programList = ref.watch(programController);
                  // safePrint("ans: $programList");
                  return programList.when(
                    data: (data) {
                      var firstData = data.where((element) => element.id == widget.careProgramId).first;

                      safePrint("firstdata  ${firstData.subprograms}");
                      return Column(
                        children: [
                          NuuzContainer(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  CommonImageContainer(
                                    imageUrl: firstData.image,
                                  ),
                                  SizedBox(width: 6.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        firstData.name.tr(),
                                        style: CustomTextStyle.buttonM,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                          width: 205.w,
                                          child: Text(
                                            firstData.description.toString().tr(),
                                            style: CustomTextStyle.descriptionM,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      SizedBox(height: 12.h),
                                      Container(
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: CustomColor.dark,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          child: SvgPicture.asset(
                                            IconPath.nuuzMeLogo,
                                            color: CustomColor.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          NuuzContainer(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Consumer(builder: (context, ref, child) {
                                var programList = ref.watch(programController);
                                return programList.when(
                                  data: (data) {
                                    var firstData = data.first;
                                    // var image = ref.watch(imageController);
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child: Column(
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     LargeHeaderText(text: firstData.name),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 24.h),
                                              // ...firstData.subprograms.map(
                                              //   (e) => _renderSubprogram(e),
                                              // ),
                                              MediumHeaderText(text: DateFormat('EEE, MMMM d yyyy').format(DateTime.now())),
                                              SizedBox(height: 10.h),
                                              Container(
                                                height: 318.h,
                                                width: 318.h,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                child: widget.image != '' ? Image.file(File(widget.image!)) : Image.asset(IconPath.nuuzAppIcon),
                                                // child: widget.image != null ? CachedNetworkImage(imageUrl: widget.image!) : Image.asset(IconPath.nuuzAppIcon),
                                              ),
                                              SizedBox(height: 20.h),
                                              if (firstData.subprograms != null)
                                                ...firstData.subprograms!.map((e) => Row(
                                                      children: [
                                                        Container(
                                                          width: 200.w,
                                                          height: 60.h,
                                                          decoration:
                                                              BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomColor.background),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 4.h),
                                                            child: Image.asset(IconPath.product),
                                                          ),
                                                        ),
                                                        wSize(10),
                                                        Container(
                                                          width: 72.w,
                                                          height: 55.h,
                                                          decoration:
                                                              BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomColor.background),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 4.h),
                                                                child: SmallDescriptionText(text: 'Comm_Gene_0019'.tr()),
                                                              ),
                                                              LargeHeaderText(
                                                                  color: CustomColor.primary,
                                                                  text: e.expectedShots != null ? e.expectedShots.toString() : '-'),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              SizedBox(height: 12.h),
                                            ],
                                          ),
                                        ),
                                        if (isExpanded) ...[
                                          SizedBox(height: 20.h),
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
                                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))),
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
                                  error: (error, stackTrace) => Text('error occured'),
                                  loading: () => CircularProgressIndicator(),
                                );
                              }),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) => Text("error"),
                  );
                }),
                SizedBox(height: 12.h),

                usercare.when(
                  data: (data) {
                    var today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                    UserCareProgram? upcomingProgram = data.cast<UserCareProgram?>().firstWhere(
                        (element) => !(DateTime.tryParse(element!.startDate)?.isBefore(today) ?? true) && element.status != 'completed',
                        orElse: () => null);
                    return upcomingProgram != null
                        ? NuuzContainer(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"Prog_Rese_0028".tr()}:",
                                    style: CustomTextStyle.headerS,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Prog_Rese_0030'.tr(),
                                    style: CustomTextStyle.descriptionS,
                                  ),
                                  SizedBox(height: 4.h),
                                  CommonOutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        DateFormat('M월 d일').format(DateTime.parse(upcomingProgram.startDate)),
                                        style: CustomTextStyle.buttonM,
                                      ))
                                ],
                              ),
                            ),
                          )
                        : const SizedBox();
                    //  NuuzContainer(
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SmallHeaderText(text: "${"Prog_Rese_0028".tr()}:"),
                    //           SizedBox(height: 4.h),
                    //           SmallDescriptionText(text: 'Prog_Rese_0029'.tr()),
                    //           SizedBox(height: 4.h),
                    //           CommonButton(
                    //             onPressed: _renderReservationBottomSheet,
                    //             text: "Comm_Gene_0016".tr(),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   );
                  },
                  error: (error, stackTrace) => const Text('err'),
                  loading: () => const CustomIndicator(''),
                ),
                SizedBox(height: 12.h),
                // NuuzContainer(
                //   child: Padding(
                //     padding: EdgeInsets.all(12),
                //     child: Row(
                //       children: [
                //         Column(
                //           children: [
                //             SmallHeaderText(text: "Cheered nuuMe"),
                //             AvatarStack(
                //               height: 50,
                //               width: 250.w,
                //               avatars: [
                //                 for (var n = 0; n < 15; n++)
                //                   NetworkImage(
                //                       'https://i.pravatar.cc/150?img=$n'),
                //               ],
                //             ),
                //           ],
                //         ),
                //         Column(
                //           children: [
                //             SmallHeaderText(text: "Total"),
                //             LargeHeaderText(text: '347'),
                //           ],
                //         ),
                //         Container(
                //           width: 12.w,
                //           color: CustomColor.primary,
                //         )
                //       ],
                //     ),
                //   ),
                // )
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    children: [
                      Expanded(
                          child: CommonOutlinedButton(
                              onPressed: () {
                                ref.read(mainPageIndexProvider.notifier).changeTab(1);
                                ref.read(mainPageProvider.notifier).pagingMainScreen(1);
                                context.go('/main');
                              },
                              child: Text('Comm_Gene_0023'.tr()))),
                      wSize(12),
                      Expanded(
                          child: CommonButton(
                              onPressed: () {
                                ref.read(mainPageIndexProvider.notifier).changeTab(0);
                                ref.read(mainPageProvider.notifier).pagingMainScreen(0);
                                context.go('/main');
                              },
                              text: 'Comm_Gene_0022'.tr()))
                    ],
                  ),
                ),
                hSize(12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderProgramPartDetails(Program firstData) {
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(color: CustomColor.primary)),
                                    child: CachedNetworkImage(
                                      imageUrl: e.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(child: SmallHeaderText(text: e.title.tr())),
                                  SizedBox(width: 12.w),
                                  SmallHeaderText(text: e.cartridgeType),
                                  SizedBox(width: 12.w),
                                  LargeDescriptionText(
                                    color: CustomColor.primary,
                                    text: e.shots.toString(),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
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

// void _renderReservationBottomSheet() {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     backgroundColor: Colors.transparent,
//     builder: (context) => SizedBox(
//         height: 500.h,
//         child: ReservationSheet(
//           programId: widget.careProgramId.toString(),
//         )),
//   );
// }

// Column _renderSubprogram(Subprogram e) {
//   return Column(
//     children: [
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CommonImageContainer(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   NuuzContainer(
//                     containerColor: CustomColor.lightWhite,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SvgPicture.asset(IconPath.nuuzMeLogo),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: 72.w,
//                         height: 55.h,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: CustomColor.lightWhite),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 4.h),
//                               child: const SmallDescriptionText(text: 'Shot'),
//                             ),
//                             LargeHeaderText(
//                                 color: CustomColor.primary,
//                                 text: e.expectedShots != null
//                                     ? e.expectedShots.toString()
//                                     : '-'),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 72.w,
//                         height: 55.h,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: CustomColor.lightWhite),
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 4.h),
//                               child: const SmallDescriptionText(text: 'Min'),
//                             ),
//                             LargeHeaderText(
//                                 color: CustomColor.primary,
//                                 text: e.timeInMin.toString()),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 72.w,
//                         height: 55.h,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: CustomColor.lightWhite),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 4.h),
//                               child: const SmallDescriptionText(
//                                   text: 'Cartridge'),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: CustomColor.dark,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 4),
//                                 child: SmallDescriptionText(
//                                     color: CustomColor.white,
//                                     text: e.cartridgeType),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       SizedBox(height: 24.h),
//     ],
//   );
// }
}
