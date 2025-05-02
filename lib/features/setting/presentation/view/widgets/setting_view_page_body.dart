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
    // تحديد ما إذا كان الوضع داكنًا أو فاتحًا
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildProfileHeader(context, isDarkMode),
        const SizedBox(height: 24),
        _buildSectionCard(
          title: "الإعدادات",
          children: [
            _buildListTile(Icons.person, "تعديل بيانات المستخدم", onTap: () {
              GoRouter.of(context).push(AppRouter.KEditProfileView);
            }, isDarkMode: isDarkMode),
            _buildListTile(Icons.lock, "تعديل كلمة المرور", onTap: () {
              GoRouter.of(context).push(AppRouter.KChangePasswordView);
            }, isDarkMode: isDarkMode),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: "الأقسام",
          children: [
            _buildListTile(Icons.favorite, "المفضلة", onTap: () {
              GoRouter.of(context).push(AppRouter.KFavoriteDoctorView,
                  extra: {"isSetting": true});
            }, isDarkMode: isDarkMode),
            _buildListTile(Icons.calendar_today, "مواعيدي",
                onTap: () {}, isDarkMode: isDarkMode),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: "التفضيلات",
          children: [
            _buildListTile(Icons.notifications, "الإشعارات", onTap: () {
              GoRouter.of(context).push(AppRouter.KNotificationPageView);
            }, isDarkMode: isDarkMode),
            _buildListTile(Icons.palette, "المظهر",
                onTap: () {}, isDarkMode: isDarkMode),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: "التواصل",
          children: [
            _buildListTile(Icons.support_agent, "تواصل معنا",
                onTap: () {}, isDarkMode: isDarkMode),
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
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDarkMode) {
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
            color: isDarkMode ? Colors.black : Colors.white,
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
              decoration: BoxDecoration(
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
    bool isDarkMode = false,
  }) {
    return ListTile(
      leading: Icon(icon,
          color: iconColor ??
              (isDarkMode ? Colors.white : Theme.of(context).primaryColor)),
      title: Text(
        title,
        style: TextStyle(
            color: textColor ?? (isDarkMode ? Colors.white : Colors.black)),
        textAlign: TextAlign.right,
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          size: 16, color: isDarkMode ? Colors.white : Colors.black),
      onTap: onTap,
    );
  }
}
