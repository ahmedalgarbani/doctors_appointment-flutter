import 'package:doctors_appointment/features/home/presentation/view/pages/home_page_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String Kroot = '/';


  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Kroot,
       builder: (context, state) => const HomePageView()
      ),
    ],
  );
}
