import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/notification_cubit.dart';
import 'notification_page_view_body.dart';


class NotificationPageViewBodyBlocConsumer extends StatefulWidget {
  const NotificationPageViewBodyBlocConsumer({super.key});

  @override
  State<NotificationPageViewBodyBlocConsumer> createState() => _NotificationPageViewBodyBlocConsumerState();
}

class _NotificationPageViewBodyBlocConsumerState extends State<NotificationPageViewBodyBlocConsumer> {
  @override

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationError) {
         buildSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NotificationLoaded) {
          final List<NotificationsEntity> notifications = state.notifications;

          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          return NotificationPageViewBody(notifications:state.notifications);
        } else if (state is NotificationError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox(); 
      },
    );
  }
}
