import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';
import 'package:doctors_appointment/features/notification/domain/repositories/notification_repo.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repository;
  NotificationCubit(this.repository) : super(NotificationInitial());




  void getNotifications() async {
    emit(NotificationLoading());
    try {
      final notifications = await repository.getAllNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
