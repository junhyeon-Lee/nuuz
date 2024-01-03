import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

class Constants {
  static String update = 'update';
  static String notice = 'notice';
  static String announce = 'announce';
  static String ended = 'ended';
  static String private = 'private';
  static int isLiked = 1;
  static int isUnLiked = 0;
  static bool isAPICall = false;
  static bool isRefresh = false;

  static Color getNoticeCatColor(String item) {
    safePrint("notice====>$item");
    if (item == update) {
      return CustomColor.primary;
    } else if (item == notice) {
      return CustomColor.blue;
    } else if (item == announce) {
      return CustomColor.yellow;
    } else if (item == ended) {
      return CustomColor.lightDark;
    } else {
      return Colors.transparent;
    }
  }

  static getImageFromCategory({required String categoryId}) {
    if (categoryId == '4a0cd4db-a990-4406-a649-fd3a3f19012d') {
      return IconPath.questionCategory;
    } else if (categoryId == 'afddafbf-3468-4d71-a1a3-db115976e599') {
      return IconPath.tips;
    } else if (categoryId == 'e6e6cede-4d6f-4f0d-b742-29b83e4a8e71') {
      return IconPath.review;
    } else {
      return IconPath.freeTopic;
    }
  }

  static getColorFromCategory({required String categoryId}) {
    if (categoryId == '4a0cd4db-a990-4406-a649-fd3a3f19012d') {
      return CustomColor.red.withOpacity(0.8);
    } else if (categoryId == 'afddafbf-3468-4d71-a1a3-db115976e599') {
      return CustomColor.blue.withOpacity(0.8);
    } else if (categoryId == 'e6e6cede-4d6f-4f0d-b742-29b83e4a8e71') {
      return CustomColor.yellow.withOpacity(0.8);
    } else {
      return const Color(0xff40BAFF).withOpacity(0.8);
    }
  }

  static String convertSpecificFormat({String? date, String? format}) {
    DateFormat dateFormat = DateFormat(format ?? "dd/MM/yyyy");
    return dateFormat.format(DateTime.parse(date ?? DateTime.now().toString()).toLocal());
  }

  static String numberCounter(String? followers) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      int num = int.parse(followers ?? '0');

      if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)} K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)} K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)} M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)} B";
      } else {
        return num.toString();
      }
    } catch (e) {
      return '0';
    }
  }
}
