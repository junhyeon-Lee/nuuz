import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/device_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/faq_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/favoriteprograms/favorite_program_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/app_setting.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/customer.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/device_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/event.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/my_info.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/myinfo/privacy_settings.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer/myinfo/withdrawal_screen.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/notice_screen.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosis.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/skin_self_diagnosis_screen.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/home/nuuz_my/one_result.dart';
import 'package:nuuz/modules/nuuz_talk/edit_post_screen.dart';
import 'package:nuuz/modules/nuuz_talk/nuuz_talk_search.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_details.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_registration.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/scan_qr_screen.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/select_product_screen.dart';
import 'package:nuuz/modules/nuzz_care/result/capture_image_screen.dart';
import 'package:nuuz/modules/nuzz_care/result/care_result_home.dart';
import 'package:nuuz/modules/nuzz_care/result/care_result_shoot.dart';
import 'package:nuuz/modules/nuzz_care/video_guide/caution_warning_screen.dart';
import 'package:nuuz/modules/nuzz_care/video_guide/video_guide_main.dart';
import 'package:nuuz/modules/product/complete_order_screen.dart';
import 'package:nuuz/modules/product/mileage_shop_see_all_screen.dart';
import 'package:nuuz/modules/product/mileage_terms_screen.dart';
import 'package:nuuz/modules/product/order_product_screen.dart';
import 'package:nuuz/modules/product/product_detail_screen.dart';
import 'package:nuuz/modules/sign/auth/sign_screen.dart';
import 'package:nuuz/modules/sign/service_guide/service_guide_screen.dart';
import 'package:nuuz/modules/sign/splash/splash_screen.dart';

import 'modules/drawer/my_drawer/my_drawer/coupon.dart';
import 'modules/drawer/my_drawer/my_drawer/edit_profile.dart';
import 'modules/drawer/my_drawer/my_drawer/profile_image_capture.dart';
import 'modules/drawer/profile.dart';
import 'modules/home/nuuz_my/gallery.dart';
import 'modules/sign/access/access_screen.dart';
import 'modules/sign/fill_profile/fill_profile_screen.dart';
import 'modules/sign/terms_conditions/terms_conditions_screen.dart';

///라우터 GoRouter 사용했습니다.

final router = GoRouter(
  routes: [
    GoRoute(path: '/main', builder: (context, state) => const MainScreen(), routes: [
      ///my Drawer
      GoRoute(name: '/DeviceRegistrationScreen', path: 'DeviceRegistrationScreen', builder: (context, state) => const DeviceRegistrationScreen()),
      GoRoute(name: '/profile', path: 'profile', builder: (context, state) => const Profile()),
      GoRoute(name: '/coupon', path: 'coupon', builder: (context, state) => const Coupon()),
      GoRoute(name: '/edit-profile', path: 'edit-profile', builder: (context, state) => EditProfile(), routes: [
        GoRoute(name: '/profile-image', path: 'profile-image', builder: (context, state) => const ProfileImageCapture()),
      ]),
      GoRoute(name: '/app-setting', path: 'app-setting', builder: (context, state) => const AppSetting(), routes: [
        GoRoute(name: '/notification', path: 'notification', builder: (context, state) => const Notification()),
      ]),

      GoRoute(name: '/FavoriteProgramScreenHome', path: 'FavoriteProgramScreenHome', builder: (context, state) => const FavoriteProgramScreen()),

      GoRoute(name: '/DeviceScreenHome', path: 'DeviceScreenHome', builder: (context, state) => const DeviceScreen(), routes: [
        GoRoute(
            name: '/DeviceRegistrationScreenInfoHome',
            path: 'DeviceRegistrationScreenInfoHome',
            builder: (context, state) => const DeviceRegistrationScreen()),
      ]),

      GoRoute(name: '/my-info', path: 'my-info', builder: (context, state) => const MyInfo(), routes: [
        GoRoute(name: '/info-edit-profile', path: 'info-edit-profile', builder: (context, state) => EditProfile(), routes: [
          GoRoute(name: '/info-profile-image', path: 'info-profile-image', builder: (context, state) => const ProfileImageCapture()),
        ]),
        GoRoute(name: '/privacy-setting', path: 'privacy-setting', builder: (context, state) => const PrivacySetting(), routes: [
          GoRoute(name: '/WithdrawalScreen', path: 'WithdrawalScreen', builder: (context, state) => WithdrawalScreen()),
        ]),
        GoRoute(name: '/DeviceScreen', path: 'DeviceScreen', builder: (context, state) => const DeviceScreen(), routes: [
          GoRoute(
              name: '/DeviceRegistrationScreenInfo',
              path: 'DeviceRegistrationScreenInfo',
              builder: (context, state) => const DeviceRegistrationScreen()),
        ]),
        GoRoute(name: '/FavoriteProgramScreen', path: 'FavoriteProgramScreen', builder: (context, state) => const FavoriteProgramScreen()),
        GoRoute(
            name: '/SkinSelfDiagnosis',
            path: 'SkinSelfDiagnosis',
            builder: (context, state) => SkinSelfDiagnosis(
                  response: state.queryParams['response'] as SelfDiagnosisModel,
                )),
      ]),
      GoRoute(name: '/customer', path: 'customer', builder: (context, state) => const Customer(), routes: [
        GoRoute(name: '/FaqScreen', path: 'FaqScreen', builder: (context, state) => FaqScreen()),
      ]),
      GoRoute(name: '/event', path: 'event', builder: (context, state) => const EventScreen()),
      GoRoute(name: '/notice', path: 'notice', builder: (context, state) => NoticeScreen()),

      ///my nuuz
      GoRoute(name: '/gallery', path: 'gallery', builder: (context, state) => const Gallery(), routes: [
        GoRoute(
          name: '/oneResult',
          path: 'oneResult',
          builder: (context, state) => OneResult(selectedId: state.queryParams['selectedId']!),
        ),
        GoRoute(
            name: '/detailGallery', path: 'detailGallery', builder: (context, state) => DetailGallery(selectedId: state.queryParams['selectedId']!)),
      ]),
      // product
      GoRoute(
          name: '/MileageShopSeeAllScreen',
          path: 'MileageShopSeeAllScreen',
          builder: (context, state) => const MileageShopSeeAllScreen(),
          routes: [
            GoRoute(name: '/ProductDetailScreen', path: 'ProductDetailScreen', builder: (context, state) => const ProductDetailScreen(), routes: [
              GoRoute(name: '/MileageTermsScreen', path: 'MileageTermsScreen', builder: (context, state) => const MileageTermsScreen(), routes: [
                GoRoute(name: '/OrderProductScreen', path: 'OrderProductScreen', builder: (context, state) => OrderProductScreen(), routes: [
                  GoRoute(name: '/CompleteOrderScreen', path: 'CompleteOrderScreen', builder: (context, state) => const CompleteOrderScreen()),
                ]),
              ]),
            ]),
          ]),

      ///my Drawer
      ///my nuuz
      GoRoute(
        name: "select-product",
        path: 'select',
        builder: (context, state) => const SelectProductScreen(),
        routes: [
          GoRoute(
            name: "scan-qrcode",
            path: 'scanqr',
            builder: (context, state) {
              return ScanQrScreen(
                productId: state.queryParams["product_id"]!,
              );
            },
          ),
          GoRoute(
            name: "product-registration",
            path: 'registration',
            builder: (context, state) => ProductRegistration(
              productId: state.queryParams["productId"]!,
              productCode: state.queryParams["productCode"],
            ),
          ),
          GoRoute(
            name: 'program-list',
            path: 'program-list',
            builder: (context, state) => CareProgramListScreen(
              reservationDate: state.queryParams['reservation_date'],
            ),
            routes: [
              GoRoute(
                name: 'program-details',
                path: 'program-details',
                builder: (context, state) => ProgramDetails(
                  careProgramId: int.parse(state.queryParams["care_program_id"]!),
                  reservationDate: state.queryParams["reservation_date"],
                  isFavoriteState: state.queryParams["isFavoriteState"],
                ),
                routes: [
                  GoRoute(
                    name: 'video-guide',
                    path: 'video-guide',
                    builder: (context, state) => CautionWarningScreen(
                      careProgramId: int.parse(state.queryParams['care_program_id']!),
                      userCareProgramId: state.queryParams['user_care_program_id']!,
                      isCreated: state.queryParams['is_created']!,
                    ),
                    routes: [
                      GoRoute(
                        name: 'player-screen',
                        path: 'player-screen',
                        builder: (context, state) => VideoGuideMain(
                          careProgramId: int.parse(state.queryParams['care_program_id']!),
                          userCareProgramId: state.queryParams['user_care_program_id']!,
                        ),
                      ),
                      GoRoute(
                        name: 'careProgramScreen',
                        path: 'careProgramScreen',
                        builder: (context, state) => CareProgramScreen(
                          initialPart: state.queryParams['initial_part']!,
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                      name: 'care-result-shoot',
                      path: 'care-result-shoot',
                      builder: (context, state) => CareResultShoot(
                            careProgramId: int.parse(state.queryParams['care_program_id']!),
                            userCareProgramId: state.queryParams['user_care_program_id']!,
                          ),
                      routes: [
                        GoRoute(
                          name: 'capture-image',
                          path: 'capture-image',
                          builder: (context, state) => const CaptureImageScreen(),
                        ),
                        GoRoute(
                          name: 'result-home',
                          path: 'result-home',
                          builder: (context, state) => CareResultHome(
                            careProgramId: int.parse(state.queryParams['care_program_id']!),
                            image: state.queryParams['image']!,
                          ),
                        ),
                      ])
                ],
              ),
            ],
          ),
          GoRoute(
            name: 'edit-post',
            path: 'edit-post',
            builder: (context, state) => const EditPostScreen(),
          ),
          GoRoute(
            name: 'post-search',
            path: 'post-search',
            builder: (context, state) => const SearchScreen(),
          )
        ],
      ),
    ]),
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/accessScreen', builder: (context, state) => const AccessScreen()),
    GoRoute(path: '/signScreen', builder: (context, state) => const SignScreen()),
    GoRoute(path: '/termsConditionsScreen', builder: (context, state) => const TermsConditionsScreen()),
    GoRoute(path: '/fillprofileScreen', builder: (context, state) => const FillProfileScreen()),
    GoRoute(path: '/serviceguide', builder: (context, state) => const ServiceGuideScreen()),
  ],
);
