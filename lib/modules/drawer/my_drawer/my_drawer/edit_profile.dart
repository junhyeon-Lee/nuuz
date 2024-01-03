import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/drawer/bottomsheet/change_image_bottom_sheet.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/nuuz_talk/bottom_sheet/complete_bottom_sheet.dart';
import 'package:nuuz/modules/nuzz_care/result/capture_image_screen.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/repository/image_repository.dart';
import 'package:nuuz/modules/sign/fill_profile/fill_profile_controller.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/crop_image.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class EditProfile extends ConsumerStatefulWidget {
  EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  UserData? userData;
  final _editProfileformKey = GlobalKey<FormState>();
  String? _imageUrl = "";
  File? imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ref.watch(myDrawerProvider.notifier).getUserData();
      // userData = ref.watch(myDrawerProvider);
      setState(() {
        ref.watch(loadingProvider.notifier).isLoadingTrue();
      });
      userData = await ref.watch(userDataProvider.notifier).getUserProfileData();
      ref.watch(nickNameProvider.notifier).nickNameController.text = userData?.nick_name ?? '';
      ref.watch(introductionNameProvider.notifier).introductionController.text = userData?.introduction=='pending'?"":userData!.introduction!;
      safePrint("Edit Profile===$userData");
      setState(() {
        ref.watch(loadingProvider.notifier).isLoadingFalse();
      });
    });
  }

  @override
  void dispose() {
    ref.watch(myDrawerProvider.notifier).getUserData();
    ref.invalidate(userDataProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: CustomColor.background,
            statusBarColor: CustomColor.background,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Stack(
            children: [
              Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight + 10),
                    child: CustomAppBar(
                      title: 'Talk_Prof_0010'.tr(),
                      onTap: () {
                        context.pop();
                      },
                      iconPath: IconPath.leftBackIcon,
                    ),
                  ),
                  body: LayoutBuilder(builder: (context, constraints) {
                    return
                      ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                          child: Form(
                            key: _editProfileformKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    hSize(8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        userData?.profile_image == null || userData == null || (userData?.profile_image ?? '').isEmpty
                                            ? Image.asset(
                                                IconPath.noProfile,
                                                height: 132.w,
                                                width: 132.w,
                                              )
                                            : Container(
                                                padding: EdgeInsets.all(8.h),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: _imageUrl == ""
                                                      ? userData == null
                                                          ? ""
                                                          : userData?.profile_image ?? ''
                                                      : _imageUrl ?? '',
                                                  imageBuilder: (context, imageProvider) => Container(
                                                      width: 130.w,
                                                      height: 130.w,
                                                      padding: EdgeInsets.all(50.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),

                                                  placeholder: (context, url) => Center(
                                                      child: CircularProgressIndicator(
                                                    color: CustomColor.primary,
                                                  )),
                                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),

                                                  // height: 100.w,
                                                  // width: 100.w,
                                                ),
                                              ),
                                      ],
                                    ),
                                    hSize(12),
                                    GestureDetector(
                                      onTap: () async {
                                        //context.goNamed('/profile-image');
                                        await changeImageBottomSheet(
                                            context: context,
                                            onCameraTap: () async {
                                              await getImageFile(ImageSource.camera);
                                              if (imageFile != null) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => CropImageScreen(
                                                        cropImageFile: File(imageFile!.path),
                                                        onUploadCropImage: (file) => getImage(file: file, context: context),
                                                      ),
                                                    ));
                                              }
                                            },
                                            onDeleteProfilePicTap: () async {
                                              deleteImage();
                                            },
                                            onGalleryTap: () async {
                                              await getImageFile(ImageSource.gallery);
                                              if (imageFile != null) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => CropImageScreen(
                                                        cropImageFile: File(imageFile!.path),
                                                        onUploadCropImage: (file) => getImage(file: file, context: context),
                                                      ),
                                                    ));
                                              }
                                              //   getImage(source: ImageSource.gallery, context: context);
                                            },
                                            deleteShow: true);
                                      },
                                      child: CustomContainer(
                                        width: 110.w,
                                        height: 28.h,
                                        containerColor: CustomColor.dark,
                                        radius: 18,
                                        child: Center(
                                            child: Text(
                                          'Myin_Edit_0000'.tr(),
                                          style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.lightWhite),
                                        )),
                                      ),
                                    ),
                                    hSize(32),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: CustomContainer(
                                        width: double.infinity,
                                        height: 344.h,
                                        radius: 12,
                                        containerColor: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Sign_Inup_0028'.tr(),
                                                      style: CustomTextStyle.headerXS,
                                                    ),
                                                    Text(
                                                      '${ref.watch(nickNameProvider)}/12',
                                                      style: CustomTextStyle.descriptionS,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              hSize(12),
                                              CustomContainer(
                                                width: double.infinity,
                                                height: 48.h,
                                                containerColor: CustomColor.darkWhite,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                                  child: Center(
                                                    child: TextFormField(
                                                      onChanged: (text) {
                                                        ref.watch(nickNameProvider.notifier).nicknameLength();
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter(
                                                          RegExp('[ㄱ-ㅎ|가-힣|a-zA-Z0-9]'),
                                                          allow: true,
                                                        )
                                                      ],
                                                      maxLength: 12,
                                                      controller: ref.watch(nickNameProvider.notifier).nickNameController,
                                                      obscuringCharacter: '*',
                                                      decoration: InputDecoration(
                                                        hintText: ('Sign_Inup_0029'.tr()),
                                                        hintStyle: Theme.of(context).textTheme.bodyLarge,
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.zero,
                                                        isDense: true,
                                                        counterText: "",
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(color: CustomColor.dark),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              hSize(32),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Myin_Edit_0001'.tr(),
                                                      style: CustomTextStyle.headerXS,
                                                    ),
                                                    Text(
                                                      '${ref.watch(introductionNameProvider)}/130',
                                                      style: CustomTextStyle.descriptionS,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              hSize(12),
                                              Expanded(
                                                child: CustomContainer(
                                                  width: double.infinity,
                                                  containerColor: CustomColor.darkWhite,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                                                    child: TextFormField(
                                                      onChanged: (text) {
                                                        ref.watch(introductionNameProvider.notifier).introductionLength();
                                                      },
                                                      maxLines: null,
                                                      maxLength: 130,
                                                      controller:
                                                          ref.watch(introductionNameProvider.notifier).introductionController,
                                                      decoration: InputDecoration(
                                                        hintText: ('Myin_Edit_0002'.tr()),
                                                        hintStyle: Theme.of(context).textTheme.bodyLarge,
                                                        border: InputBorder.none,
                                                        counterText: "",
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(color: CustomColor.dark),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    hSize(77),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                                          child: CustomButton(
                                            title: 'Care_Resu_0011'.tr(),
                                            onTap: () async {
                                              await onTapSaveButton(context, ref);
                                            },
                                            height: 46.h,
                                            bgColor: CustomColor.primary,
                                            borderColor: CustomColor.primary,
                                            textColor: CustomColor.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
              loadingScreen()
            ],
          ),
        );
      },
    );
  }

  getImageFile(ImageSource source) async {
    var imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = File(file!.path);
    });
  }

  Future<void> onTapSaveButton(BuildContext context, WidgetRef ref) async {
    safePrint("call save===>");
    setState(() {
      FocusScope.of(context).unfocus();
      ref.watch(loadingProvider.notifier).isLoadingTrue();
    });
    Map<String, dynamic> updateProfileData = {
      "name": userData?.name ?? "",
      "birthday": userData?.birth_date ?? "",
      "gender": userData?.gender ?? "",
      "email": userData?.email ?? "",
      "profileImage": _imageUrl==null ? '' : _imageUrl == "" ? userData?.profile_image! : _imageUrl,
      "is_deleted": 0,
      "nickName": ref.watch(nickNameProvider.notifier).nickNameController.text,
      "introduction": ref.watch(introductionNameProvider.notifier).introductionController.text.isNotEmpty?ref.watch(introductionNameProvider.notifier).introductionController.text:'pending'
    };

    await ref.watch(editProfileNotifier.notifier).getEditProfile(updateProfileData: updateProfileData);

    var userProfileData = await ref.watch(userDataProvider.notifier).getUserProfileData();
    safePrint("get userData===>${userProfileData?.nick_name}");
    LocalDB localDB = LocalDB();
    UserData? updateInfo = UserData(
      user_id: userProfileData?.user_id ?? "",
      name: userProfileData?.name ?? "",
      birth_date: userProfileData?.birth_date ?? "",
      gender: userProfileData?.gender ?? "",
      email: userProfileData?.email ?? "",
      profile_image: _imageUrl == "" ? userProfileData?.profile_image! : _imageUrl,
      nick_name: ref.watch(nickNameProvider.notifier).nickNameController.text,
      social_token: userProfileData?.social_token,
      created_at: userProfileData?.created_at,
      updated_at: userProfileData?.user_id,
      is_deleted: userProfileData?.is_deleted,
      login_type: userProfileData?.login_type,
      password: userProfileData?.password,
      comment: userProfileData?.comment,
      introduction: ref.watch(introductionNameProvider.notifier).introductionController.text==""?"pending":ref.watch(introductionNameProvider.notifier).introductionController.text,
      post: userProfileData?.post,
      role: userProfileData?.role,
      shipping: userProfileData?.shipping,
      privacy_settings: userProfileData?.privacy_settings,
      notification_settings: userProfileData?.notification_settings,
    );

    localDB.updateUserInfo(updateInfo);

    setState(() {
      ref.watch(loadingProvider.notifier).isLoadingFalse();
    });

    if (ref.watch(editProfileNotifier.notifier).isSuccess) {
      completeBottomSheet(
          context: context,
          description: 'Myin_Edit_0005',
          onTap: () {
            context.pop();
            context.pop();
          });
    }
  }

  getImage({required File? file, required BuildContext context}) async {
    context.pop();
    context.pop();

    if (file != null) {
      safePrint("get _imageUrl===>$_imageUrl");
      setState(() {
        ref.watch(loadingProvider.notifier).isLoadingTrue();
      });
      final imageRepository = ImageRepository();
      try {
        var data = await imageRepository.uploadImage(file.path);
        safePrint("get _imageUrl==uploaded=>$data");
        _imageUrl = data;
        userData = userData!.copyWith(profile_image: data);
      } on Exception catch (e) {
        setState(() {
          ref.watch(loadingProvider.notifier).isLoadingFalse();
        });
      }

      setState(() {
        ref.watch(loadingProvider.notifier).isLoadingFalse();
      });
    }
  }

  deleteImage() async {
    ref.watch(imageController.notifier).state == null;
    context.pop();
    try {
      _imageUrl = null;
      userData = userData!.copyWith(profile_image: null);
      // ignore: empty_catches
    } catch (e) {}

    setState(() {});
  }

  getBackupImage({required ImageSource source, required BuildContext context}) async {
    context.pop();
    var imagePicker = ImagePicker();
    var pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: CustomColor.black,
            toolbarWidgetColor: CustomColor.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'title',
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
            aspectRatioLockDimensionSwapEnabled: false,
            aspectRatioPickerButtonHidden: true,
          ),
        ],
      );
      if (croppedFile != null) {
        safePrint("get _imageUrl===>$_imageUrl");
        setState(() {
          ref.watch(loadingProvider.notifier).isLoadingTrue();
        });
        final imageRepository = ImageRepository();
        var data = await imageRepository.uploadImage(croppedFile.path);
        _imageUrl = data;

        safePrint("get _imageUrl==uploaded=>$data");

        setState(() {
          ref.watch(loadingProvider.notifier).isLoadingFalse();
        });

        // ref.read(imageController.notifier).updateImage(croppedFile.path);
        // imageProvider.updateImage(croppedFile.path);
      }
    }
  }
}

final introductionNameProvider = StateNotifierProvider<IntroductionNameProvider, int>((ref) {
  return IntroductionNameProvider();
});

class IntroductionNameProvider extends StateNotifier<int> {
  IntroductionNameProvider() : super(0);
  TextEditingController introductionController = TextEditingController();

  introductionSetLength(int length) => state = length;

  introductionLength() => state = introductionController.text.length;
}
