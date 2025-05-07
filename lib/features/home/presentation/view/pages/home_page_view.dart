import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/pages/appointment_page_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/favorite_doctor_view.dart';
import 'package:doctors_appointment/features/home/presentation/view/pages/home_page_view_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/custom_navigation_button.dart';
import 'package:doctors_appointment/features/setting/presentation/view/pages/Setting_or_login_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constant/constant.dart';
import 'no_connection_view_body.dart';

class HomePageView extends StatefulWidget {
  HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool isLogin = false;
  int selectedIndex = 0;
  int authUserId = 0;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
      log((result[0] == ConnectivityResult.wifi).toString());
      log(ConnectivityResult.wifi.toString());
      log(result.toString());
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  Future<void> _checkLoginStatus() async {
    final loginStatus = await Pref.getBool(KIsLogin);

    final authUser = await Pref.getInt(KauthUserId);

    setState(() {
      isLogin = loginStatus;
      authUserId = authUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePageViewCubit(),
      AppointmentPageView(),
      FavoriteDoctorView(),
      SettingOrLoginViewCubit()
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
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: _connectionStatus[0] == ConnectivityResult.none
              ? NoConnectionViewBody()
              : IndexedStack(
                  index: selectedIndex,
                  children: _pages,
                ),
        ),
      ),
    );
  }
}
