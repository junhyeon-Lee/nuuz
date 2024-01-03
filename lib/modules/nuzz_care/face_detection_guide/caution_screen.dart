// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// import 'package:nuuz/ui/common/nuuz_container.dart';
// import 'package:nuuz/ui/common_widget/common_button.dart';
// import 'package:nuuz/ui/common_widget/common_scroll_view.dart';
// import 'package:nuuz/ui/common_widget/common_text_widget.dart';
// import 'package:nuuz/ui/theme/color_style.dart';

// class CautionScreen extends StatefulWidget {
//   const CautionScreen({super.key});

//   @override
//   State<CautionScreen> createState() => _CautionScreenState();
// }

// class _CautionScreenState extends State<CautionScreen> {
//   bool isChecked = false;
//   // final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NuuzContainer(
//       containerColor: CustomColor.lightWhite,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             AppBar(
//               centerTitle: true,
//               elevation: 0,
//               backgroundColor: CustomColor.lightWhite,
//               leading: GestureDetector(
//                 onTap: context.pop,
//                 child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Icon(
//                       CupertinoIcons.clear,
//                       color: CustomColor.dark,
//                     )),
//               ),
//               title: LargeHeaderText(text: 'Comm_Gene_0029'.tr()),
//             ),
//             SizedBox(height: 24.h),
//             Expanded(
//               child: NuuzContainer(
//                 child: const CommonScrollView(text: 'This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch.\n This is where health precautions for product use are written. Details will be forthcoming with product launch. I want the area to be designed as an area that can be easily managed through the admin.\n If the content inside is long, scrolling must be controlled by touch. This is where health precautions for product use are written. Details will be forthcoming with product launch.\n I want the area to be designed as an area that can be easily managed through the admin. If the content inside is long, scrolling must be controlled by touch.',),
//               ),
//             ),
//             SizedBox(height: 60.h),
//             Material(
//               child: CheckboxListTile(
//                 activeColor: CustomColor.primary,
//                 checkboxShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6)),
//                 controlAffinity: ListTileControlAffinity.leading,
//                 value: isChecked,
//                 onChanged: (value) => setState(() {
//                   isChecked = !isChecked;
//                 }),
//                 title: const LargeDescriptionText(
//                     text: 'I agree to all'),
//               ),
//             ),
//             SizedBox(height: 24.h),
//             CommonButton(

//                 text: 'Comm_Gene_0030'.tr(), onPressed: () {  },),
//             SizedBox(height: 8.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
