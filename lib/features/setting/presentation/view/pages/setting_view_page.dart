import 'package:flutter/material.dart';

import 'Setting_or_login_view_cubit.dart';

class SettingViewPage extends StatelessWidget {
  const SettingViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SettingOrLoginViewCubit(),
    );
  }
}
