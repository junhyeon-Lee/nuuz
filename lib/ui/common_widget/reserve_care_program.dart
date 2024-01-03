import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class ReserveCareProgram extends StatelessWidget {
  const ReserveCareProgram({
    super.key,
    required this.titleVisible,
    this.reservationDate,
  });

  final bool titleVisible;
  final String? reservationDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleVisible
            ? Column(
                children: [
                  Text(
                    'Home_Main_0003'.tr(),
                    style: CustomTextStyle.headerM,
                  ),
                  hSize(20),
                ],
              )
            : Container(),
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    hSize(25),
                    SizedBox(
                      width: 270.w,
                      height: 40.h,
                      child: Text(
                        'Prog_Rese_0000'.tr(),
                        style: CustomTextStyle.descriptionM,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    hSize(17),
                    SizedBox(
                      width: 250.w,
                      height: 44.h,

                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final userProduct = ref.watch(userProductController);
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: userProduct.isNotEmpty
                                ? () {
                                    context.pushNamed('program-list', queryParams: {
                                      'reservation_date': reservationDate,
                                    });
                                  }
                                : () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => CommonMessageBottomSheet(
                                        headerText: "Comm_Gene_0002".tr(),
                                        descriptionText: "Care_Main_0000".tr(),
                                        primaryButtonText: "Comm_Gene_0035".tr(),
                                        secondaryButtonText: "Comm_Gene_0015".tr(),
                                        onSecondaryButtonPressed: () {
                                          context.goNamed('/DeviceScreenHome');
                                        },
                                      ),
                                    );
                                  },
                            child: Container(
                              width: 250.w,
                              height: 44,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: CustomColor.dark)),
                              child: Center(
                                  child: Text(
                                DateFormat("yyyy MM dd").format(DateTime.now()) == DateFormat("yyyy MM dd").format(DateTime.parse(reservationDate!))
                                    ? 'Comm_Gene_0008'.tr()
                                    : 'Comm_Gene_0016'.tr(),
                                style: CustomTextStyle.buttonM,
                              )),
                            ),
                          );
                        },
                      ),

                      // child: OutlinedButton(
                      //   onPressed: () {
                      //     context.pushNamed('program-list',
                      //     queryParams: {
                      //       'reservation_date': reservationDate,
                      //     });
                      //   },
                      //   child:DateFormat("yyyy MM dd").format(DateTime.now())==DateFormat("yyyy MM dd").format(DateTime.parse(reservationDate!))?
                      //   Text(
                      //     'Comm_Gene_0008'.tr(),
                      //     style: CustomTextStyle.buttonM,
                      //   ):Text(
                      //     'Comm_Gene_0016'.tr(),
                      //     style: CustomTextStyle.buttonM,
                      //   ),
                      // ),
                    ),
                    hSize(19)
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
