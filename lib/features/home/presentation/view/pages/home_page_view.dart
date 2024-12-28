import 'package:doctors_appointment/features/appointment/presentation/view/pages/appointment_page_view.dart';
import 'package:doctors_appointment/features/auth/presentation/view/signin_or_login.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/favorite_doctor_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/custom_navigation_button.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_page_view_body.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  HomePageView({super.key});
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int selectedIndex = 0;
  List<Widget> _pages = [
    HomePageViewBody(),
    AppointmentPageView(),
    FavoriteDoctorView(),
    
    SigninOrLogin()
  ];
  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(
              left: 8, right: 8),
          child: IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
        ),
      ),
    );
  }
}
