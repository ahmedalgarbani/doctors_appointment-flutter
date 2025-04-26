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
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header Section (Profile)
        _buildProfileHeader(),
        const SizedBox(height: 24),

        // Main Sections (Combining both designs)
        _buildSectionCard(
          title: "الأقسام",
          children: [
            // _buildListTile(Icons.article, "مقالات طبية", onTap: () {}),
            _buildListTile(Icons.favorite, "المفضلة", onTap: () {}),
            _buildListTile(Icons.calendar_today, "مواعيدي", onTap: () {}),
          ],
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: "التفضيلات",
          children: [
            _buildListTile(Icons.notifications, "الإشعارات", onTap: () {}),
            _buildListTile(Icons.palette, "المظهر", onTap: () {}),
          ],
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: "عن التطبيق",
          children: [
            _buildListTile(Icons.privacy_tip, "سياسة الخصوصية", onTap: () {}),
            _buildListTile(Icons.description, "شروط الاستخدام", onTap: () {}),
            _buildListTile(Icons.info, "من نحن", onTap: () {}),
          ],
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: "التواصل",
          children: [
            _buildListTile(Icons.support_agent, "تواصل معنا", onTap: () {}),
            _buildListTile(Icons.star, "تقييم", onTap: () {}),
            _buildListTile(Icons.share, "مشاركة", onTap: () {}),
          ],
        ),

        const SizedBox(height: 16),

        // Logout and FAQ
        _buildSectionCard(
          children: [
            _buildListTile(
              Icons.logout,
              "تسجيل خروج",
              onTap: () {
                context.read<AuthCubit>().logout();
                context.read<FavoritesCubit>().getAllFavorites(isLogout: true);
                context.read<AppointmentCubit>().getBookings(isLogout: true);
                context.read<HomeCubit>().getHomeFeatures();
              },
              textColor: Colors.red,
              iconColor: Colors.red,
            ),
            _buildListTile(Icons.help, "الأسئلة الشائعة", onTap: () {}),
          ],
        ),

        const SizedBox(height: 24),

        // Footer
        Center(
          child: Column(
            children: [
              const Text("Version 1.0.3", style: TextStyle(color: Colors.grey)),
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

  Widget _buildProfileHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/images/profile.png'), // Replace with your image
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Smith",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "AhmedMohamed@gmail.com",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                GoRouter.of(context).push(AppRouter.KNotificationPageView);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({String? title, required List<Widget> children}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 12, left: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Theme.of(context).primaryColor),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
        textAlign: TextAlign.right,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
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
