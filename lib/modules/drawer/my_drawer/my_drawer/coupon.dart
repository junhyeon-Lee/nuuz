import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_drawer/userproduct.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/faq_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Coupon extends ConsumerStatefulWidget {
  const Coupon({Key? key}) : super(key: key);

  @override
  ConsumerState<Coupon> createState() => _CouponState();
}

UserProduct? certifiedUserProduct;

class _CouponState extends ConsumerState<Coupon> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      safePrint('api 호출');
      await ref.watch(userProductProvider.notifier).getUserProduct();

      final productList = ref.watch(userProductProvider);
      if(productList!=null){
        for(int i=0; i<productList!.userProduct.length; i++){

          if(productList.userProduct[i].product_code!=null){
            certifiedUserProduct = productList.userProduct[i];
          }

        }
      }



    });
  }
  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(userProductProvider);
    return Scaffold(
      appBar: SimpleAppbar(
        context: context,
        title: 'Side_Main_0008'.tr(),
          isHelp: true
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            hSize(16),
            productList==null?const Center(child: CustomIndicator('loading...'),):
                productList.userProduct==null?const NoItemFound(title: '쿠폰이 없습니다.', icon: IconPath.noPostIcon):
                productList!.userProduct.isEmpty?  const NoItemFound(title: '쿠폰이 없습니다.', icon: IconPath.noPostIcon):
                certifiedUserProduct?.product_code==null?const NoItemFound(title: '쿠폰이 없습니다.', icon: IconPath.noPostIcon):
            CustomContainer(
              width: double.infinity,radius: 12,
              containerColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Prod_Poin_0033".tr(),style: CustomTextStyle.headerS,),
                      ],
                    ),
                    // hSize(15),
                    // Row(crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Prod_Poin_0019'.tr(),style: CustomTextStyle.headerXS.copyWith(color: CustomColor.lightDark),),
                    //     Text('2023. 05. 15 ~ 2023. 05. 21',style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.primary),),
                    //
                    //   ],
                    // ),
                    hSize(20),
                    CustomContainer(width: double.infinity, height: 48.h,
                    containerColor: CustomColor.cultured,
                      child: Center(child:   Text(

                        "${certifiedUserProduct!.product_code?.substring(0, 4)}-${certifiedUserProduct!.product_code?.substring(4, 8)}-${certifiedUserProduct!.product_code?.substring(8,  certifiedUserProduct!.product_code?.length)}"
                            ??"",style: CustomTextStyle.headerS,),),
                    ),
                    hSize(35),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      GestureDetector(
                        onTap: () async {
                          await Clipboard.setData( ClipboardData(text: certifiedUserProduct?.product_code));
                          AppToast.toastMessage(
                              message: '쿠폰 코드가 복사되었습니다.');
                        },
                        child: CustomContainer(
                          width: 120.w, height: 48.h, containerColor: CustomColor.white,
                          borderColor: CustomColor.dark,
                          child:  Center(child: Text('Comm_Gene_0058'.tr(),style: CustomTextStyle.buttonM,),),
                        ),
                      ),
                        wSize(12),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData( ClipboardData(text: certifiedUserProduct?.product_code));
                            final url = Uri.parse(
                              'https://nuuz.co.kr/exec/front/newcoupon/IssueDownload?coupon_no=6076156330000000056&opener_url=%2Findex.html',
                            );
                            if (await canLaunchUrl(url)) {
                            launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                            // ignore: avoid_print
                            print("Can't launch $url");
                            }
                          },
                          child: CustomContainer(
                            width: 120.w, height: 48.h, containerColor: CustomColor.primary,
                            child: Center(child: Text('Devi_Mana_0002'.tr(),style: CustomTextStyle.buttonM.copyWith(color:Colors.white)),),
                          ),
                        ),
                      ],
                    ),
                    hSize(18)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


