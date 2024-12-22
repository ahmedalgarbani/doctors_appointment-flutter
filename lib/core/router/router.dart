import 'package:doctors_appointment/features/checkout/presentation/pages/check_out_page_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/doctor_detail_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/home_page_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String Kroot = '/';
  static const String KDoctorDetail = '/KDoctorDetail';
  static const String KCheckOutPageView = '/KCheckOutPageView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: Kroot, builder: (context, state) => const HomePageView()),
      GoRoute(
          path: KDoctorDetail,
          builder: (context, state) => const DoctorDetailView()),
      GoRoute(
          path: KCheckOutPageView,
          builder: (context, state) => const CheckOutPageView()),
    ],
  );
}
