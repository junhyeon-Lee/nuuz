import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuuz/util/log_print.dart';

int ios2mmCount = 0;
const MethodChannel methodChannel = MethodChannel("ios_2mm");

void ios2mmAction(String partName){

  switch(partName){
    case "2mm Left Feet": ios2mmCount=1; break;
    case "2mm Right Feet": ios2mmCount=6; break;
    case "2mm Left Forehead Vertical": ios2mmCount=0; break;
    case "2mm Left Forehead Horizontal": ios2mmCount=0; break;
    case "2mm Right Forehead Vertical": ios2mmCount=5; break;
    case "2mm Right Forehead Horizontal": ios2mmCount=5; break;
    case "2mm Left Nasolabial": ios2mmCount=2; break;
    case "2mm Right Nasolabial": ios2mmCount=7; break;
    case "2mm Left Neck": ios2mmCount=4; break;
    case "2mm Right Neck": ios2mmCount=9; break;
    default :
      ios2mmCount=0;
  }

  methodChannel.invokeMethod("handlePositionButtonPressed",{"myParam":ios2mmCount});
}


class ArkitScreen2mm extends StatefulWidget {



  const ArkitScreen2mm({Key? key}) : super(key: key);

  @override
  State<ArkitScreen2mm> createState() => _ArkitScreen2mmState();
}

class _ArkitScreen2mmState extends State<ArkitScreen2mm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.centerRight,
        children: const [
          UiKitView(
            viewType: 'ios_2mm',
            layoutDirection: TextDirection.ltr,
            creationParams: <String, dynamic>{"param": "ios_2mm"},
            creationParamsCodec: StandardMessageCodec(),
          ),
          // Row(mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     OutlinedButton(onPressed: (){
          //       try{
          //         if(ios2mmCount>0){
          //           ios2mmCount--;
          //           methodChannel.invokeMethod("handlePositionButtonPressed",{"myParam":ios2mmCount});
          //           setState(() {
          //
          //           });
          //         }
          //
          //       }catch(e){safePrint(e
          //       );}
          //     }, child: const Text('-')),
          //
          //     OutlinedButton(onPressed: (){
          //       try{
          //         methodChannel.invokeMethod("handlePositionButtonPressed",{"myParam":ios2mmCount});
          //         setState(() {
          //
          //         });
          //       }catch(e){safePrint(e
          //       );}
          //     }, child: Text(ios2mmCount.toString())),
          //
          //     OutlinedButton(onPressed: (){
          //       ios2mmCount++;
          //       methodChannel.invokeMethod("handlePositionButtonPressed",{"myParam":ios2mmCount});
          //     }, child: const Text('+')),
          //   ],
          // ),
        ],
      ),
    );
  }
}
