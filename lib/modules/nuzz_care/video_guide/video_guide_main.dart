import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_screen.dart';
import 'package:nuuz/modules/nuzz_care/video_guide/video_guide_page.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class VideoGuideMain extends StatefulWidget {
  const VideoGuideMain({
    super.key,
    required this.careProgramId,
    required this.userCareProgramId,
  });

  final int careProgramId;
  final String userCareProgramId;

  @override
  State<VideoGuideMain> createState() => _VideoGuideMainState();
}

class _VideoGuideMainState extends State<VideoGuideMain> {
  final pageList = [
    {
      'url': 'https://nuuz-image-storage.s3.amazonaws.com/videos/Guide_01_3mm_TotalCare_Face.mp4',
      'header': "Prog_Titl_0005",
      'text': ' 토탈케어 프로그램 3mm – 얼굴 부위\n'
          ' *1주 1회 권장\n'
          '\n'
          ' 사용 전 주의사항\n'
          ' 1. 시술 시 에너지 강도를 조절하여 사용하시고, 같은 곳에 중복으로 사용하지 마십시오.\n'
          ' 2. 반드시 젤 크림을 도포 후 사용하시고, 카트리지 검정 필름 부분과 피부를 밀착하여 사용하십시오. (젤 크림 미사용 시 화상 유발 가능)\n'
          ' ! 눈썹 위 1cm / 미간 중앙 / 코 / 인중 / 턱 뼈 / 입술 / 안구 / 갑상선 부위는 사용을 금합니다.\n'
          '\n'
          ' 1. 볼살 케어 – 수직\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 화살표 방향으로 조금씩 움직이며 1샷씩 쏘세요\n'
          '\n'
          ' 2. 볼살 케어 – 대각선\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 앞광대부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          '\n'
          ' 3. 눈가(눈꼬리) 케어 – 수직/수평\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 옆부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          '\n'
          ' 4. 눈 밑(눈가 뼈 라인 밑) 케어\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 뼈 라인 밑 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 5. 팔자주름 케어\n'
          ' 15 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 입술 사용 금지\n'
          ' 팔자부위의 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 6. 이마 케어\n'
          ' 70 Shot\n'
          ' ※ 눈썹 위 1cm / 미간 중앙 사용 금지\n'
          ' 제품을 화면과 같이 눕힌 다음, 눈썹 끝 위에서 헤어라인 방향으로 1샷씩 쏘세요\n'
          ' 미간 중앙을 제외하고 조금씩 제품을 이동하며 케어하세요\n'
    },
    {
      'url': 'https://nuuz-image-storage.s3.amazonaws.com/videos/Guide_02_3mm_TotalCare_Neck.mp4',
      'header': "Prog_Titl_0006",
      'text': ' 토탈케어 프로그램 3mm – 얼굴 부위\n'
          ' *1주 1회 권장\n'
          '\n'
          ' 사용 전 주의사항\n'
          ' 1. 시술 시 에너지 강도를 조절하여 사용하시고, 같은 곳에 중복으로 사용하지 마십시오.\n'
          ' 2. 반드시 젤 크림을 도포 후 사용하시고, 카트리지 검정 필름 부분과 피부를 밀착하여 사용하십시오. (젤 크림 미사용 시 화상 유발 가능)\n'
          ' ! 눈썹 위 1cm / 미간 중앙 / 코 / 인중 / 턱 뼈 / 입술 / 안구 / 갑상선 부위는 사용을 금합니다.\n'
          '\n'
          ' 1. 볼살 케어 – 수직\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 화살표 방향으로 조금씩 움직이며 1샷씩 쏘세요\n'
          '\n'
          ' 2. 볼살 케어 – 대각선\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 앞광대부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          '\n'
          ' 3. 눈가(눈꼬리) 케어 – 수직/수평\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 옆부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          '\n'
          ' 4. 눈 밑(눈가 뼈 라인 밑) 케어\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 뼈 라인 밑 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 5. 팔자주름 케어\n'
          ' 15 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 입술 사용 금지\n'
          ' 팔자부위의 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 6. 이마 케어\n'
          ' 70 Shot\n'
          ' ※ 눈썹 위 1cm / 미간 중앙 사용 금지\n'
          ' 제품을 화면과 같이 눕힌 다음, 눈썹 끝 위에서 헤어라인 방향으로 1샷씩 쏘세요\n'
          ' 미간 중앙을 제외하고 조금씩 제품을 이동하며 케어하세요\n'
    },
    {
      'url': 'https://nuuz-image-storage.s3.amazonaws.com/videos/Guide_03_2mm_IntensiveCare.mp4',
      'header': "Prog_Titl_0007",
      'text': '집중케어 프로그램 2mm\n'
          '*1주 1회 권장\n'
          '\n'
          ' 사용 전 주의사항\n'
          ' 1. 시술 시 에너지 강도를 조절하여 사용하시고, 같은 곳에 중복으로 사용하지 마십시오.\n'
          ' 2. 반드시 젤 크림을 도포 후 사용하시고, 카트리지 검정 필름 부분과 피부를 밀착하여 사용하십시오. (젤 크림 미사용 시 화상 유발 가능)\n'
          '\n'
          ' ※ 2mm 카트리지 사용 시에는 SHOT 버튼을 누르고 있는 동안에만 초음파가 조사되며, 반드시 기기를 이동하면서 SHOT을 적용하시기 바랍니다. (한 곳에 머물러서 SHOT적용 시 화상 위험 있음)\n'
          ' ! 눈썹 위 1cm / 미간 중앙 / 코 / 인중 / 턱 뼈 / 입술 / 안구 / 갑상선 부위는 사용을 금합니다.\n'
          '\n'
          ' 1. 눈가(눈꼬리)케어\n'
          ' ①~⑤ 약 1분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 1분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 안구 사용 금지\n'
          '  버튼을 누른 채로 눈 밑(앞쪽)에서\n'
          ' 관자놀이를 향해 끌어 올리듯이 사선으로 사용합니다\n'
          '\n'
          ' 1. 팔자주름 케어\n'
          ' ①~⑩ 약 2분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 2분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 입술 사용 금지\n'
          ' 버튼을 누른 채로 팔자 부위 라인을 따라 사선 방향으로 끌어 올리듯이 사용합니다\n'
          '\n'
          ' 1. 이마 케어\n'
          ' ①~⑤ 약 1분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 1분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 눈썹 위 1cm / 미간 중앙 사용 금지\n'
          ' 버튼을 누른 채로 눈썹 위 쪽에서 이마를 향해 끌어 올리듯이 사용합니다 (이마 수직)\n'
          ' 버튼을 누른 채로 안쪽 이마부터 바깥쪽을 향해 밀면서 사용합니다 (이마 수평)\n'
          '\n'
          ' 1. 목 케어\n'
          ' ①~⑩ 약 2분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 2분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 목 중앙 및 갑상선 주변 라인 사용 금지\n'
          ' 버튼을 누른 채로 갑상선을 피해 턱을 향해 끌어 올리듯이 사용합니다\n'
    },
    {
      'url': 'https://nuuz-image-storage.s3.amazonaws.com/videos/Guide_04_3mm2mm_MultiCare.mp4',
      'header': "Prog_Titl_0008",
      'text': '    멀티케어 프로그램 3mm + 2mm\n'
          '  *1주 1회 권장\n'
          '\n'
          ' 사용 전 주의사항\n'
          ' 1. 시술 시 에너지 강도를 조절하여 사용하시고, 같은 곳에 중복으로 사용하지 마십시오.\n'
          ' 2. 반드시 젤 크림을 도포 후 사용하시고, 카트리지 검정 필름 부분과 피부를 밀착하여 사용하십시오. (젤 크림 미사용 시 화상 유발 가능)\n'
          '\n'
          ' ※ 2mm 카트리지 사용 시에는 SHOT 버튼을 누르고 있는 동안에만 초음파가 조사되며, 반드시 기기를 이동하면서 SHOT을 적용하시기 바랍니다. (한 곳에 머물러서 SHOT적용 시 화상 위험 있음)\n'
          ' ! 눈썹 위 1cm / 미간 중앙 / 코 / 인중 / 턱 뼈 / 입술 / 안구 / 갑상선 부위는 사용을 금합니다.\n'
          '\n'
          ' ! 3mm 카트리지로 시작하세요\n'
          '\n'
          ' 1. 볼살 케어 – 수직\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 화살표 방향으로 조금씩 움직이며 1샷씩 쏘세요\n'
          '\n'
          ' 2. 볼살 케어 – 대각선\n'
          ' 40 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' 앞광대부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 샷 버튼을 누른 채로 팔자 부위 라인을 따라 사선 방향으로 끌어 올리듯이 사용합니다\n'
          ' 3. 눈가(눈꼬리) 케어 – 수직/수평\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 옆부터 관자놀이까지 한 칸씩 이동하며 1샷씩 쏘세요\n'
          '\n'
          ' 4. 눈 밑(눈가 뼈 라인 밑) 케어\n'
          ' 10 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 안구 사용 금지\n'
          ' 눈가 뼈 라인 밑 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 5. 팔자주름 케어\n'
          ' 15 Shot\n'
          ' *반대쪽도 동일하게 사용\n'
          ' ※ 입술 사용 금지\n'
          ' 팔자부위의 안쪽에서 바깥쪽으로 한 칸씩 이동하며 1샷씩 쏘세요\n'
          ' 좁은 부위이므로 세밀하게 사용해야 합니다\n'
          '\n'
          ' 6. 이마 케어\n'
          ' 70 Shot\n'
          ' ※ 눈썹 위 1cm / 미간 중앙 사용 금지\n'
          ' 제품을 화면과 같이 눕힌 다음, 눈썹 끝 위에서 헤어라인 방향으로 1샷씩 쏘세요\n'
          ' 미간 중앙을 제외하고 조금씩 제품을 이동하며 케어하세요\n'
          '\n'
          ' ! 2mm 카트리지로 교체하세요\n'
          '\n'
          ' 7. 눈가(눈꼬리)케어\n'
          ' ①~⑤ 약 1분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 1분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 안구 사용 금지\n'
          ' 샷 버튼을 누른 채로 눈 밑(앞쪽)에서\n'
          ' 관자놀이를 향해 끌어 올리듯이 사선으로 사용합니다\n'
          '\n'
          ' 8. 팔자주름 케어\n'
          ' ①~⑩ 약 2분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 2분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 입술 사용 금지\n'
          ' 샷 버튼을 누른 채로 팔자 부위 라인을 따라 사선 방향으로 끌어 올리듯이 사용합니다\n'
          '\n'
          ' 9. 이마 케어\n'
          ' ①~⑤ 약 1분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 1분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 눈썹 위 1cm / 미간 중앙 사용 금지\n'
          ' 샷 버튼을 누른 채로 안쪽 이마부터 바깥쪽을 향해 밀면서 사용합니다 (이마 수평)\n'
          '\n'
          ' 10. 목 케어\n'
          ' ①~⑩ 약 2분 간 사용 권장\n'
          ' *반대쪽도 동일하게 약 2분 간 사용\n'
          ' !한 곳에 머무르지 말고 움직이면서 Shot을 쏘세요\n'
          ' ※ 목 중앙 및 갑상선 주변 라인 사용 금지\n'
          ' 샷 버튼을 누른 채로 갑상선을 피해 턱을 향해 끌어 올리듯이 사용합니다\n'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exitBottomSheet(context),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final userCareProgramId = ref.watch(userCareIdProvider);
          safePrint(userCareProgramId);
          return Scaffold(
            body: NuuzContainer(
              containerColor: CustomColor.background,
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: CustomColor.lightWhite,
                    // leading: GestureDetector(
                    //   onTap: context.pop,
                    //   child: Padding(
                    //       padding: const EdgeInsets.all(12.0),
                    //       child: Icon(
                    //         CupertinoIcons.arrow_left,
                    //         color: CustomColor.dark,
                    //       )),
                    // ),
                    leading: Container(),
                    title: LargeHeaderText(text: 'Care_Main_0007'.tr()),
                    actions: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => CommonMessageBottomSheet(
                                headerText: "Comm_Gene_0005".tr(),
                                descriptionText: "Care_Prog_0020".tr(),
                                primaryButtonText: "Comm_Gene_0006".tr(),
                                secondaryButtonText: "Care_Prog_0021".tr(),
                                onSecondaryButtonPressed: () => context.go('/main'),
                              ),
                            );
                          },
                          icon: SvgPicture.asset(IconPath.setting))
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: VideoGuidePage(
                        url: pageList[widget.careProgramId - 1]['url']!,
                        content: pageList[widget.careProgramId - 1]['text']!,
                        header: pageList[widget.careProgramId - 1]['header']!,
                        counter: widget.careProgramId),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 33.h),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => CommonMessageBottomSheet(
                              headerText: "Comm_Gene_0005".tr(),
                              descriptionText: "Care_Prog_0020".tr(),
                              primaryButtonText: "Comm_Gene_0006".tr(),
                              secondaryButtonText: "Comm_Gene_0009".tr(),
                              onSecondaryButtonPressed: () {
                                context.pop();
                                context.pop();
                                context.pushNamed('care-result-shoot', queryParams: {
                                  "care_program_id": widget.careProgramId.toString(),
                                  "user_care_program_id": userCareProgramId,
                                });
                              }),
                        );
                      },
                      child: CustomContainer(
                          width: double.infinity,
                          radius: 13,
                          containerColor: CustomColor.primary,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Center(
                              child: Text(
                                'Guid_Vide_0000'.tr(),
                                style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
