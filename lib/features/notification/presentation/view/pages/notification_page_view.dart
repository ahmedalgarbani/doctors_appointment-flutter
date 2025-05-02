import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/notification/domain/repositories/notification_repo.dart';
import 'package:doctors_appointment/features/notification/presentation/view/widgets/notification_page_view_body_bloc_consumer.dart';
import 'package:doctors_appointment/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPageView extends StatelessWidget {
  const NotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "الإشعارات",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.right, // محاذاة النص لليمين
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          // إضافة Directionality لتحديد اتجاه النص
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (context) =>
                NotificationCubit(getIt.get<NotificationRepository>()),
            child: const NotificationPageViewBodyBlocConsumer(),
          ),
        ),
      ),
    );
  }
}
