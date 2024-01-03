import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/programguide.dart';
import 'package:nuuz/modules/nuzz_care/care_program/face_detection_ios/arkit_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/NativeMessage.dart';
import 'package:nuuz/ui/theme/care_guide_path.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

import 'face_detection_ios/arkit_screen_2mm.dart';

final careProgramProvider = StateNotifierProvider<CareProgramProvider, Program?>((ref) {
  return CareProgramProvider();
});

class CareProgramProvider extends StateNotifier<Program?> {
  CareProgramProvider() : super(null);

  setProgramData(Program data) {
    state = data;
  }
}

final partGroupProvider = StateNotifierProvider.autoDispose<PartGroupProvider, List<List<bool>>>((ref) {
  return PartGroupProvider();
});

class PartGroupProvider extends StateNotifier<List<List<bool>>> {
  PartGroupProvider() : super([]);

  ///밑에 아이템 모델을 선언해서 전부 저장한다 이니셜 세팅에서

  List<String?> partGroupList = [];
  List<List<List<int>>> shotCounter = [];
  List<ProgramGuide> programGuide = [];
  List<int> shotList = [];
  int line = 1;
  int shot = 0;
  int maxShot = 0;
  String nowCartridge = '';
  int guideIndex = 1;
  int guideLength = 0;
  int progress = 0;
  int totalShot = 0;
  int totalLine = 0;
  bool isGuide = false;
  bool cartridge = false;

  int partIndex = 0; //이름
  int timeCounter = 0; //타이머
 // String part = ''; //보여줄 이름
  Program? program;
  PageController pageController = PageController();
  PageController guideController = PageController(viewportFraction: 0.3);

  String setPartGroup(Program data) {
    program = data;
    nowCartridge = data.subprograms![0].cartridgeType;
    //서브프로그램 갯수 및 카트리지 확인
    for (int z = 0; z < data.subprograms!.length; z++) {
      state.add([]);
      partGroupList.add(data.subprograms![z].cartridgeType);
      shotCounter.add([]);
      for (int j = 0; j < data.subprograms![z].partDetails.length; j++) {
        state[z].add(false);
        shotCounter[z].add([]);
        programGuide.add(ProgramGuide(
           name:  data.subprograms![z].partDetails[j].partName,
            image: data.subprograms![z].partDetails[j].imageUrl,
            title: data.subprograms![z].partDetails[j].title,
            cartridge: data.subprograms![z].partDetails[j].cartridgeType,
            description: data.subprograms![z].partDetails[j].description));
        safePrint('순서 $j  ${data.subprograms![z].partDetails[j].partName.tr()}');
        for (int i = 0; i < data.subprograms![z].partDetails[j].line_group_details.length; i++) {
          //샷 데이터
          shotCounter[z][j].add(data.subprograms![z].partDetails[j].line_group_details[i].value!);
          //전체샷에 데이터 카운트
          if(data.subprograms![z].cartridgeType == '3mm'){
            progress += data.subprograms![z].partDetails[j].line_group_details[i].value!;
          }
          //샷 리스트에 데이터 추가
          shotList.add(data.subprograms![z].partDetails[j].line_group_details[i].value!);
        }
      }
    }

    safePrint(partGroupList);
    safePrint(shotCounter);
    maxShot = shotCounter[0][0][0];

    for (final length in shotCounter) {
      guideLength += length.length;
    }
    //part = program!.subprograms![0].partDetails[partIndex].partName;
    return programGuide[0].name??'';
  }

  String shotData3mm() {
    cartridge=false;
    if(partIndex==0){
      if(Platform.isAndroid){
        MessageChannelTool.transformData(TransferParam(programGuide[partIndex].name!, shot+1, line));
      }else{
        wantPart = programGuide[partIndex].name!;
        wantLine =line;
      }

    }
    totalShot++;
    shot++;
    if (shot == shotCounter[0][0][0]+1) {
      shot = 1;
      line++;
      shotCounter[0][0].removeAt(0);
      safePrint(shotCounter);

      totalLine++;
      if(shotList.length>totalLine){
        maxShot =shotList[totalLine];
      }
      if (shotCounter[0][0].isEmpty) {
        shotCounter[0].removeAt(0);
        if (shotCounter.isEmpty) {
          return 'done';
        }
        safePrint(shotCounter);

        line = 1;

        if (shotCounter[0].isNotEmpty) {
          partIndex++;
          pageController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
          guideController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
          guideIndex++;
        }
        else {
          shotCounter.removeAt(0);
          if (shotCounter.isEmpty) {
            return 'done';
          }
          safePrint('3차 지우기');
          safePrint(shotCounter);
          partGroupList.removeAt(0);
          if (shotCounter.isEmpty) {
            return 'done';
          }
          if (partGroupList.isNotEmpty) {
            nowCartridge = partGroupList[0]!;
            safePrint(nowCartridge);
            partIndex++;
            pageController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
            guideController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
            cartridge= true;
          // }
        }
      }
    }
  }
    if(Platform.isAndroid){
      final result = MessageChannelTool.transformData(TransferParam(programGuide[partIndex].name!, 1, line));
    }
    else{
      wantPart = programGuide[partIndex].name!;
      wantLine =line;
    }
    return '파트 : ${programGuide[partIndex].name!}  line:${line}shot:${shot+1}';
  }

  Future<String> shotData2mm(int pauseCount) async {
    if (shotCounter.isEmpty) {
      return 'done';
    }
    timeCounter++;
    safePrint(timeCounter);
    safePrint('timeCounter : $timeCounter');
    if (timeCounter == shotCounter[0][0][0]) {
      timeCounter = 0;
      shotCounter[0].removeAt(0);
      if(shotCounter[0].isNotEmpty){
        partIndex++;
        safePrint(partIndex);
        pageController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        guideController.animateToPage(partIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        if(Platform.isAndroid){  MessageChannelTool.transformData(TransferParam(programGuide[partIndex].name!, 1, 1));}else{
          ios2mmAction(programGuide[partIndex].name!);
          wantPart = programGuide[partIndex].name!;
          wantLine =line;

        }


        return 'next';
      }else{
        partGroupList.removeAt(0);
        return 'done';
      }
    }
    safePrint(shotCounter);
    return 'progress';
  }

}

final careIdProvider = StateNotifierProvider<CareIdProvider, String>((ref) {
  return CareIdProvider();
});

class CareIdProvider extends StateNotifier<String> {
  CareIdProvider() : super('');

  setProgram(String id) {
    state = id;
  }
}

final userCareIdProvider = StateNotifierProvider<UserCareIdProvider, String>((ref) {
  return UserCareIdProvider();
});

class UserCareIdProvider extends StateNotifier<String> {
  UserCareIdProvider() : super('');

  setProgram(String id) {
    state = id;
    safePrint(id);
    safePrint(state);
  }
}

final guildImageProvider = StateNotifierProvider<GuildImageProvider, String>((ref) {
  return GuildImageProvider();
});

class GuildImageProvider extends StateNotifier<String> {
  GuildImageProvider() : super(CareGuidePath.defaultFrontFace);

  setGuideImage(String part, int line){
    if(part=="3mm Forehead"){
      state = CareGuidePath.forehead[line];
    }
    else if(part=="3mm Left Cheek A"){
      state = CareGuidePath.leftCheekVertical[line];
    }
    else if(part=="3mm Left Cheek Horizontal"){
      state = CareGuidePath.leftCheekHorizon[line];
    }
    else if(part=="3mm Right Cheek A"){
      state = CareGuidePath.rightCheekVertical[line];
    }
    else if(part=="3mm Right Cheek Horizontal"){
      state = CareGuidePath.rightCheekHorizon[line];
    }
    else if(part=="3mm Left Feet Vertical"){
      state = CareGuidePath.leftCrowVertical[line];
    }
    else if(part=="3mm Left Feet Horizontal"){
      state = CareGuidePath.leftCrowHorizon[line];
    }
    else if(part=="3mm Right Feet Vertical"){
      state = CareGuidePath.rightCrowVertical[line];
    }
    else if(part=="3mm Right Feet Horizontal"){
      state = CareGuidePath.rightCrowHorizon[line];
    }
    else if(part=="3mm Left Tear"){
      state = CareGuidePath.leftTear[line];
    }
    else if(part=="3mm Right Tear"){
      state = CareGuidePath.rightTear[line];
    }
    else if(part=="3mm Left Nasolabial"){
      state = CareGuidePath.leftNasolabial[line];
    }
    else if(part=="3mm Right Nasolabial"){
      state = CareGuidePath.rightNasolabial[line];
    }
    ///2mm
    else if(part=="2mm Left Feet"){
      state = CareGuidePath.leftFeet2mm[line];
    }
    else if(part=="2mm Right Feet"){
      state = CareGuidePath.rightFeet2mm[line];
    }
    else if(part=="2mm Left Forehead Vertical"){
      state = CareGuidePath.leftForeheadVertical2mm[line];
    }
    else if(part=="2mm Left Forehead Horizontal"){
      state = CareGuidePath.leftForeheadHorizontal2mm[line];
    }
    else if(part=="2mm Right Forehead Vertical"){
      state = CareGuidePath.rightForeheadVertical2mm[line];
  }
    else if(part=="2mm Right Forehead Horizontal"){
      state = CareGuidePath.rightForeheadHorizontal2mm[line];
    }
    else if(part=="2mm Left Nasolabial"){
      state = CareGuidePath.leftNasolabial2mm[line];
    }
    else if(part=="2mm Right Nasolabial"){
      state = CareGuidePath.rightNasolabial2mm[line];
    }
    else if(part=="2mm Left Neck"){
      state = CareGuidePath.leftNeck2mm[line];
    }
    else if(part=="2mm Right Neck"){
      state = CareGuidePath.rightNeck2mm[line];
    }
    else{
      state = CareGuidePath.defaultFrontFace;
    }
  }
}

final guideAnimationProvider = StateNotifierProvider<GuideAnimationProvider, String>((ref) {
  return GuideAnimationProvider();
});

class GuideAnimationProvider extends StateNotifier<String> {
  GuideAnimationProvider() : super(CareGuidePath.foreheadAnimation);
  setGuideImage(String part){
    if(part=="3mm Forehead"){
      state = CareGuidePath.foreheadAnimation;
    }
    else if(part=="3mm Left Cheek A"){
      state = CareGuidePath.leftCheekVerticalAnimation;
    }
    else if(part=="3mm Left Cheek Horizontal"){
      state = CareGuidePath.leftCheekHorizonAnimation;
    }
    else if(part=="3mm Right Cheek A"){
      state = CareGuidePath.rightCheekVerticalAnimation;
    }
    else if(part=="3mm Right Cheek Horizontal"){
      state = CareGuidePath.rightCheekHorizonAnimation;
    }
    else if(part=="3mm Left Feet Vertical"){
      state = CareGuidePath.leftCrowVerticalAnimation;
    }
    else if(part=="3mm Left Feet Horizontal"){
      state = CareGuidePath.leftCrowHorizonAnimation;
    }
    else if(part=="3mm Right Feet Vertical"){
      state = CareGuidePath.rightCrowVerticalAnimation;
    }
    else if(part=="3mm Right Feet Horizontal"){
      state = CareGuidePath.rightCrowHorizonAnimation;
    }
    else if(part=="3mm Left Tear"){
      state = CareGuidePath.leftTearAnimation;
    }
    else if(part=="3mm Right Tear"){
      state = CareGuidePath.rightTearAnimation;
    }
    else if(part=="3mm Left Nasolabial"){
      state = CareGuidePath.leftNasolabialAnimation;
    }
    else if(part=="3mm Right Nasolabial"){
      state = CareGuidePath.rightNasolabialAnimation;
    }
    ///2mm
    else if(part=="2mm Left Feet"){
      state = CareGuidePath.leftFeet2mmAnimation;
    }
    else if(part=="2mm Right Feet"){
      state = CareGuidePath.rightFeet2mmAnimation;
    }
    else if(part=="2mm Left Forehead Vertical"){
      state = CareGuidePath.leftForeheadVertical2mmAnimation;
    }
    else if(part=="2mm Left Forehead Horizontal"){
      state = CareGuidePath.leftForeheadHorizontal2mmAnimation;
    }
    else if(part=="2mm Right Forehead Vertical"){
      state = CareGuidePath.rightForeheadVertical2mmAnimation;
    }
    else if(part=="2mm Right Forehead Horizontal"){
      state = CareGuidePath.rightForeheadHorizontal2mmAnimation;
    }
    else if(part=="2mm Left Nasolabial"){
      state = CareGuidePath.leftNasolabial2mmAnimation;
    }
    else if(part=="2mm Right Nasolabial"){
      state = CareGuidePath.rightNasolabial2mmAnimation;
    }
    else if(part=="2mm Left Neck"){
      state = CareGuidePath.leftNeck2mmAnimation;
    }
    else if(part=="2mm Right Neck"){
      state = CareGuidePath.rightNeck2mmAnimation;
    }
    else{
      state = CareGuidePath.defaultFrontFace;
    }
  }
}

final deviceAnimationProvider = StateNotifierProvider<DeviceAnimationProvider, String>((ref) {
  return DeviceAnimationProvider();
});

class DeviceAnimationProvider extends StateNotifier<String> {
  DeviceAnimationProvider() : super("else");
  setDeviceGuideImage(String part){
    if(part=="3mm Forehead"){
      state = CareGuidePath.deviceGuide13;
    }
    else if(part=="3mm Left Cheek A"){
      state = CareGuidePath.deviceGuide01;
    }
    else if(part=="3mm Left Cheek Horizontal"){
      state = CareGuidePath.deviceGuide02;
    }
    else if(part=="3mm Right Cheek A"){
      state = CareGuidePath.deviceGuide03;
    }
    else if(part=="3mm Right Cheek Horizontal"){
      state = CareGuidePath.deviceGuide04;
    }
    else if(part=="3mm Left Feet Vertical"){
      state = CareGuidePath.deviceGuide06;
    }
    else if(part=="3mm Left Feet Horizontal"){
      state = CareGuidePath.deviceGuide05;
    }
    else if(part=="3mm Right Feet Vertical"){
      state = CareGuidePath.deviceGuide08;
    }
    else if(part=="3mm Right Feet Horizontal"){
      state = CareGuidePath.deviceGuide07;
    }
    else if(part=="3mm Left Tear"){
      state = CareGuidePath.deviceGuide09;
    }
    else if(part=="3mm Right Tear"){
      state = CareGuidePath.deviceGuide10;
    }
    else if(part=="3mm Left Nasolabial"){
      state = CareGuidePath.deviceGuide11;
    }
    else if(part=="3mm Right Nasolabial"){
      state = CareGuidePath.deviceGuide12;
    }
    ///2mm
    else{
      state = "else";
    }
  }
}