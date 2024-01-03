import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/ui/common_widget/common_app_bar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/util/log_print.dart';

import 'care_program_controller.dart';

class CareProgramListScreen extends ConsumerStatefulWidget {
  const CareProgramListScreen({super.key, this.onTapItem, this.reservationDate});

  final Function? onTapItem;
  final String? reservationDate;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CareProgramListScreenState();
}

class _CareProgramListScreenState extends ConsumerState<CareProgramListScreen> {
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
                          .map((e) => Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: widget.onTapItem == null
                                              ? () async {
                                            ref.watch(loadingProvider.notifier).isLoadingTrue();
                                            var selectProgram = await ref.read(programController.notifier).getProgramByID(e.id.toString());
                                            await ref.watch(careProgramProvider.notifier).setProgramData(selectProgram!);
                                            context.pop();
                                                  context.pushNamed('program-details', queryParams: {
                                                    "care_program_id": e.id.toString(),
                                                    "reservation_date": widget.reservationDate
                                                  });
                                            ref.watch(loadingProvider.notifier).isLoadingFalse();
                                                }
                                              : () async {
                                            ref.watch(loadingProvider.notifier).isLoadingTrue();
                                            var selectProgram = await ref.read(programController.notifier).getProgramByID(e.id.toString());
                                            await ref.watch(careProgramProvider.notifier).setProgramData(selectProgram!);

                                                  widget.onTapItem!(e);
                                            ref.watch(loadingProvider.notifier).isLoadingFalse();
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
