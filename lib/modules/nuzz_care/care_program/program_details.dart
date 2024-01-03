import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/subprogram.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/home/nuuz_my_screen.dart';
import 'package:nuuz/modules/home/nuuz_profile_screen.dart';
import 'package:nuuz/modules/home/service_providers/favorites_program/favorites_care_program_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/my_nuuz_reservation_sheet.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/modules/product/controller/product_controller.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/common_widget/rest_period_warning_bottom_sheet.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:rive/rive.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgramDetails extends ConsumerStatefulWidget {
  const ProgramDetails({super.key, required this.careProgramId, this.reservationDate, this.isFavoriteState});

  final int careProgramId;
  final String? reservationDate;
  final String? isFavoriteState;

  @override
  ConsumerState<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends ConsumerState<ProgramDetails> {
  bool isExpanded = false;
  String? userProgramId;
  final cancelToken = CancelToken();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var careProgramList = await ref.read(programController.future);
      var careProg = careProgramList.firstWhere((element) => element.id == widget.careProgramId);

      final originProductList =ref.watch(getProductProvider);
      final productController = ref.watch(getRelatedProductProvider.notifier);
      productController.setRelatedProduct(careProg.product_id_array??[], originProductList!);

    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      isExpanded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.watch(favoriteCareProgramProvider.notifier).updateFavoriteCarePrograms();
        // ref.watch(getProductProvider.notifier).getProgram();
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///이거 들고가자

    final favoriteCarePrograms = ref.watch(favoriteCareProgramProvider);
    final productList = ref.watch(getRelatedProductProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reservationDateTime = DateTime.tryParse(widget.reservationDate ?? '');
    var isFavorite = favoriteCarePrograms.whenData((value) => value.indexWhere((element) => element.id == widget.careProgramId)).value != -1;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: CustomColor.background,
            leading: GestureDetector(
              onTap: (){
               context.pop();
              },
              child: Icon(
                CupertinoIcons.arrow_left,
                color: CustomColor.dark,
              ),
            ),
            title: Text(
              "Prog_Titl_0004".tr(),
              style: CustomTextStyle.headerL,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  var careProgramList = await ref.read(programController.future);
                  var careProg = careProgramList.firstWhere((element) => element.id == widget.careProgramId);
                  ref.read(favoriteCareProgramProvider.notifier).toggleFavorite(careProg, cancelToken);
                  if (!isFavorite) {
                    if (context.mounted) {
                      final fToast = FToast().init(context);
                      fToast.showToast(
                        gravity: ToastGravity.CENTER,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 36.w),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp), color: CustomColor.dark),
                          child: Text(
                            'Comm_Gene_0025'.tr(),
                            style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.white),
                          ),
                        ),
                      );
                    }
                  }
                },
                icon: SizedBox(width: 30.w,height: 30,
                    child:  RiveAnimation.asset(isFavorite?IconPath.saveInstagramFilled:IconPath.saveInstagram)),
              ),
              wSize(12)
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    hSize(15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 200.h),
                        child: NuuzContainer(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Consumer(builder: (context, ref, child) {
                              var programList = ref.watch(programController);
                              return programList.when(
                                data: (data) {
                                  var firstData = data.where((element) => element.id == widget.careProgramId).first;
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  // 'Prog_Titl_0005'.tr(),
                                                  firstData.name.tr(),
                                                  style: CustomTextStyle.headerS,
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 24.h),

                                            if (firstData.subprograms != null)
                                              ...firstData.subprograms!.map(
                                                (e) => _renderSubprogram(e, firstData.image),
                                              ),
                                            Text(
                                              firstData.description?.tr() ?? "",
                                              style: CustomTextStyle.descriptionM,
                                            ),
                                            // SmallDescriptionText(text: firstData.description!.tr() ?? ""),
                                            SizedBox(height: 12.h),
                                            MediumHeaderText(color: CustomColor.primary, text: 'Prog_Desc_0005'.tr()),
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
                                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
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
                            }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                       // if(productList == null){
                       //   return Center(child: CustomIndicator('Comm_Gene_0001'.tr()))
                       // }else{
                       //
                       // }
                        if(productList==null){
                          return Center(child: CustomIndicator('Comm_Gene_0001'.tr()));
                        }else{
                          return productView(productList, context, productList.product?.length??0);
                        }

                      },
                    ),


                    hSize(80)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity, height: 80.h,
                  // color: Colors.red,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        widget.reservationDate != null && isSameDay(DateTime.parse(widget.reservationDate!), today)
                            ? Expanded(
                                child: Consumer(
                                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomColor.primary,
                                        foregroundColor: CustomColor.white,
                                        disabledForegroundColor: CustomColor.white,
                                      ),
                                      onPressed: reservationDateTime != null && !isSameDay(today, reservationDateTime)
                                          ? null
                                          : () async {


                                              var results = await ref.read(resultProvider.future);
                                              var restPeriodOn = results.any((element) => DateTime.tryParse(element.date!)?.isAfter(today.subtract(Duration(days: 7))) ?? false);
                                              if (restPeriodOn && context.mounted) {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) => RestPeriodWarningBottomSheet(
                                                          onPrimaryButtonTap: () async {
                                                            await _registerCareProgram(today);
                                                          },
                                                        ));
                                              } else {
                                                await _registerCareProgram(today);
                                              }


                                            },
                                      child: SizedBox(
                                        width: 120.w,
                                        height: 44.h,
                                        child: Center(
                                          child: Text('Comm_Gene_0008'.tr()),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (widget.reservationDate != null) {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => MyNuuzReservationSheet(
                                          programId: widget.careProgramId.toString(),
                                          reservationDate: widget.reservationDate!,
                                        ),
                                        // builder: (context) => widget.reservationDate != null
                                        //     ? MyNuuzReservationSheet(
                                        //         programId: widget.careProgramId.toString(),
                                        //         reservationDate: widget.reservationDate!,
                                        //       )
                                        //     : ReservationSheet(programId: widget.careProgramId.toString()),
                                      );
                                    } else {
                                      context.pop();
                                      ref.watch(mainPageIndexProvider.notifier).changeTab(1);
                                      ref.watch(mainPageProvider.notifier).pagingMainScreen(1);
                                      ref.read(selectedDateProvider.notifier).update((state) => DateTime.now().toIso8601String());
                                      context.go('/main');
                                    }
                                  },
                                  child: SizedBox(
                                    width: 120.w,
                                    height: 44.h,
                                    child: Center(
                                      child: Text('Comm_Gene_0016'.tr()),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        loadingScreen()
      ],
    );
  }

  Future<void> _registerCareProgram(DateTime today) async {
    ref.watch(loadingProvider.notifier).isLoadingTrue();

    ///여기가 케어 생성
    Map<String, dynamic> userCareProgramData = <String, dynamic>{
      "program_id": widget.careProgramId.toString(),
      "start_day": DateFormat('E').format(today),
      "start_date": today.toIso8601String(),
      "status": "created",
      //  "force" :true   ///this line///
    };
    try {
      userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
    } catch (e) {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => _errorBottomSheet(e, userCareProgramData),
      );
    }
    if (userProgramId != null) {
      if (mounted) {
        safePrint(userProgramId);
        context.pushNamed('video-guide', queryParams: {
          "care_program_id": widget.careProgramId.toString(),
          "user_care_program_id": userProgramId,
          "is_created" : "true"
        });
      }
    }
    ///여기까지

    ref.invalidate(userCareProgramProvider);
    ref.invalidate(userCareProgramForDateRangeProvider);


    ref.watch(loadingProvider.notifier).isLoadingFalse();
  }

  Widget _errorBottomSheet(e, Map userCareProgramData) {
    if ((e as DioError).response?.data['response'] != null) {
      if (e.response?.data['response'] == 'restPeriod in progress') {
        return RestPeriodWarningBottomSheet(
          onSecondaryButtonTap: () async {
            userCareProgramData.addAll(<String, dynamic>{
              "force": true
            });
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
          },
        );
      } else if (e.response?.data['response'] == 'moreThan2Bookings') {
        return CommonMessageBottomSheet(
          headerText: 'Comm_Gene_0005'.tr(),
          descriptionText: 'Prog_Rese_0001'.tr(),
          primaryButtonText: 'Comm_Gene_0006'.tr(),
          onPrimaryButtonPressed: () async {
            context.pop();
          },
          secondaryButtonText: 'Prog_Rese_0002'.tr(),
          onSecondaryButtonPressed: () async {
            userCareProgramData.addAll(<String, dynamic>{
              "force": true
            });
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
          },
        );
      } else {
        return CommonMessageBottomSheet(
          headerText: 'Comm_Gene_0005'.tr(),
          descriptionText: e.response!.data['response'],
        );
      }
    } else {
      return const SizedBox();
    }
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(color: CustomColor.primary.withOpacity(0.3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      // child: Placeholder(),
                                      child: CachedNetworkImage(imageUrl: e.imageUrl!),
                                      // child: SvgPicture.asset(IconPath.face),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      e.title.tr(),
                                      style: CustomTextStyle.headerXS,
                                    ),
                                    // SmallHeaderText(text: e.title.tr())
                                  ),
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

  Column _renderSubprogram(Subprogram e, String? image) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 96.h,
              height: 96.h,
              decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(9)), color: CustomColor.lightGray, border: Border.all(color: Colors.black.withOpacity(0.25))),
              child: CachedNetworkImage(imageUrl: image!),
            ),
            wSize(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: CustomColor.lightWhite,
                    ),
                    // width: 226.w,
                    height: 40.h,
                    child: Row(
                      children: [
                        wSize(15),
                        SizedBox(height: 12.h, child: SvgPicture.asset(IconPath.nuuzMeLogo)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomColor.lightWhite),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: SmallDescriptionText(text: 'Comm_Gene_0019'.tr()),
                              ),
                              LargeHeaderText(color: CustomColor.primary, text: e.expectedShots != null ? e.expectedShots.toString() : '-'),
                            ],
                          ),
                        ),
                      ),
                      wSize(5),
                      Expanded(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomColor.lightWhite),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: SmallDescriptionText(text: 'Comm_Gene_0020'.tr()),
                              ),
                              LargeHeaderText(color: CustomColor.primary, text: e.timeInMin == null ? '-' : e.timeInMin.toString()),
                            ],
                          ),
                        ),
                      ),
                      wSize(5),
                      Expanded(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomColor.lightWhite),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: SmallDescriptionText(text: 'Comm_Gene_0021'.tr()),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: CustomColor.dark,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: SmallDescriptionText(color: CustomColor.white, text: e.cartridgeType),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
