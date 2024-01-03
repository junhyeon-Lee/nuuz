import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/connection/connection/connection_bottomsheet.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/face_detection_ios/arkit_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/sign/terms_conditions/terms_condition_controller.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/common_scroll_view.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/common_widget/rest_period_warning_bottom_sheet.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../care_program/face_detection_ios/arkit_screen_2mm.dart';

class CautionWarningScreen extends ConsumerStatefulWidget {
  final int careProgramId;
  final String userCareProgramId;
  final String isCreated;

  const CautionWarningScreen({super.key, required this.careProgramId, required this.userCareProgramId, required this.isCreated});

  @override
  ConsumerState<CautionWarningScreen> createState() => _CautionWarningScreenState();
}

class _CautionWarningScreenState extends ConsumerState<CautionWarningScreen> {
  String createdUserCareId = '';
  bool isChecked = false;

  // final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(loadingProvider.notifier).isLoadingTrue();
      await ref.watch(formProvider.notifier).getForms();
      safePrint(ref.watch(formProvider.notifier).caution);
      ref.watch(loadingProvider.notifier).isLoadingFalse();

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _scrollController.dispose();
    super.dispose();
  }

  String? userProgramId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final program = ref.watch(careProgramProvider);
          return NuuzContainer(
            containerColor: CustomColor.lightWhite,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SimpleAppbar(
                    title: 'Comm_Gene_0029'.tr(),
                    context: context,
                  ),
                  CustomContainer(
                    radius: 12,
                    containerColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(IconPath.programCaution),
                              wSize(8),
                              Text(
                                'Guid_Serv_0022'.tr(),
                                style: CustomTextStyle.descriptionM.copyWith(color: const Color(0xffFF4E4E), decoration: TextDecoration.none),
                              )
                            ],
                          ),
                          hSize(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                IconPath.caution3mm,
                                width: 160.w,
                              ),
                              Image.asset(
                                IconPath.caution2mm,
                                width: 160.w,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  hSize(12),
                  Expanded(
                    child: Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final caution = ref.watch(formProvider).caution;
                        return Visibility(
                          visible: caution != '',
                          child: NuuzContainer(
                            child: ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: CommonScrollView(
                                    text: caution == ''
                                        ? '사용 시 주의사항\n'
                                            '1. 사용 전\n'
                                            '- 시술 3일 전부터 피부에 자극을 줄 수 있는 제품을 사용하지 마십시오.\n'
                                            '- 시술 전, 클렌저를 사용하여 부드럽게 세안 하십시오.\n'
                                            '- 세안 후, 물기가 없는 상태에서 사용하십시오.\n'
                                            '- 피부 미용 목적과 권장 부위에만 사용하십시오.\n'
                                            '- 반드시 뉴즈 부스트 업 젤 크림과 함께 사용하세요. (젤 크림 미 사용 시 화상 위험 있음)\n'
                                            '2. 사용 후\n'
                                            '- 시술 후 사우나나 찜질방에 가지 마십시오.\n'
                                            '- 시술 후에는 적어도 일주일 내에는 각질 제거 등을 하지 마십시오.\n'
                                            '- 직사광선에 바로 노출되지 않도록 하십시오.\n'
                                            '- 제품 사용 후 어린이 손에 닿지 않는 곳에 보관하십시오.\n'
                                            '- 제품을 사용한 후에는 제품에 묻은 뉴즈 부스트 업 젤 크림을 제거해 주십시오.\n'
                                            '제품 미 사용시\n'
                                            '- 전원 ON 후 2분이상 사용하지 않을 경우, 자동으로 전원이 OFF 됩니다.\n'
                                            '제품 사용 / 보관 방법\n'
                                            '사용 조건 : 10ºc ~ 40ºc\n'
                                            '보관 조건	 : 5ºc ~ 60ºc\n'
                                            '※ 0ºc이하에서 보관할 경우 카트리지가 동파 될 우려가 있으므로 주의하십시오.\n'
                                            '1. 직사광선이나 온도 및 습도가 높은 곳을 피해 보관해 주십시오.\n'
                                            '2. 제품 사용 후 이물질(제품에 묻은 젤)이 남아있지 않도록 물티슈 및 부드러운 천으로 닦아 보관합니다.\n'
                                            '3. 강한 화학제품(ex. 알코올)은 제품의 표면을 변질시킬 수 있으니 사용하지 마십시오.\n'
                                            '4. 외부 충격이나 압력으로 제품이 손상되거나 파손될 수 있으니 안전하게 보관해 주시기 바랍니다.\n'
                                            '5. 아이들 손이 닿지 않는 장소에 보관해 주십시오.\n'
                                            '6. 휘발성 물질을 제품 근처에 놓아두지 마십시오.\n'
                                            '7. 장시간 사용하지 않은 후 재사용 시에는 안전하게 정상 작동되는지 확인하시고 사용해 주세요.\n'
                                            '8. 배터리 과방전을 방지하기 위하여 최소 3개월에 한번씩은 배터리를 충전하여 주십시오. 배터리가 완전 방전 상태로 오랜 기간 사용하지 않으면 배터리 수명이 감소할 수 있습니다.\n'
                                            '9. 전원이 켜지지 않거나 전원이 켜진 후 곧바로 꺼지는 경우 배터리가 방전된 것이므로 충전 후 사용하십시오.\n'
                                            '배터리가 완전 방전된 경우 충전시간이 정상의 경우 보다 다소 오래 걸릴 수 있습니다.\n'
                                            '주의\n'
                                            '1. 사용 전 사용설명서를 반드시 숙지하시기 바랍니다.\n'
                                            '2. 해당 제품은 얼굴 및 목(지정된 목의 일부)관리를 위한 것입니다. 지정된 부위 외 다른 신체 부위에 사용하시거나, 부적절한 사용에 따라 발생한 해로운 결과에 대해 책임지지 않습니다.\n'
                                            '3. 취급 시 떨어뜨리거나 강한 충격을 주지 마십시오.\n'
                                            '4. 미용기구나 온열기 등과 같은 다른 전기제품과 동시에 사용하지 마십시오.\n'
                                            '5. 욕실, 부엌, 차 안 등 온도가 높은 곳이나 먼지가 많은 곳에서의 사용을 금하여 주십시오. 기기의 수명을 줄이고 고장의 원인이 됩니다.\n'
                                            '6. 장시간 사용하지 않은 후 재사용 전에는 안전 여부를 확인하신 후 사용하십시오.\n'
                                            '7. 사용할 때는 미용 기기나 TV,오디오 등의 전기제품과는 거리를 두시고, 한 콘텐트에 여러 플러그를 꽂아 두지 마십시오.\n'
                                            '8. 심한 충격을 주거나 제품을 개조, 분해, 수리하지 마십시오.\n'
                                            '9. 제품 위에 무거운 것, 물, 음료수는 놓지 마십시오.\n'
                                            '10. 전원코드를 콘센트에 꽂거나 뺄 때는 물기가 없는 손으로 플러그를 잡고 꽂거나 뽑아 주십시오.\n'
                                            '11. 각 구성품은 자사에서 제공된 제품을 사용하십시오.\n'
                                            '12. 칼 등 날카로운 물체에 노출되지 않게 하십시오. 필름이 찢어지거나, 고장의 원인이 될 수 있습니다.\n'
                                            '13. 상처 부위나 상처치유 과정에 영향을 줄 수 있는 전신/국부적 피부질환이 있는 경우 사용하지 마십시오.\n'
                                            '14. 최근 전문의료기관 (심혈관, 신경계, 피부 등)에서 시술 혹은 수술받으셨거나, 이식형 의료기기 장착 자, 금속 보철 장치 착용자는 전문의와 상담 후 사용하시길 권장해 드립니다.\n'
                                            '15. 필러 또는 자가 지방을 이식한 부위에는 사용하지 마십시오.\n'
                                            '16. 시술 시 에너지 강도를 조절하여 사용하시고, 같은 곳에 중복으로 사용하지 마십시오. (중복 사용 시 화상 위험 있음)\n'
                                            '17. 시술 시 뉴즈 부스트 업 젤 크림을 도포 후 카트리지 검정 필름 부분과 피부를 밀착시켜 사용하십시오.\n'
                                            '18. 반드시 뉴즈 부스트 업 젤 크림과 함께 사용하세요. (젤 크림 미사용시 화상을 유발할 수 있습니다.)\n'
                                            '19. 2mm카트리지 사용 시에는 SHOT버튼을 누르고 있는 동안에만 초음파가 사용되며, 반드시 기기를 이동하면서 SHOT을 적용하시기 바랍니다. (한곳에 머물러서 SHOT적용 시 화상 위험 있음)\n'
                                            '20. 세안 또는 목욕 시에는 사용하지 마십시오.\n'
                                            '21. 허공이나 피부가 아닌 곳에 조사할 경우 카트리지 과열의 우려가 있으니 주의하십시오.\n'
                                            '경고\n'
                                            '다음에 해당하는 사람 또는 환부에는 사용하지 마십시오.\n'
                                            '1. 최근 수술로 인해 흉터 또는 수술 자국이 있는 분\n'
                                            '2. 중증 모낭성 여드름 및 민감 피부\n'
                                            '3. 급성 질환자\n'
                                            '4. 사용 부위에 금속 스텐트가 있는 경우\n'
                                            '5. 인체 내 금속 이식 환자 또는 임플란트 환자\n'
                                            '6. 모세혈관 확장 증세가 있는 분\n'
                                            '7. 상처 치유 과정에 영향을 줄 수 있는 전신, 국부적 피부 질병이 있을 경우\n'
                                            '8. 간질 또는 발작과 같은 병력이 있는 분\n'
                                            '9. 안면신경 등이 손상된 분\n'
                                            '10. 암 또는 (뇌)경색 등이 있는 분\n'
                                            '11. 어린이, 임산부, 수유 중인 여성\n'
                                            '위험\n'
                                            '- 인공심박조율기 등의 체내 삽입형 의료용 전기기기 사용자\n'
                                            '- 인공 심폐 등의 생명 유지용 전기기기 사용자\n'
                                            '- 심전계 등의 장착형 의료용 전기기기 사용자\n'
                                            '- 인슐린 펌프 등 체외 부착형 의료기기 사용자\n'
                                            '- 금속, 플라스틱, 실리콘 등이 삽입_된 신체 부위\n'
                                            '※ 제조사는 사용자의 귀책사유로 인해 발생하는 제품상의 문제 및 기타 손상에 대하여 책임을 지지 않습니다.\n'
                                        : caution!.replaceAll('\\n', '\n'))),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Material(
                    child: CheckboxListTile(
                      activeColor: CustomColor.primary,
                      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isChecked,
                      onChanged: (value) => setState(() {
                        isChecked = !isChecked;
                      }),
                      title: LargeDescriptionText(text: 'Guid_Serv_0001'.tr()),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CommonButton(
                      onPressed: isChecked && program?.id != null ? () => showStartBottomSheet(context, widget.careProgramId) : null,
                      //  onPressed: isChecked ? () => context.goNamed('player-screen') : null,
                      text: 'Comm_Gene_0030'.tr()),
                  SizedBox(height: 8.h),
                ],
              ),
              //   SizedBox(height: 24.h),
              //   Expanded(
              //     child: NuuzContainer(
              //       child: ScrollConfiguration(
              //           behavior: const ScrollBehavior().copyWith(overscroll: false),
              //           child: const CommonScrollView(
              //             text: 'This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch.',
              //           )),
              //     ),
              //   ),
              //   SizedBox(height: 60.h),
              //   Material(
              //     child: CheckboxListTile(
              //       activeColor: CustomColor.primary,
              //       checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              //       controlAffinity: ListTileControlAffinity.leading,
              //       value: isChecked,
              //       onChanged: (value) => setState(() {
              //         isChecked = !isChecked;
              //       }),
              //       title: LargeDescriptionText(text: 'Guid_Serv_0001'.tr()),
              //     ),
              //   ),
              //   SizedBox(height: 24.h),
              //   CommonButton(
              //       onPressed: isChecked ? () => showStartBottomSheet(context, widget.careProgramId) : null,
              //       //  onPressed: isChecked ? () => context.goNamed('player-screen') : null,
              //       text: 'Comm_Gene_0030'.tr()),
              //   SizedBox(height: 8.h),
              // ],
            ),
          );
        }),
        loadingScreen(),
      ],
    );
  }

  Future<void> showStartBottomSheet(context, var careProgramId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    Future<String> startGuideCareProgram() async {
      String initialPart = '';
      Map<String, dynamic> userCareProgramData = <String, dynamic>{
        "program_id": widget.careProgramId.toString(),
        "start_day": DateFormat('E').format(today),
        "start_date": today.toIso8601String(),
        "status": "created",
        //  "force" :true   ///this line///
      };
      try {
        userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
        await ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
        ref.invalidate(userCareProgramProvider);
        ref.invalidate(userCareProgramForDateRangeProvider);
      } catch (e) {
        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => _errorBottomSheet(e, userCareProgramData),
        );
      }
      if (userProgramId != null) {
        ref.watch(careIdProvider.notifier).setProgram(widget.careProgramId.toString());
        safePrint('8');
        ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
        final program = ref.watch(careProgramProvider);
        initialPart = ref.watch(partGroupProvider.notifier).setPartGroup(program!);
        await ref.watch(guildImageProvider.notifier).setGuideImage(initialPart, 1);
        await ref.watch(guideAnimationProvider.notifier).setGuideImage(initialPart);
        await ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(initialPart);
      }
      return initialPart;
    }

    Future<String> startCreatedGuideCareProgram() async {
      String initialPart = '';
      ref.watch(careIdProvider.notifier).setProgram(widget.careProgramId.toString());
      safePrint('1');
      ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
      final program = ref.watch(careProgramProvider);
      initialPart = ref.watch(partGroupProvider.notifier).setPartGroup(program!);
      await ref.watch(guildImageProvider.notifier).setGuideImage(initialPart, 1);
      await ref.watch(guideAnimationProvider.notifier).setGuideImage(initialPart);
      await ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(initialPart);
      return initialPart;
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: CustomColor.dark.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final connectedDevice = ref.watch(connectProvider);
              return ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      leading: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: SvgPicture.asset(IconPath.close)),
                      title: Text(
                        '안내',
                        style: CustomTextStyle.headerL,
                      ),
                    ),
                    Container(
                      width: 346,
                      height: 1.h,
                      color: const Color(0xffebeae9),
                    ),
                    hSize(20),
                    if (careProgramId != 2)
                      GestureDetector(
                        onTap: connectedDevice == null
                            ?
                            // () async {
                            //     showConnection(context);
                            //   }
                                () async {
                            if (ref.watch(loadingProvider) == false) {
                            ref.watch(loadingProvider.notifier).isLoadingTrue();
                            String initialPart;
                            if (widget.isCreated == "true") {
                            initialPart = await startCreatedGuideCareProgram();
                            wantPart = initialPart;
                            wantLine =1;
                            ios2mmAction(initialPart);
                            } else {
                            initialPart = await startGuideCareProgram();
                            wantPart = initialPart;
                            wantLine =1;
                            ios2mmAction(initialPart);
                            }

                            context.pushNamed('careProgramScreen', queryParams: {
                            "initial_part": initialPart,
                            });
                            ref.watch(loadingProvider.notifier).isLoadingFalse();
                            }
                            }
                            : () async {
                                if (ref.watch(loadingProvider) == false) {
                                  ref.watch(loadingProvider.notifier).isLoadingTrue();
                                  String initialPart;
                                  if (widget.isCreated == "true") {
                                    initialPart = await startCreatedGuideCareProgram();
                                    wantPart = initialPart;
                                    wantLine = 1;
                                    ios2mmAction(initialPart);
                                  } else {
                                    initialPart = await startGuideCareProgram();
                                    wantPart = initialPart;
                                    wantLine = 1;
                                    ios2mmAction(initialPart);
                                  }

                                  context.pushNamed('careProgramScreen', queryParams: {
                                    "initial_part": initialPart,
                                  });
                                  ref.watch(loadingProvider.notifier).isLoadingFalse();
                                }
                              },
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                                padding: EdgeInsets.all(12.w),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(13),
                                    ),
                                    color: CustomColor.cultured),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomContainer(
                                      width: 96.w,
                                      height: 96.h,
                                      child: Image.asset(IconPath.totalCare),
                                    ),
                                    wSize(12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        hSize(5),
                                        Text(
                                          'Care_Main_0005'.tr(),
                                          style: CustomTextStyle.headerXS,
                                        ),
                                        hSize(12),
                                        SizedBox(
                                          width: 200.w,
                                          child: RichText(
                                              maxLines: 3,
                                              text: TextSpan(
                                                text: 'Care_Main_0006'.tr(),
                                                style: CustomTextStyle.descriptionS.copyWith(overflow: TextOverflow.ellipsis),
                                              ),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
                      ),
                    hSize(8),
                    if (careProgramId < 5)
                      GestureDetector(
                        onTap: () async {
                          if (ref.watch(loadingProvider) == false) {
                            ref.watch(loadingProvider.notifier).isLoadingTrue();
                            if (widget.isCreated == "true") {
                              safePrint('생성된 케어 프로그램 그거입니다.');
                              ref.watch(careIdProvider.notifier).setProgram(widget.careProgramId.toString());
                              safePrint('2');
                              ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
                              safePrint('@@@@@@@@@@@@');
                              context.pushNamed('player-screen', queryParams: {
                                "care_program_id": (widget.careProgramId ?? careProgramId).toString(),
                                "user_care_program_id": widget.userCareProgramId,
                              });
                              safePrint('@@@@@@@@@@@@');
                            } else {
                              safePrint('생성되지 않은 케어 프로그램 그거입니다.');
                              safePrint('@@@@@@@@@@@@');
                              Map<String, dynamic> userCareProgramData = <String, dynamic>{
                                "program_id": widget.careProgramId.toString(),
                                "start_day": DateFormat('E').format(today),
                                "start_date": today.toIso8601String(),
                                "status": "created",
                                //  "force" :true   ///this line///
                              };
                              safePrint('@@@@@@@@@@@@');
                              try {
                                safePrint('생성되지 않은 케어 프로그램 그거입니다.');
                                userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
                                safePrint('3');
                                await ref.watch(userCareIdProvider.notifier).setProgram(userProgramId ?? "");
                                safePrint(ref.watch(userCareIdProvider));
                                safePrint('???');
                                ref.invalidate(userCareProgramProvider);
                                ref.invalidate(userCareProgramForDateRangeProvider);
                                safePrint('@@@@@@@@@@@@1');
                              } catch (e) {
                                await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => _errorBottomSheet(e, userCareProgramData),
                                );
                              }
                              if (userProgramId != null) {
                                ref.watch(careIdProvider.notifier).setProgram(widget.careProgramId.toString());
                                safePrint('4');
                                ref.watch(userCareIdProvider.notifier).setProgram(userProgramId ?? "");
                                context.pushNamed('player-screen', queryParams: {
                                  "care_program_id": (widget.careProgramId ?? careProgramId).toString(),
                                  "user_care_program_id": widget.userCareProgramId,
                                });
                              }
                            }
                            ref.watch(loadingProvider.notifier).isLoadingFalse();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                              padding: EdgeInsets.all(12.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(13),
                                  ),
                                  color: CustomColor.cultured),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomContainer(
                                    width: 96.w,
                                    height: 96.h,
                                    child: Image.asset(IconPath.videoGuide),
                                  ),
                                  wSize(12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      hSize(5),
                                      Text(
                                        'Care_Main_0007'.tr(),
                                        style: CustomTextStyle.headerXS,
                                      ),
                                      hSize(12),
                                      SizedBox(
                                        width: 200.w,
                                        child: RichText(
                                            maxLines: 3,
                                            text: TextSpan(
                                              text: 'Care_Main_0008'.tr(),
                                              style: CustomTextStyle.descriptionS.copyWith(overflow: TextOverflow.ellipsis),
                                            ),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                    hSize(20),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 320.w,
                        height: 44.h,
                        decoration:
                            BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(13)), border: Border.all(color: CustomColor.dark)),
                        child: Center(
                          child: Text(
                            '취소',
                            style: CustomTextStyle.buttonM,
                          ),
                        ),
                      ),
                    ),
                    hSize(30)
                  ],
                ),
              );
            },
          );
        });
  }

  Widget _errorBottomSheet(e, Map userCareProgramData) {
    if ((e as DioError).response?.data['response'] != null) {
      if (e.response?.data['response'] == 'restPeriod in progress') {
        return RestPeriodWarningBottomSheet(
          onSecondaryButtonTap: () async {
            userCareProgramData.addAll(<String, dynamic>{"force": true});
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
            safePrint('5');
            await ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
            ref.invalidate(userCareProgramProvider);
            ref.invalidate(userCareProgramForDateRangeProvider);
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
            userCareProgramData.addAll(<String, dynamic>{"force": true});
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
            safePrint('6');
            await ref.watch(userCareIdProvider.notifier).setProgram(widget.userCareProgramId ?? "");
            ref.invalidate(userCareProgramProvider);
            ref.invalidate(userCareProgramForDateRangeProvider);
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
}
