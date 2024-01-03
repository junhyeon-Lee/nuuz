import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/models/nuuz_talk/user.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/home/nuuz_home/products.dart';
import 'package:nuuz/modules/nuuz_talk/preview_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/providers/category/category_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/review/reviews_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuuz_talk/search_product_list.dart';
import 'package:nuuz/modules/nuuz_talk/search_review_list.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/repository/image_repository.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/crop_image.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_app_bar.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';

import '../drawer/my_drawer/my_drawer_controller.dart';
import 'providers/user_post/repository/user_post_repository.dart';

class EditPostScreen extends ConsumerStatefulWidget {
  const EditPostScreen({super.key, this.userPostId});

  final String? userPostId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends ConsumerState<EditPostScreen> {
  bool isEditingPost = false;
  int _selectedCategoryIndex = -1;
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _imageUrls = [];
  UserPost? _userPost;
  final List<Program> _programs = [];
  final List<Result> _reviews = [];
  final List<Product> _products = [];
  bool isLoading = false;
  var userData;

  @override
  void initState() {
    super.initState();
    setState(() {

      if(widget.userPostId==""||widget.userPostId==null){
        isEditingPost=false;
      }else{
        isEditingPost=true;
      }
      safePrint('편집데이터 확인');
      safePrint(widget.userPostId);
      safePrint(isEditingPost);

      safePrint("EditPostScreen===isEditingPost==>$isEditingPost==== widget.userPostId=-==>${widget.userPostId}");
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(myDrawerProvider.notifier).getUserData();
      userData = ref.watch(myDrawerProvider);
      setState(() {});
      safePrint("EditPostScreen=====>${userData?.user_id}");
      safePrint("EditPostScreen=====>${isEditingPost}");

      if (isEditingPost) {
        safePrint("EditPostScreen===isEditingPost  in if==>$isEditingPost==== widget.userPostId=-==>${widget.userPostId}");
        final categories =ref.watch(categoryProvider);
        final userPost = await UserPostRepository().getUserPost(widget.userPostId ?? '');

        // userPost.whenOrNull(
        //   data: (post) async {
        safePrint("EditPostScreen===isEditingPost post====>$userPost");
        _userPost = userPost;
        _selectedCategoryIndex = categories.maybeWhen(
          data: (category) => category.indexWhere((element) => element.id == _userPost?.category.id),
          orElse: () => -1,
        );
        safePrint("EditPostScreen===_selectedCategoryIndex---$_selectedCategoryIndex");
        _textEditingController.text = _userPost?.title ?? "";
        safePrint("EditPostScreen===_selectedCategoryIndex---${_textEditingController.text}");

        setState(() {
          _imageUrls = _userPost?.imageUrls ?? [];
        });
        safePrint("EditPostScreen===_imageUrls---${_userPost?.imageUrls}");
        if (_userPost?.programIds != null) {
          for (var id in _userPost!.programIds) {
            Program? prog = await ref.watch(programController.notifier).getProgramByID(id);
            if(prog!=null) {
              _programs.add(prog);
            }
          }
        }
        safePrint("EditPostScreen===_programs---${_programs.length}---->${_userPost?.programIds}");

        if (_userPost!.reviewIds != null) {
          LocalDB localDB = LocalDB();
          LoginResponse? loginResponse = await localDB.findAuthInfo();

          for (var id in _userPost!.reviewIds) {
            Result? review = await ref.watch(resultProvider.notifier).fetchResultById(id,loginResponse?.accessToken ?? '');
            if(review!=null) {
              _reviews.add(review);
            }
          }
        }
        safePrint("EditPostScreen===_reviews---$_reviews");
        if (_userPost!.productIds != null) {
          for (var id in _userPost!.productIds) {
            Product? product = await ref.watch(productController.notifier).fetchProductById(id);
            if(product!=null) {
              _products.add(product);
            }
          }
        }
        setState(() {});
        safePrint("EditPostScreen===_products---$_products");

        //   },
        //
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEditingPost && _selectedCategoryIndex==-1) {
      final categories =ref.watch(categoryProvider);
      _selectedCategoryIndex = categories.maybeWhen(
        data: (category) => category.indexWhere((element) => element.id == _userPost?.category.id),
        orElse: () => -1,
      );
    }
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(context: context, title: isEditingPost ? "Talk_Post_0000".tr() : "Talk_Post_0011".tr()),
          hSize(12),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: NuuzContainer(
                containerColor: CustomColor.background,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NuuzContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Talk_Post_0004".tr(),
                                style: CustomTextStyle.headerS,
                              ),
                              hSize(16),
                              GridView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio: 4,
                                ),
                                children: categoryChips(),
                              ),
                              hSize(14),
                              TextField(
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: "Talk_Post_0012".tr(),
                                  filled: true,
                                  fillColor: CustomColor.greyContainer,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                maxLines: 5,
                              ),
                              hSize(8),
                            ],
                          ),
                        ),
                      ),
                      hSize(12),
                      NuuzContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Wrap(
                                  spacing: 7.w,
                                  runSpacing: 7.w,
                                  children: [
                                    if (_imageUrls.isNotEmpty)
                                      ..._imageUrls
                                          .map((e) => ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 75.w,
                                                  width: 75.w,
                                                  child: Stack(
                                                    children: [
                                                      e.toLowerCase().contains("http")
                                                          ? CachedNetworkImage(
                                                              imageUrl: e,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) => Center(
                                                                  child: CircularProgressIndicator(
                                                                color: CustomColor.primary,
                                                              )),
                                                              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                                            )
                                                          : Image.file(File(e)),
                                                      Positioned(
                                                        top: 2.w,
                                                        right: 2.w,
                                                        child: InkWell(
                                                            onTap: () {
                                                              _imageUrls.remove(e);
                                                              setState(() {});
                                                            },
                                                            child: SvgPicture.asset(
                                                              IconPath.close,
                                                              color: CustomColor.white,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    GestureDetector(
                                      onTap: () async {
                                        var imagePicker = ImagePicker();
                                        var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

                                        if (pickedFile != null) {
                                          uploadImage(context, pickedFile);
                                        }

                                        setState(() {});
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        color: CustomColor.primary,
                                        radius: const Radius.circular(12),
                                        child: SizedBox(
                                            height: 69.w,
                                            width: 69.w,
                                            child: Icon(
                                              CupertinoIcons.add,
                                              color: CustomColor.primary,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              if (_imageUrls.isEmpty)
                                Text(
                                  "Talk_Post_0007".tr(),
                                  style: CustomTextStyle.descriptionL,
                                )
                            ],
                          ),
                        ),
                      ),
                      hSize(12),
                      NuuzContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallHeaderText(text: "Talk_Post_0005".tr()),
                              SmallDescriptionText(text: "Talk_Post_0006".tr()),
                              hSize(12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => CareProgramListScreen(onTapItem: (program) => _onTapItem(program)),
                                            ));
                                          },
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            color: CustomColor.primary,
                                            radius: const Radius.circular(12),
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 100.w,
                                                child: Icon(
                                                  CupertinoIcons.add,
                                                  color: CustomColor.primary,
                                                )),
                                          ),
                                        ),
                                        hSize(8),
                                        Text(
                                          "Comm_Gene_0039".tr(),
                                          style: CustomTextStyle.headerXS,
                                        )
                                      ],
                                    ),
                                  ),
                                  wSize(6),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showReviewSearchPage(
                                                context: context,
                                                delegate: CustomSearchDelegate(onTapItem: (Result review) {
                                                  bool exists = _reviews.any((file) => file.result_id == review.result_id);

                                                  if (exists) {
                                                    AppToast.showSnackBar(message: 'this review already selected', context: context);
                                                  } else {
                                                    context.pop();
                                                    _reviews.add(review);
                                                    setState(() {});
                                                  }
                                                }));
                                          },
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            color: CustomColor.primary,
                                            radius: const Radius.circular(12),
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 100.w,
                                                child: Icon(
                                                  CupertinoIcons.add,
                                                  color: CustomColor.primary,
                                                )),
                                          ),
                                        ),
                                        hSize(8),
                                        Text(
                                          "Comm_Gene_0040".tr(),
                                          style: CustomTextStyle.headerXS,
                                        )
                                      ],
                                    ),
                                  ),
                                  wSize(6),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => showProductSearchPage(
                                              context: context,
                                              delegate: CustomProductSearchDelegate(onTapItem: (Product product) {
                                                bool exists = _products.any((file) => file.productId == product.productId);

                                                if (exists) {
                                                  AppToast.showSnackBar(message: 'this product already selected', context: context);
                                                } else {
                                                  context.pop();
                                                  _products.add(product);
                                                  setState(() {});
                                                }
                                              })),
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            color: CustomColor.primary,
                                            radius: Radius.circular(12),
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 100.w,
                                                child: Icon(
                                                  CupertinoIcons.add,
                                                  color: CustomColor.primary,
                                                )),
                                          ),
                                        ),
                                        hSize(8),
                                        Text(
                                          "Comm_Gene_0011".tr(),
                                          style: CustomTextStyle.headerXS,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      if (_programs.isNotEmpty) ...[
                        hSize(12),
                        Text(
                          "Comm_Gene_0039".tr(),
                          style: CustomTextStyle.headerS,
                        ),
                        hSize(12),
                        ..._programs
                            .map(
                              (e) {
                                return Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: NuuzContainer(
                                  child: CareProgramListItem(
                                    name: e.name,
                                    description: e.description,
                                    imageUrl: e.image,
                                    postItemRemove: true,
                                    onTrailingButtonTap: (){
                                      _programs.remove(e);
                                      _programs.removeWhere((item) => item.id == e.id);
                                      setState(() {

                                      });
                                    },
                                  ),
                                ),
                              );
                              },
                            )
                            .toList(),
                      ],
                      if (_reviews.isNotEmpty) ...[
                        hSize(12),
                        Text(
                          "Comm_Gene_0040".tr(),
                          style: CustomTextStyle.headerS,
                        ),
                        hSize(12),
                        ..._reviews
                            .map(
                              (e) => Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: NuuzContainer(
                                  child: CareProgramListItem(
                                    name: e.program?.care_program_name ?? '',
                                    description: e.program?.description ?? '',
                                    imageUrl: e.result_image,
                                    postItemRemove: true,
                                    onTrailingButtonTap: (){
                                      _reviews.removeWhere((item) => item.result_id == e.result_id);
                                      setState(() {

                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList()
                      ],
                      if (_products.isNotEmpty) ...[
                        hSize(12),
                        Text(
                          "Comm_Gene_0011".tr(),
                          style: CustomTextStyle.headerS,
                        ),
                        hSize(12),
                        ..._products.map((e) => productsItem(e,isRemoveIcon: true,onButtonTap: (){
                          _products.removeWhere((item) => item.productId == e.productId);
                          setState(() {

                          });
                        })).toList(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CommonButton(onPressed: _submitPostForReview, text: "Talk_Post_0003".tr()),
              ))
        ],
      ),
    );
  }

  void uploadImage(BuildContext context, XFile pickedFile) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropImageScreen(
            cropImageFile: File(pickedFile!.path),
            onUploadCropImage: (croppedFile) async {
              context.pop();
              setState(() {
                isLoading = true;
              });
              if (croppedFile != null) {
                final imageRepository = ImageRepository();
                try {
                  var data = await imageRepository.uploadImage(croppedFile.path);
                  safePrint("get _imageUrl==uploaded===Editpost==>$data");
                  ref.invalidate(imageController);
                  setState(() {
                    if (isEditingPost) {
                      _imageUrls = [
                        ..._imageUrls,
                        data
                      ];
                    } else {
                      _imageUrls.add(data);
                    }
                  });
                } on Exception catch (e) {
                  safePrint("get _imageUrl==error===Editpost=>$e");
                  setState(() {
                    isLoading = false;
                  });
                }
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
        ));
  }

  _submitPostForReview() {
    if (_selectedCategoryIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category must be selected")));
      return;
    }

    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contents cannot be empty")));
      return;
    }
    var selectedCategory = ref.watch(categoryProvider).whenOrNull(
          data: (data) => data.elementAt(_selectedCategoryIndex),
        );
    UserPost newUserPost;
    if (_userPost != null) {
      newUserPost = _userPost!.copyWith(
        title: _textEditingController.text,
        category: selectedCategory!,
        imageUrls: _imageUrls,
        programIds: _programs.map((e) => e.id.toString()).toList(),
        reviewIds: _reviews.map((e) => e.result_id!).toList(),
        productIds: _products.map((e) => e.productId).toList(),
      );
    } else {
      newUserPost = UserPost(
        name: userData?.nick_name ?? "",
        postId: "",
        userId: "",
        title: _textEditingController.text,
        category: selectedCategory!,
        likesCount: 0,
        commentsCount: 0,
        imageUrls: _imageUrls,
        programIds: _programs.map((e) => e.id.toString()).toList(),
        reviewIds: _reviews.map((e) => e.result_id!).toList(),
        productIds: _products.map((e) => e.productId).toList(), createdAt: DateTime.now().toString(),
      );
    }

    safePrint('뭐가 널일까?');
    safePrint(newUserPost.userId);
    safePrint(newUserPost.user); //null
    safePrint(newUserPost.postId);
    safePrint(newUserPost.title);
    safePrint(newUserPost.html); //null
    safePrint(newUserPost.name);
    safePrint(newUserPost.productIds);
    safePrint(newUserPost.reviewIds);
    safePrint(newUserPost.programIds);
    safePrint(newUserPost.imageUrls);
    safePrint(newUserPost.category);
    safePrint(newUserPost.createdAt);  //null
    safePrint(newUserPost.commentsCount);
    safePrint(newUserPost.hashtag); //null
    safePrint(newUserPost.isLiked);
    safePrint(newUserPost.items); //null
    safePrint(newUserPost.latestComment);
    safePrint(newUserPost.likesCount);
    safePrint(newUserPost.reactId);
    //await ref.watch(commentLengthProvider.notifier).setCommentLength(widget.userPost.commentsCount);//null
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewPostScreen(
          userPost: newUserPost,
          programs: _programs,
          reviews: _reviews,
          products: _products,
          isEditingPost: true,
          userImage: userData?.profile_image,
          postId: widget.userPostId ?? '',
          isCreatePost: widget.userPostId == ""||widget.userPostId == null ? true : false,
        ),
      ),
    );
  }

  List<Widget> categoryChips() {
    final categories = ref.watch(categoryProvider);

    List<Widget> chips = [];
    categories.when(
      data: (data) {
        for (int i = 0; i < data.length; i++) {
          var textColor = i == _selectedCategoryIndex ? CustomColor.white : CustomColor.dark;

          Widget item = InkWell(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = i;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: i == _selectedCategoryIndex ? CustomColor.primary : CustomColor.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 0.8,
                    color: i == _selectedCategoryIndex ? CustomColor.primary : CustomColor.dark,
                  )),
              child: Center(
                child: Text(
                  data[i].name.tr(),
                  style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
                ),
              ),
            ),
          );
          chips.add(item);
        }
        return chips;
      },
      error: (error, stackTrace) => Text("Error : $error"),
      loading: () => loadingScreen(),
    );
    return chips;
  }

  _onTapItem(Program program) {
    // print("item tapped");

    bool exists = _programs.any((file) => file.id == program.id);

    if (exists) {
      AppToast.showSnackBar(message: 'this program already selected', context: context);
    } else {
      context.pop();
      setState(() {
        // if (_programs?.isNotEmpty ?? false) {
        _programs.add(program);
        // } else {
        //   _programs = [
        //     program
        //   ];
        // }
      });
    }
  }
}
