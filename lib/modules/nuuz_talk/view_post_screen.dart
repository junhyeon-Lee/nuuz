// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/models/my_nuuz/result.dart';

import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/home/nuuz_home/products.dart';
import 'package:nuuz/modules/nuuz_talk/providers/review/reviews_provider.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_app_bar.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class ViewPostScreen extends ConsumerWidget {
  const ViewPostScreen({
    super.key,
    required this.userPost,
    // required this.programs,
    // required this.reviews,
    // required this.products,
  });

  final UserPost userPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = LocalDB().findUserInfo();
    Future<List<Program?>> programs = Future.value([]);
    Future<List<Result?>> reviews = Future.value([]);
    Future<List<Product?>> products = Future.value([]);

    if (userPost.programIds != null) {
      programs = Future.wait(userPost.programIds!.map((e) => ref.read(programController.notifier).getProgramByID(e)));
    }
   /* if (userPost.reviewIds != null) {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();

      reviews = Future.wait(userPost.reviewIds!.map((e) => ref.read(resultProvider.notifier).fetchResultById(e)));
    }*/
    if (userPost.productIds != null) {
      products = Future.wait(userPost.productIds!.map((e) => ref.read(productController.notifier).fetchProductById(e)));
    }
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: NuuzContainer(
              containerColor: CustomColor.background,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: currentUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return loadingScreen();
                          }
                          return CommonAppBar(
                            context: context,
                            title: snapshot.data?.name ?? "",
                            trailing: snapshot.data!.user_id == userPost.userId
                                ? [
                                    SvgPicture.asset(IconPath.editNote)
                                  ]
                                : [
                                    SvgPicture.asset(IconPath.siren)
                                  ],
                          );
                        }),
                    hSize(12),
                    NuuzContainer(
                      child: Column(
                        children: [
                          userPost.imageUrls.first.toLowerCase().contains("http") ? Image.network(userPost.imageUrls.first) : Image.file(File(userPost.imageUrls.first)),
                          hSize(12),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(),
                                    wSize(6),
                                    Text(
                                      "Amelia Johnson",
                                      style: CustomTextStyle.headerS,
                                    ),
                                    Spacer(),
                                    Chip(label: Text(userPost.category.name))
                                  ],
                                ),
                                hSize(6),
                                Text(
                                  userPost.title??"",
                                  style: CustomTextStyle.descriptionM,
                                ),
                                hSize(12),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      IconPath.heartFilled,
                                      color: CustomColor.gray,
                                      height: 16.h,
                                    ),
                                    wSize(4),
                                    Text(userPost.likesCount.toString()),
                                    wSize(12),
                                    SvgPicture.asset(
                                      IconPath.chat,
                                      color: CustomColor.dark,
                                      height: 16.h,
                                    ),
                                    wSize(4),
                                    Text(userPost.commentsCount.toString()),
                                    Spacer(),
                                    Text("20.12.2022"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    hSize(12),
                    FutureBuilder(
                      future: programs,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return loadingScreen();
                        }
                        if (snapshot.data?.isNotEmpty ?? false) {
                          return Column(
                            children: [
                              hSize(12),
                              Text(
                                "Comm_Gene_0039".tr(),
                                style: CustomTextStyle.headerS,
                              ),
                              hSize(12),
                              ...snapshot.data!
                                  .map(
                                    (e) => NuuzContainer(
                                      child: CareProgramListItem(
                                        name: e!.name,
                                        description: e.description,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    FutureBuilder(
                      future: reviews,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return loadingScreen();
                        }
                        if (snapshot.data?.isNotEmpty ?? false) {
                          return Column(
                            children: [
                              hSize(12),
                              Text(
                                "Reviews",
                                style: CustomTextStyle.headerS,
                              ),
                              hSize(12),
                              ...snapshot.data!
                                  .map(
                                    (e) => NuuzContainer(
                                      child: CareProgramListItem(
                                        name: e!.program!.care_program_name!,
                                        description: e.program!.description,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    FutureBuilder(
                      future: products,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return loadingScreen();
                        }
                        if (snapshot.data?.isNotEmpty ?? false) {
                          return Column(
                            children: [
                              hSize(12),
                              Text(
                                "Comm_Gene_0011".tr(),
                                style: CustomTextStyle.headerS,
                              ),
                              hSize(12),
                              ...snapshot.data!
                                  .map(
                                    (e) => productsItem(e)
                                  )
                                  .toList(),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonOutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
                    CommonButton(onPressed: () {}, text: "Complete"),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
