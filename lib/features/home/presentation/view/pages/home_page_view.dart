import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/pages/appointment_page_view.dart';
import 'package:doctors_appointment/features/auth/presentation/view/signin_or_login.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/favorite_doctor_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/home_page_view_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/custom_navigation_button.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/constant.dart';

class HomePageView extends StatefulWidget {
  HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool isLogin = false;
  int selectedIndex = 0;
  int authUserId = 0;

  Future<void> _checkLoginStatus() async {
    final loginStatus = await Pref.getBool(KIsLogin);
    final authUser = await Pref.getInt(KauthUserId);
    setState(() {
      isLogin = loginStatus;
      authUserId = authUser;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePageViewCubit(),
      AppointmentPageView(),
      FavoriteDoctorView(),
      if (!isLogin) SigninOrLogin(),
      if (isLogin)
        Center(
          child: TextButton(
              onPressed: () {
                setState(() {
                  Pref.setBool(KIsLogin, false);
                  Pref.setInt(KauthUserId, 0);
                  isLogin = false;
                  authUserId = 0;
                  BlocProvider.of<FavoritesCubit>(context).getAllFavorites(0);
                });
              },
              child: Text("logout")),
        )
    ];

    return Scaffold(
      bottomNavigationBar: CustomNavigationButton(
        onChange: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
        selectedIndex: selectedIndex,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8,),
          child: IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
        ),
      ),
    );
  }
}
