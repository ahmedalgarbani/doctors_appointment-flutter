import 'dart:developer';

import 'package:doctors_appointment/features/Splash/presenttation/view/splash_page.dart';
import 'package:doctors_appointment/features/auth/presentation/view/signup_page_view.dart';
import 'package:doctors_appointment/features/auth/presentation/view/signin_page_view.dart';
import 'package:doctors_appointment/features/blog/data/model/blog_model.dart';
import 'package:doctors_appointment/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:doctors_appointment/features/blog/presentation/view/pages/blog_detail_page.dart';
import 'package:doctors_appointment/features/blog/presentation/view/pages/blog_list_page.dart';
import 'package:doctors_appointment/features/checkout/presentation/view/pages/check_out_page_view.dart';
import 'package:doctors_appointment/features/checkout/presentation/view/pages/checkout_done_page_view.dart';
import 'package:doctors_appointment/features/edit_profile/presentation/view/pages/change_password_view.dart';
import 'package:doctors_appointment/features/edit_profile/presentation/view/pages/edit_profile_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/all_specialties_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/doctor_detail_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/favorite_doctor_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/home_page_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/all_doctors_page_view.dart';
import 'package:doctors_appointment/features/notification/presentation/view/pages/notification_page_view.dart';
import 'package:doctors_appointment/features/onBoarding/presenttation/view/OnBoarding.dart';
import 'package:doctors_appointment/features/search/presentation/view/pages/search_page_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/data/models/speciality_response/doctor.dart';

abstract class AppRouter {
  static const String Kroot = '/';
  static const String KHomePage = '/KHomePage';
  static const String KSearchPage = '/KSearchPage';
  static const String KSplashPage = '/KSplashPage';
  static const String KObBoarding = '/KObBoarding';
  static const String KSignin = '/KSignin';
  static const String KSignup = '/KSignup';
  static const String KDoctorDetail = '/KDoctorDetail';
  static const String KCheckOutPageView = '/KCheckOutPageView';
  static const String KCheckOutDonePageView = '/KCheckOutDonePageView';
  static const String KAllSpecialitesView = '/KAllSpecialitesView';
  static const String KFavoriteDoctorView = '/KFavoriteDoctorView';
  static const String KNotificationPageView = '/KNotificationPageView';
  static const String KallDoctors = '/KallDoctors';
  static const String KSigninOrSignUp = '/KSigninOrSignUp';
  static const String KEditProfileView = '/KEditProfileView';
  static const String KChangePasswordView = '/KChangePasswordView';
  static const String KBlogListPage = '/KBlogListPage';
  static const String KBlogDetailPage = '/KBlogDetailPage';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Kroot,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: KDoctorDetail,
        builder: (context, state) {
          var extra = state.extra;
          return DoctorDetailView(doctorModel: extra as Doctor);
        },
      ),
      GoRoute(
        path: KHomePage,
        builder: (context, state) => HomePageView(),
      ),
      GoRoute(
        path: KCheckOutPageView,
        builder: (context, state) {
          var extra = state.extra as Map<String, dynamic>;
          return CheckOutPageView(
            bookingDetail: extra,
          );
        },
      ),
      GoRoute(
        path: KAllSpecialitesView,
        builder: (context, state) => const AllSpecialtiesView(),
      ),
      GoRoute(
          path: KFavoriteDoctorView,
          builder: (context, state) {
            var extra = state.extra as dynamic;
            log(extra.toString());
            log(extra.toString());
            return FavoriteDoctorView(
              isSetting: extra?['isSetting'] as bool,
            );
          }),
      GoRoute(
        path: KCheckOutDonePageView,
        builder: (context, state) => const CheckoutDonePageView(),
      ),
      GoRoute(
        path: KNotificationPageView,
        builder: (context, state) => const NotificationPageView(),
      ),
      GoRoute(
          path: KallDoctors,
          builder: (context, state) {
            List<Doctor>? extra = state.extra as List<Doctor>?;
            return AllDoctorsPageView(
              allDoctors: extra,
            );
          }),
      GoRoute(
        path: KSplashPage,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: KObBoarding,
        builder: (context, state) => const OnBoarding(),
      ),
      GoRoute(
        path: KSignin,
        builder: (context, state) => SigninPageView(),
      ),
      GoRoute(
        path: KSignup,
        builder: (context, state) => SignupPageView(),
      ),
      GoRoute(
        path: KSearchPage,
        builder: (context, state) {
          var extra = state.extra;
          return SearchPageView(
            textString: extra as String?,
          );
        },
      ),
      GoRoute(
        path: KEditProfileView,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: KChangePasswordView,
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
  path: AppRouter.KBlogListPage,
  builder: (context, state) => BlocProvider(
    create: (_) => BlogCubit(),
    child: const BlogListPage(),
  ),
),

      GoRoute(
        path: KBlogDetailPage,
        builder: (context, state) {
          final post = state.extra as BlogPost;
          return BlogDetailPage(post: post);
        },
      ),
    ],
  );
}
