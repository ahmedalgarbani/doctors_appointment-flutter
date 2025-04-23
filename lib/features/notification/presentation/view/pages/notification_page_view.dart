import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/notification/domain/repositories/notification_repo.dart';
import 'package:doctors_appointment/features/notification/presentation/view/widgets/notification_page_view_body_bloc_consumer.dart';
import 'package:doctors_appointment/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPageView extends StatelessWidget {
  const NotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: BlocProvider(
            create: (context) => NotificationCubit(getIt.get<NotificationRepository>()),
            child: NotificationPageViewBodyBlocConsumer(),
          ),
        ),
      ),
    );
  }
}
