import 'dart:developer';

import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/features/appointment/presentation/viewModel/cubit/appointment_cubit.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';
import '../../../../home/presentation/view/widgets/home_widgets/home_page_header.dart';
import '../../../../home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';

class SettingViewPageBody extends StatefulWidget {
  @override
  State<SettingViewPageBody> createState() => _SettingViewPageBodyState();
}

class _SettingViewPageBodyState extends State<SettingViewPageBody> {
  initState() {
    super.initState();
    // context.read<AuthCubit>().loadAuthUserId();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        HomePageHeader(
          iconData: Icons.edit,
          title: "Profile",
          onPressed: () {
            GoRouter.of(context).push(AppRouter.KNotificationPageView);
          },
        ),
        _buildProfileSection(),
        const Divider(),
        _buildSettingsTile(Icons.person, "Account Settings", onTap: () {}),
        const SizedBox(height: 10),
        _buildSectionHeader("Preferences"),
        _buildSettingsTile(Icons.notifications, "Notifications", onTap: () {}),
        _buildSettingsTile(Icons.palette, "Appearance", onTap: () {}),
        const SizedBox(height: 10),
        _buildSectionHeader("Resources"),
        _buildSettingsTile(Icons.support_agent, "Contact Support",
            onTap: () {}),
        _buildSettingsTile(Icons.star, "Rate in App Store", onTap: () {}),
        _buildSettingsTile(Icons.alternate_email, "Follow @LumaHQ",
            onTap: () {}),
        _buildSettingsTile(Icons.storage, "Data Sources", onTap: () {}),
        _buildSettingsTile(Icons.logout, "Sign Out", onTap: () {
          context.read<AuthCubit>().logout();
          context.read<FavoritesCubit>().getAllFavorites(isLogout: true);
          context.read<AppointmentCubit>().getBookings(isLogout: true);
          context.read<HomeCubit>().getHomeFeatures();
        }, iconColor: Colors.red),
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              const Text("Version 1.0.3 ",
                  style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () {},
                child: const Text("Terms & Privacy",
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title,
      {VoidCallback? onTap, Color? iconColor}) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.black),
      title: Text(title),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildProfileSection() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(AppImage.AlKuraimi),
      ),
      title: Text(
        "John Smith",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "AhmedMohamed@gmail.com",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
