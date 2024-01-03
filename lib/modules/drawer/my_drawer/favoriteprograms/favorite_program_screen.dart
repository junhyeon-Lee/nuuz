
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/drawer/my_drawer/favoriteprograms/model/favprogram.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/home/service_providers/favorites_program/favorites_care_program_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_details.dart';
import 'package:nuuz/modules/product/controller/product_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../my_drawer_service.dart';
import 'model/favprogramlist.dart';

class FavoriteProgramScreen extends ConsumerStatefulWidget {
  const FavoriteProgramScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoriteProgramScreen> createState() => _FavoriteProgramScreenState();
}

class _FavoriteProgramScreenState extends ConsumerState<FavoriteProgramScreen> {
  var loginResponse;

  List<FavProgramModel> favProgramModelListdata=[];
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      await ref.watch(getAuthInfoData.notifier).getAuthInfoData();
      loginResponse = ref.watch(getAuthInfoData)?.accessToken;
      safePrint("FavoriteProgramScreen==loginResponse?.accessToken= ${loginResponse}");
      await  ref.watch(favProgramNotifier.notifier).getFavProgram(loginResponse ?? "");
      favProgramModelListdata = ref.watch(favProgramNotifier)!.favouriteData;
      safePrint("FavoriteProgramScreen=== $favProgramModelListdata");
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void navigateSecondPage() {

  }
  FutureOr onGoBack(dynamic value) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      await ref.watch(getAuthInfoData.notifier).getAuthInfoData();
      loginResponse = ref.watch(getAuthInfoData)?.accessToken;
      safePrint("FavoriteProgramScreen==loginResponse?.accessToken= ${loginResponse}");
      await  ref.watch(favProgramNotifier.notifier).getFavProgram(loginResponse ?? "");
      favProgramModelListdata = ref.watch(favProgramNotifier)!.favouriteData;
      safePrint("FavoriteProgramScreen=== $favProgramModelListdata");
      setState(() {
        isLoading = false;
      });
    });
    refreshData();
    setState(() {});
  }
  void refreshData() {
    id++;
  }
  int id =0;
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Column(
          children: [
            hSize(MediaQuery.of(context).viewPadding.top),
            CustomAppBar(
              title: 'MyIn_Favo_0000'.tr(),
              onTap: () {
                context.pop();
              },
              iconPath: IconPath.leftBackIcon,
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      favProgramModelListdata == null
                          ? Container(
                              height: MediaQuery.of(context).size.height - 200,
                              alignment: Alignment.center,
                              child:  CustomIndicator('Comm_Gene_0001'.tr()))
                          : (favProgramModelListdata.length ?? 0)==0 ?
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _addFavoriteWidget(),
                      ) : favProgramModelListdata.isNotEmpty
                              ? Expanded(
                                  child: ScrollConfiguration(
                                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, i) {
                                            if(i==favProgramModelListdata.length){
                                              return _addFavoriteWidget();
                                            }else{
                                              return favoriteItemVIew(i);
                                            }

                                        },
                                        separatorBuilder: (context, i) {
                                          return hSize(13);
                                        },
                                        itemCount: favProgramModelListdata.length+1),
                                  ),
                                )
                              : const SizedBox.shrink(),
                    ],
                  ),
                  isLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height - 200,
                          alignment: Alignment.center,
                          child: CustomIndicator('Comm_Gene_0001'.tr()))
                      : SizedBox.shrink()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget favoriteItemVIew(i) {
    return GestureDetector(
      onTap: () async {

        // final careProgramList = await ref.read(programController.future);
        // final careProg = careProgramList.firstWhere((element) => element.id == favProgramModelListdata[i]!.care_program_id!);
        //
        //
        // final productController = ref.watch(getProductProvider.notifier);
        // productController.setRelatedProduct(careProg.product_id_array??[]);
        // final productList = ref.watch(getProductProvider.notifier).relatedProduct;
        // safePrint('길이');
        // safePrint(productList.product?.length);
        // // context.pushNamed('program-details', queryParams: {
        // //   "care_program_id": favProgramModelListdata[i].care_program_id.toString(),
        // // });
        // Route route = MaterialPageRoute(builder: (context) => ProgramDetails(careProgramId: favProgramModelListdata[i]!.care_program_id!));
        // Navigator.push(context, route).then(onGoBack);

      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.26,
          motion: const ScrollMotion(),
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                safePrint("deleteFavProgram===screen deleteFavProgram=loginResponse?.accessToken====${loginResponse}");
                Map<String, dynamic> data = {"careProgram": favProgramModelListdata[i].care_program_id.toString()};
                MyDrawerRepository _repository = MyDrawerRepository();
                var response = await _repository.deleteFavProgram(loginResponse ?? "", data).then((value) async {
                  safePrint("deleteFavProgram===screen deleteFavProgram=====$value");
    
                  await ref.watch(favProgramNotifier.notifier).getFavProgram(loginResponse ?? "");
                  setState(() {
                    favProgramModelListdata = ref.watch(favProgramNotifier)!.favouriteData;
                    isLoading = false;
                  });
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
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: CustomColor.primary)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: favProgramModelListdata[i].image ?? "",
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    fit: BoxFit.cover,
                    width: 98.w,
                    height: 98.w,
                  ),
                ),
              ),
              // Image.asset(
              //   IconPath.careProgramIcon,
              //   width: 98.w,
              //   height: 98.w,
              // ),
              wSize(14),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  hSize(6),
                  Text(
                    favProgramModelListdata[i].care_program_name.toString().tr()??"",
                    // "Total Care Program - Neck",
                    style: CustomTextStyle.buttonM,
                  ),
                  hSize(6),
                  SizedBox(width: 205.w,
                    child: Text(
                      favProgramModelListdata[i].description.toString().tr() ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.descriptionM
                    ),
                  ),
    
                  hSize(18),
                  SizedBox(
                    width: 48.w,
                    child: Image.asset(IconPath.programLogo),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _addFavoriteWidget(){
    return  GestureDetector(
      onTap: (){
        List<int> favIdList = [];
        for(int i=0; i<favProgramModelListdata.length; i++){
          favIdList.add(favProgramModelListdata[i]!.care_program_id!);
        }

        CancelToken cancelToken = CancelToken();


        Route route = MaterialPageRoute(builder: (context) =>
            FavoriteCareProgramListScreen(

                onTapItem: (program)  async {

                  setState(() {
                    isLoading = true;
                  });

                  await  ref.read(favoriteCareProgramProvider.notifier).toggleFavorite(program, cancelToken);


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

                  await  ref.watch(favProgramNotifier.notifier).getFavProgram(loginResponse ?? "");
                  favProgramModelListdata = ref.watch(favProgramNotifier)!.favouriteData;
                  setState(() {
                    isLoading = false;
                  });







                },
                favIdList

            ));
        Navigator.push(context, route).then(onGoBack);



      },
      child: Container(
          width: double.infinity,
          height: 106.h,
          color: Colors.white ,
          child: DottedBorder(
              color: CustomColor.gray,
              radius: const Radius.circular(12),
              strokeWidth: 3.w,
              strokeCap: StrokeCap.round,
              dashPattern: [10.w, 10.w],
              borderType: BorderType.RRect,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconPath.plus),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 270,
                        child: Text(
                          'MyIn_Favo_0000'.tr(),
                          style: CustomTextStyle.descriptionL.copyWith(color: CustomColor.gray),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}


class FavoriteCareProgramListScreen extends ConsumerStatefulWidget {
  const FavoriteCareProgramListScreen(this.favProgramList,  {super.key, this.onTapItem, this.reservationDate,});

  final Function? onTapItem;
  final String? reservationDate;
  final List<int> favProgramList;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteCareProgramListScreenState();
}

class _FavoriteCareProgramListScreenState extends ConsumerState<FavoriteCareProgramListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        context: context,
        title: 'Talk_Serc_0000'.tr(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer(
              builder: (context, ref, child) {
                final programList = ref.watch(programController);
                safePrint('프로그램 리스트');
                safePrint(programList);
                return programList.when(
                  data: (data) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    child: Column(
                      children: data
                          .map((e) =>
                          Visibility(
                            visible: !widget.favProgramList.contains(e.id),
                            child: Column(
                        children: [
                            Container(
                              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      ref.watch(loadingProvider.notifier).isLoadingTrue();
                                      var selectProgram = await ref.read(programController.notifier).getProgramByID(e.id.toString());
                                      await ref.watch(careProgramProvider.notifier).setProgramData(selectProgram!);
                                      await widget.onTapItem!(e);
                                      ref.watch(loadingProvider.notifier).isLoadingFalse();
                                      Future.delayed(const Duration(milliseconds: 300));
                                      Navigator.pop(context);
                                    },
                                    child: CareProgramListItem(
                                      name: e.name.tr(),
                                      description:e.description != null?e.description!.tr():'',
                                      imageUrl: e.image,
                                      trailingAdd: widget.onTapItem != null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                        ],
                      ),
                          ))
                          .toList(),
                    ),
                  ),
                  error: (error, stackTrace) => const Text('Some error occured'),
                  loading: () => Container(
                      height: MediaQuery.of(context).size.height - 200,
                      alignment: Alignment.center,
                      child: CustomIndicator('Comm_Gene_0001'.tr())),
                );
              },
            ),
          ),
          loadingScreen()
        ],
      ),
    );
  }
}