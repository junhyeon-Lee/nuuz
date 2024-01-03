import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

// Widget nuuzTrend(BuildContext context) {
//   return Column(
//     children: [
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Home_Main_0004'.tr(),
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             Text(
//               ///button
//               'Comm_Gene_0010'.tr(),
//               style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14.sp, color: CustomColor.primary),
//             ),
//           ],
//         ),
//       ),
//       hSize(20),
//       SizedBox(
//         width: 390.w,
//         height: 260.h,
//         child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           physics: const BouncingScrollPhysics(),
//           // shrinkWrap: true,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: index==0? EdgeInsets.only(left: 20.w):EdgeInsets.zero,
//               child: nuuzTrendItem(context, index),
//             );
//           },
//           itemCount: 10,
//         ),
//       ),
//       hSize(12),
//     ],
//   );
// }
// Widget nuuzTrendItem(BuildContext context, int index){
//   return Padding(
//     padding: EdgeInsets.only(right: 16.w),
//     child: Container(
//       width: 222.w,
//       height: 260.h,
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//           image: DecorationImage(image: AssetImage(IconPath.nuuzTrend1), fit: BoxFit.cover)),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: 222.w,
//                 height: 130.h,
//                 color: Colors.transparent,
//               ),
//               Container(
//                 width: 222.w,
//                 height: 130.h,
//                 decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
//                     gradient: LinearGradient(
//                         colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.82)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter)),
//               ),
//             ],
//           ),
//           Positioned.fill(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 14.w),
//                   child: SizedBox(width: 190.w,
//                     child: Text(
//                       '환절기 피부 관리법은? 내 피부에 맞는 관리법을 함께 알아봐요',
//                       style: Theme.of(context).textTheme.displayMedium,
//                     ),
//                   ),
//                 ),
//                 hSize(20)
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }