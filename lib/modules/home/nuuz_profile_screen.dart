import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/product/controller/product_controller.dart';
import 'package:nuuz/modules/product/model/product_model.dart';
import 'package:nuuz/modules/product/product_detail_screen.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';

class NuuzProfileScreen extends ConsumerStatefulWidget {
  const NuuzProfileScreen({super.key});

  @override
  ConsumerState<NuuzProfileScreen> createState() => _NuuzProfileScreenState();
}

class _NuuzProfileScreenState extends ConsumerState<NuuzProfileScreen> with AutomaticKeepAliveClientMixin<NuuzProfileScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   ref.watch(getProductProvider.notifier).getProgram();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(getProductProvider);
    super.build(context);

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSize(10),
            bannerView(),
            hSize(12),
            productList == null ? Center(child: CustomIndicator('Comm_Gene_0001'.tr())) : popularProductView(productList, context, null),
            // hSize(12),
            // mileageShopView(),
            hSize(12),
            productList == null ? Center(child: CustomIndicator('Comm_Gene_0001'.tr())) : productView(productList, context, null),
          ],
        ),
      ),
    );
  }

  Widget popularProductView(ProductModel productList, BuildContext context, int? length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       titleView(title: 'Prod_Main_0004'),
        // SizedBox(
        //   height: 168.h,
        //   child: ListView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20.w),
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     itemBuilder: (context, i) {
        //       return productList.product?[i].is_recommended==1?Padding(
        //         padding: EdgeInsets.only(right: 14.w),
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.all(Radius.circular(14)),
        //           child: GestureDetector(
        //             onTap: () async {
        //               if(productList.product?[i].url!=null){
        //                 final url = Uri.parse(
        //                   productList.product![i].url!,
        //                 );
        //                 if (await canLaunchUrl(url)) {
        //                   launchUrl(url, mode: LaunchMode.externalApplication);
        //                 } else {
        //                   // ignore: avoid_print
        //                   print("Can't launch $url");
        //                 }
        //               }
        //
        //               // Navigator.of(context).push(
        //               //   MaterialPageRoute(
        //               //     builder: (context) => NuuzProductDetail(
        //               //       product: productList.product![i],
        //               //     ),
        //               //   ),
        //               // );
        //
        //             },
        //             child: CachedNetworkImage(
        //               imageUrl: productList.product?[i].image!.first ?? '',
        //               placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        //               errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
        //              height: 168.h,fit: BoxFit.fitHeight,
        //             ),
        //           ),
        //         ),
        //       ):Container();
        //     },
        //     itemCount: productList.product!.length,
        //     // separatorBuilder: (BuildContext context, int index) {
        //     //   return SizedBox(
        //     //     width: 12.w,
        //     //   );
        //     // },
        //   ),
        // ),

        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              productList.product?[0].is_recommended==1?ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: GestureDetector(
                  onTap: () async {
                    if(productList.product?[0].url!=null){
                      final url = Uri.parse(
                        productList.product![0].url!,
                      );
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: productList.product?[0].image!.first ?? '',
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    width: 168.w,fit: BoxFit.fitWidth,
                  ),
                ),
              ):Container(),
            //  wSize(14.w),
              productList.product?[1].is_recommended==1?ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: GestureDetector(
                  onTap: () async {
                    if(productList.product?[1].url!=null){
                      final url = Uri.parse(
                        productList.product![1].url!,
                      );
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: productList.product?[1].image!.first ?? '',
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    height: 168.w,fit: BoxFit.fitWidth,
                  ),
                ),
              ):Container()
            ],
          ),
        ),

      ],
    );
  }

  Widget bannerView() {
    return Container(
      height: 142.h,
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(IconPath.bannerIcon),
          ),
          Positioned(
            left: 15.w,
            top: 10.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Home_Main_0001".tr(),
                    style: CustomTextStyle.textStyle(fontSize: 12.3.sp, color: CustomColor.dark.withOpacity(0.9)),
                    children: <TextSpan>[
                      TextSpan(
                        text: " nuuz",
                        style: CustomTextStyle.textStyle(fontSize: 12.3.sp, color: CustomColor.dark, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: SizedBox(height: 24.h, child: Image.asset(IconPath.bannerLogo)),
                ),

                Text(
                  "Prod_Main_0000".tr(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(
                      color: CustomColor.dark, fontWeight: FontWeight.w400, fontSize: 14.sp, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mileageShopView() {
    List<String> imageList = [
      'https://nuuz-image-storage.s3.amazonaws.com/product/product_nuuz_me.png',
      'https://nuuz-image-storage.s3.amazonaws.com/product/product_nourising.png',
      'https://nuuz-image-storage.s3.amazonaws.com/product/product_boost_up.png'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleView(
            title: 'Prod_Mile_0000',
            title2: 'Comm_Gene_0010',
            onTap: () {
              context.goNamed('/MileageShopSeeAllScreen');
            }),
        SizedBox(
          height: 202.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Image.network(
                imageList[i + 1],
                fit: BoxFit.fill,
              );
            },
            itemCount: 2,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 12.w,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget titleView({required String title, String? title2, VoidCallback? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title.tr(),
            style: CustomTextStyle.headerM,
          ),
        ),
        // InkWell(
        //   onTap: onTap,
        //   child: Text(
        //     (title2 ?? '').tr(),
        //     style: CustomTextStyle.boldTextStyle(
        //       fontSize: 16.sp,
        //       color: CustomColor.primary,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

Widget productView(ProductModel productList, BuildContext context, int? length) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title: 'Comm_Gene_0011'),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20.w),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return productList.product![i].status=="active"?GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NuuzProductDetail(
                    product: productList.product![i],
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: productList.product?[i].image![0] ?? '',
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        height: 100.w,
                        width: 100.w,fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: productList.product?[i].image![1] ?? '',
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              width: 200.w,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(width: 200.w,
                              child: Text(
                                productList.product?[i].name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.descriptionL,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ):Container();
        },
        itemCount: length ?? productList.product?.length ?? 0,

      ),
    ],
  );
}

class NuuzProductDetail extends StatelessWidget {
  const NuuzProductDetail({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppbar(
          title: product.name ?? "",
          context: context,
        ),
        body: Center(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    onLinkTap: (url, _, __, ___) async {
                      safePrint('링크탭');
                      safePrint(url);
                      if(url!=null){
                        final parsedUrl = Uri.parse(
                          url,
                        );
                        if (await canLaunchUrl(parsedUrl)) {
                          launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
                        } else {
                          // ignore: avoid_print
                          print("Can't launch $parsedUrl");
                        }
                      }
                    },
                    data: product.html?.
                    replaceAll("</figure><figure class=\"image\">", "<br>").
                    replaceAll("<blockquote>", "").
                    replaceAll("<figure class=\"image\">", "").
                    replaceAll("</figure>", "").
                    replaceAll("</blockquote>", ""),
                    //shrinkWrap: true,
                    style: {
                      'body': Style(
                        padding: EdgeInsets.zero,
                        margin: Margins(
                          bottom: Margin.zero(),
                          left: Margin.zero(),
                          top: Margin.zero(),
                          right: Margin.zero(),
                        ),
                      )
                    },
                  ),
                  hSize(20),
                  // purchaseProductButton(),
                  hSize(10),
                ],
              ),
            ),
          ),
        ));
  }

  Widget purchaseProductButton(){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        final url = Uri.parse(
          product.url!,
        );
        if (await canLaunchUrl(url)) {
          launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          // ignore: avoid_print
          print("Can't launch $url");
        }
      },
      child: CustomContainer(
        width: double.infinity, height: 140.h, radius: 12,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('디바이스 / 단품',style: CustomTextStyle.descriptionS,),
                    ],
                  ),
                  hSize(6),
                  Text(product.name!,style: CustomTextStyle.headerS,),

                ],
              ),

              CustomContainer(width: 280.w, height: 44.h, radius: 13,borderColor: CustomColor.dark,
                child: Center(child: Text('Prod_Main_0007'.tr(),style: CustomTextStyle.buttonM,),),
              )
            ],
          ),
        ),

      ),
    );
  }
}
