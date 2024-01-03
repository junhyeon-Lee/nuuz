import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/NativeMessage.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/care_guide_path.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';


class NativeDemo extends StatelessWidget {

  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    int guideIndex=0;
    var regions = List<String>.of(
      //please change to this if show 2mm
          // ["2mm Left Nasolabial" ,"2mm Right Nasolabial" ,"2mm left feet","2mm right feet",]);// ,"2mm forehead left horizontal","2mm forehead left vertical","2mm forehead right horizontal","2mm forehead right vertical", "2mm left neck","2mm right neck" ,"2mm left fold" ,"2mm right fold" ,"2mm left feet","2mm right feet" ]);//,
      //please change to this if show 3mm
    //     ["3mm Forehead", "3mm Left Cheek A", "3mm Right Cheek A","3mm Left Nasolabial","3mm Right Nasolabial", "3mm Left Tear","3mm Right Tear"]);
        [ "2mm Left Forehead Vertical",
          "2mm Right Forehead Vertical",
          "2mm Left Neck" ,
          "2mm Right Neck",
          "2mm Left Feet",
          "2mm Right Feet" ,
          "2mm Left Forehead Horizontal",
          "2mm Right Forehead Horizontal",
          "2mm Left Nasolabial" ,
          "2mm Right Nasolabial" ,
          "3mm Forehead",
          "3mm Left Tear",
          "3mm Right Tear" ,
          "3mm Left Cheek A",
          "3mm Right Cheek A",
          "3mm Left Cheek Horizontal",
          "3mm Right Cheek Horizontal",
          "3mm Left Feet Vertical",
          "3mm Right Feet Vertical",
          "3mm Left Feet Horizontal" ,
          "3mm Right Feet Horizontal",
          "3mm Left Nasolabial",
          "3mm Right Nasolabial",]);
    var region = regions[0];
    var index = 0;
    List<String> imageName = ['ForeHead', 'Left cheek'];
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
       "region": region
    };
    int range = 1;
    int column = 1;
    return Scaffold(
        body: Stack(children: [
          AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
          Row(children: [
        GestureDetector(
            onTap: () {
              index++;
              if (index >= regions.length) index = 0;
              print("curentindex");print(index);
              region = regions[index];
              range = 1;
              column = 1;
              MessageChannelTool.transformData(TransferParam(region, 1, 1));

            },
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('change mode')),
            )),
        GestureDetector(
            onTap: () {
              range++;
              // region="3mm Left Cheek A";
              if (region == "3mm Forehead") {
                if (column == 1 || column == 8) {
                  if (range > 5) {
                    column++;
                    range = 1;
                  }
                } else if (range > 10) {
                  {
                    column++;
                    range = 1;
                  }
                }
                if (column > 8) column = 1;
              } else if (region == "3mm Right Cheek A" ||
                  region == "3mm Left Cheek A") {
                if (range >= 10) {
                  column++;
                  range = 1;

                }
                if (column > 4) column = 1;
              }
              if (kDebugMode) {
                print("message $range,$column");
                // const snackBar = SnackBar(content: Text('Tap'));
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              MessageChannelTool.transformData(
                  TransferParam(region, range, column));

              MessageChannelTool.transformData(NextRowParam());

              //TransferResult result = await
              safePrint('파트 : $region 라인 : $column  샷 : $range');
            },
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('change position')),
            )),

      ]),
    ]));
  }
}


