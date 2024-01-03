import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/self_diagnosis/self_diagnosis_result.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class SelfDiagnosisHome extends StatefulWidget {
  const SelfDiagnosisHome({super.key});

  @override
  State<SelfDiagnosisHome> createState() => _SelfDiagnosisHomeState();
}

class _SelfDiagnosisHomeState extends State<SelfDiagnosisHome> {
  LocalDB localdb = LocalDB();
  String _skintype = '';
  List<String> datadetail = [];
  List<String> dataskincon = [];
  String habits1 = '';
  String habits2 = '';
  List<String> skinCareHabits = [];

  final selfDiagnosisSteps = [
    {
      "header": "Self_Diag_0002".tr(),
      "subHeader": [
        {
          "text": "Self_Diag_0003".tr(),
          "options": ["Self_Diag_0004".tr(), "Self_Diag_0005".tr(), "Self_Diag_0006".tr(), "Self_Diag_0007".tr(), "Self_Diag_0008".tr()],
          "multi": false,
        }
      ]
    },
    {
      "header": "Self_Diag_0009".tr(),
      "subHeader": [
        {
          "text": "Self_Diag_0010".tr(),
          "options": [
            "Self_Diag_0011".tr(),
            "Self_Diag_0012".tr(),
            "Self_Diag_0013".tr(),
            "Self_Diag_0014".tr(),
            "Self_Diag_0015".tr(),
            "Self_Diag_0016".tr(),
          ],
          "multi": true,
        }
      ]
    },
    {
      "header": "Self_Diag_0017".tr(),
      "subHeader": [
        {
          "text": "Self_Diag_0018".tr(),
          "options": [
            "Self_Diag_0019".tr(),
            "Self_Diag_0020".tr(),
            "Self_Diag_0021".tr(),
            "Self_Diag_0022".tr(),
            "Self_Diag_0023".tr(),
            "Self_Diag_0024".tr(),
            "Self_Diag_0025".tr(),
            "Self_Diag_0026".tr(),
            "Self_Diag_0027".tr(),
            "Self_Diag_0028".tr(),
            "Self_Diag_0029".tr(),
          ],
          "multi": true,
        }
      ]
    },
    {
      "header": "Self_Diag_0030".tr(),
      "subHeader": [
        {
          "text": "Self_Diag_0031".tr(),
          "options": [
            "Self_Diag_0032".tr(),
            "Self_Diag_0033".tr(),
          ],
          "multi": false,
        },
        {
          "text": "Self_Diag_0034".tr(),
          "options": ["Self_Diag_0035".tr(), "Self_Diag_0036".tr(), "Self_Diag_0037".tr(), "Self_Diag_0038".tr(), "Self_Diag_0039".tr()],
          "multi": false,
        },
      ],
    },
  ];

  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  Future<void> showlimiterror(context) async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: CustomColor.white,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 20.h, bottom: 5.h),
              child: Column(
                children: [
                  Text(
                    "Comm_Gene_0005".tr(),
                    style: CustomTextStyle.headerS,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Divider(
                    height: 17,
                    color: Color(0xffebeae9),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Self_Diag_0048".tr(),
                    style: CustomTextStyle.descriptionL,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CommonButton(
                    onPressed: () => context.pop(),
                    text: 'OK',
                  )
                ],
              ),
            ),
          );
        });
  }

  setSelectedvalue(var value, int index) {
    _skintype = value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
    return SafeArea(
      child: Container(
        color: CustomColor.background,
        child: Column(
          children: [
            SizedBox(height: 12.h),
            LargeHeaderText(text: 'Self_Diag_0000'.tr()),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LargeDescriptionText(
                text: "Self_Diag_0001".tr(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            LinearProgressIndicator(
              backgroundColor: CustomColor.grayLine,
              color: CustomColor.primary,
              value: (_currentPage + 1) / selfDiagnosisSteps.length,
            ),
            Expanded(
              child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: selfDiagnosisSteps.length,
                  itemBuilder: (context, index) {
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        ConstrainedBox(
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.72),
                            child: Column(children: [
                              hSize(12),
                              ...(selfDiagnosisSteps[index]["subHeader"] as List).map(
                                (e) {
                                  var subHeadIndex = (selfDiagnosisSteps[index]["subHeader"] as List).indexOf(e);
                                  return _renderSubHeaderItems(context, index, subHeadIndex, e, theme, newCheckBoxTheme);
                                },
                              )
                            ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 120.w,
                              child: CommonOutlinedButton(
                                onPressed: _currentPage != 0
                                    ? () {
                                        _currentPage -= 1;
                                        _pageController.animateToPage(_currentPage,
                                            duration: const Duration(milliseconds: 300), curve: Curves.linear);
                                      }
                                    : null,
                                child: Text('Comm_Gene_0003'.tr()),
                              ),
                            ),
                            SizedBox(
                              width: 120.w,
                              child: Stack(
                                children: [
                                  CommonButton(
                                    onPressed: _currentPage == 0 && _skintype.isEmpty
                                        ? null
                                        : _currentPage == 1 && dataskincon.isEmpty
                                            ? null
                                            : _currentPage == 2 && datadetail.isEmpty
                                                ? null
                                                : _currentPage == 3 && (habits1.isEmpty || habits2.isEmpty)
                                                    ? null
                                                    : _onPressNext,
                                    text: 'Comm_Gene_0004'.tr(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ])),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _onPressNext() {
    if (_currentPage == 3) {
      Map<String, dynamic> response = {
        "skinType": _skintype,
        "skinConcerns": dataskincon,
        "detailedConcern": datadetail,
        "frequentlyReplaced": habits1,
        "colorMakeup": habits2,
        "skinCareHabits": ["Self_Diag_0041".tr()]
      };
      safePrint("_onPressNext---->$response");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultSelfDiagnosis(
                    response: response,
                  )));
    } else {
      _currentPage += 1;
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  Material _renderSubHeaderItems(BuildContext context, int index, int subHeadIndex, e, ThemeData theme, CheckboxThemeData newCheckBoxTheme) {
    return Material(
      color: CustomColor.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSize(50.h),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.034),
            child: MediumHeaderText(
              text: "${selfDiagnosisSteps[index]["header"]}",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.034),
            child: LargeDescriptionText(text: e["text"].toString()),
          ),
          (index == 0 || index == 1 || index == 2)
              ? Column(
                  children: [
                    ...e["multi"] == true
                        ? (e["options"] as List).map((
                            el,
                          ) {
                            safePrint(e);
                            return Theme(
                              data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
                              child: CheckboxListTile(
                                  visualDensity: VisualDensity.comfortable,
                                  checkColor: CustomColor.white,
                                  activeColor: CustomColor.primary,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: index == 1 ? dataskincon.contains(el) : datadetail.contains(el),
                                  onChanged: (value) {
                                    if (index == 2) {
                                      if (value!) {
                                        if (datadetail.length < 5) {
                                          datadetail.add(el);
                                        } else {
                                          showlimiterror(context);
                                        }
                                      } else {
                                        datadetail.remove(el);
                                      }

                                      setState(() {});
                                    } else if (index == 1) {
                                      if (value!) {
                                        dataskincon.add(el);
                                      } else {
                                        dataskincon.remove(el);
                                      }
                                      setState(() {});
                                    }
                                  },
                                  title: Text(
                                    el.toString(),
                                    style: CustomTextStyle.descriptionL,
                                  )),
                            );
                          }).toList()
                        : (e["options"] as List).map((eles) {
                            return RadioListTile(
                                activeColor: CustomColor.primary,
                                value: eles,
                                groupValue: _skintype,
                                onChanged: (value) {
                                  setSelectedvalue(value, index);
                                  setState(
                                    () {
                                      // itemselected = true;
                                    },
                                  );
                                },
                                title: Text(
                                  eles.toString(),
                                  style: CustomTextStyle.descriptionL,
                                ));
                          }).toList()
                  ],
                )
              : Column(
                  children: [
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          ...e["multi"] == false
                              ? (e["options"] as List).map((eles) {
                                  // if (e['text'] == 'Choose 1 option from below') {
                                  if (subHeadIndex == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                      child: InkWell(
                                        onTap: () {
                                          habits1 = eles;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 45.h,
                                          width: 150.h,
                                          decoration: BoxDecoration(
                                            color: !habits1.contains(eles) ? Colors.transparent : CustomColor.primary,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: habits1.contains(eles) ? Colors.transparent : CustomColor.black, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              eles.toString(),
                                              style: TextStyle(fontSize: 16, color: !habits1.contains(eles) ? CustomColor.dark : CustomColor.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80.h,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                  color: !habits2.contains(eles) ? CustomColor.white : CustomColor.primary,
                                                  borderRadius: BorderRadius.circular(30)),
                                              child: InkWell(
                                                onTap: () {
                                                  habits2 = eles;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(20.h),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: CustomColor.white,
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(2),
                                                      child: eles.toString() == "Self_Diag_0035".tr()
                                                          ? Image.asset(IconPath.ellipse1) //SvgPicture.asset(IconPath.fullcircle)
                                                          : eles.toString() == "Self_Diag_0036".tr()
                                                              ? Image.asset(IconPath.ellipse2) //SvgPicture.asset(IconPath.circle2)
                                                              : eles.toString() == "Self_Diag_0037".tr()
                                                                  ? Image.asset(IconPath.ellipse3)
                                                                  // SvgPicture.asset(
                                                                  //     IconPath.circle3,
                                                                  //     fit: BoxFit.contain,
                                                                  //     alignment: Alignment.centerLeft,
                                                                  //   )
                                                                  : eles.toString() == "Self_Diag_0038".tr()
                                                                      ? Image.asset(IconPath.ellipse4)
                                                                      // Padding(
                                                                      //     padding: EdgeInsets.only(left: 1.h, right: 10.h, bottom: 10.h, top: 2.h),
                                                                      //     child: SvgPicture.asset(
                                                                      //       IconPath.circle4,
                                                                      //       alignment: Alignment.topCenter,
                                                                      //       height: 30,
                                                                      //       width: 20,
                                                                      //       fit: BoxFit.contain,
                                                                      //     ),
                                                                      //   )
                                                                      : Image.asset(IconPath.ellipse5)
                                                      // SvgPicture.asset(
                                                      //     IconPath.circle5,
                                                      //     height: 5,
                                                      //     width: 5,
                                                      //     fit: BoxFit.contain,
                                                      //     alignment: Alignment.center,
                                                      //   ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              eles.toString(),
                                              style: TextStyle(fontSize: 15, color: CustomColor.black),
                                            )
                                          ],
                                        ));
                                  }
                                })
                              : (e["options"] as List).map(
                                  (eles) {
                                    return Container();
                                  },
                                )
                        ],
                      ),
                    ),
                    if (subHeadIndex == 0)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Divider(thickness: 1),
                      ),
                  ],
                ),
        ],
      ),
    );
  }
}
