import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/empty_appointment_view.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/past_appointment_view.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/tab_header_button.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/upcooming_booking.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/booking_model.dart';

class AppointmentPageViewBody extends StatefulWidget {
  const AppointmentPageViewBody({super.key, required this.upcooming, required this.history});
  final List<BookingModel> upcooming;
  final List<BookingModel> history;

  @override
  State<AppointmentPageViewBody> createState() =>
      _AppointmentPageViewBodyState();
}

class _AppointmentPageViewBodyState extends State<AppointmentPageViewBody> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomePageHeader(
          title: "My Appointment",
          iconData: Icons.add_circle,
          onPressed: () {
            GoRouter.of(context).push(AppRouter.KHomePage);
          },
        ),
        const SizedBox(height: 16),
        TabHeaderButton(
          activeTab: activeTab,
          onTabChange: (int tab) {
            setState(() {
              activeTab = tab;
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: activeTab == 0
              ? widget.upcooming.length == 0?const EmptyAppointmentView():UpcoomingBooking(allBookings: widget.upcooming)
              : widget.history.length == 0?const EmptyAppointmentView(): PastAppointmentView(allBookings: widget.history,),
        ),
      ],
    );
  }
}
