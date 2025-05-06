import 'package:flutter/material.dart';
import '../../../data/models/booking_model.dart';
import 'appointment_status.dart';
import 'booking_item.dart';

class BookingListViewItem extends StatelessWidget {
  const BookingListViewItem({super.key, required this.allBookings});
  final List<BookingModel> allBookings;

  AppointmentStatus _parseStatus(String status) {
    return AppointmentStatus.values.firstWhere(
      (e) => e.toString().split('.').last == status.toLowerCase(),
      orElse: () => AppointmentStatus.pending,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allBookings.length,
      itemBuilder: (context, index) {
        return BookingItem(
          bookingModel: allBookings[index],
          trailing: AppointmentStatusWidget(
            status: _parseStatus(allBookings[index].status),
          ),
        );
      },
    );
  }
}