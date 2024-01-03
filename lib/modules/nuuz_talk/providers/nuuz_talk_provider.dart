import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/nuuz_talk_category_model.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/category/repository/category_repository.dart';
import 'package:nuuz/models/nuuz_talk/category.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

final nuuzTalkCategoryProvider = StateNotifierProvider<NuuzTalkNotifier, List<NuuzTalkCategoryModel>?>((ref) {
  return NuuzTalkNotifier();
});

class NuuzTalkNotifier extends StateNotifier<List<NuuzTalkCategoryModel>?> {
  NuuzTalkNotifier() : super(null);

  final categoryRepository = CategoryRepository();
  List<NuuzTalkCategoryModel> talkCategoryList=[];


  Future<void> getCategory() async {
    talkCategoryList.clear();
    List<Category> categoryList=await categoryRepository.getCategories();
    talkCategoryList.add(NuuzTalkCategoryModel(icon: IconPath.talkAll, onIcon: IconPath.onTalkAll, title: 'Prog_Part_0012', id: 'Prog_Part_0012',));

    for(int i=0; i<categoryList.length; i++){
      safePrint('여기');
      safePrint(categoryList[i].id.toString());
      if(categoryList[i].id=='d6bc86ec-4af7-487f-a102-d88813b7f907' || categoryList[i].name.toString().toLowerCase()=='free topic'){
        talkCategoryList.add(NuuzTalkCategoryModel(icon: IconPath.talkFreeTopic, onIcon: IconPath.onTalkFreeTopic, title: 'Talk_Main_0000', id: categoryList[i].id,));
      }else if(categoryList[i].id=='4a0cd4db-a990-4406-a649-fd3a3f19012d' || categoryList[i].name.toString().toLowerCase()=='free topic'){
        talkCategoryList.add(NuuzTalkCategoryModel(icon: IconPath.talkQuestion, onIcon: IconPath.onTalkQuestion, title: 'Talk_Main_0001', id: categoryList[i].id,));
      }else if(categoryList[i].id=='afddafbf-3468-4d71-a1a3-db115976e599' || categoryList[i].name.toString().toLowerCase()=='care tips'){
        talkCategoryList.add(NuuzTalkCategoryModel(icon: IconPath.talkCareTips, onIcon: IconPath.onTalkCareTips, title: 'Talk_Main_0002', id: categoryList[i].id,));
      }else if(categoryList[i].id=='e6e6cede-4d6f-4f0d-b742-29b83e4a8e71' || categoryList[i].name.toString().toLowerCase()=='care review'){
        talkCategoryList.add(NuuzTalkCategoryModel(icon: IconPath.talkCareReview, onIcon: IconPath.onTalkCareReview, title: 'Talk_Main_0003', id: categoryList[i].id,));
      }
    }

  }
}