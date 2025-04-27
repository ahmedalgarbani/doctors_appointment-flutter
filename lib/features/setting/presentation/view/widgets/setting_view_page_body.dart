import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/features/appointment/presentation/viewModel/cubit/appointment_cubit.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';
import '../../../../home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';

class SettingViewPageBody extends StatefulWidget {
  @override
  State<SettingViewPageBody> createState() => _SettingViewPageBodyState();
}

class _SettingViewPageBodyState extends State<SettingViewPageBody> {
  @override
  void initState() {
    super.initState();
    // context.read<AuthCubit>().loadAuthUserId();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildProfileHeader(context),
        const SizedBox(height: 24),
        _buildSectionCard(
          title: "الإعدادات",
          children: [
            _buildListTile(Icons.person, "تعديل بيانات المستخدم", onTap: () {
              // GoRouter.of(context).push(AppRouter.KEditProfileView);
            }),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: "الأقسام",
          children: [
            _buildListTile(Icons.favorite, "المفضلة", onTap: () {
              GoRouter.of(context).push(AppRouter.KFavoriteDoctorView);
            }),
            _buildListTile(Icons.calendar_today, "مواعيدي", onTap: () {}),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: "التفضيلات",
          children: [
            _buildListTile(Icons.notifications, "الإشعارات", onTap: () {
              GoRouter.of(context).push(AppRouter.KNotificationPageView);
            }),
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
        Center(
          child: Column(
            children: [
              const Text("Version 1.0.3", style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Terms & Privacy",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 60),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(24, 70, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "John Smith",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "AhmedMohamed@gmail.com",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "+967 777 123 456",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
          ),
        ),
      ],
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
                style: const TextStyle(
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
