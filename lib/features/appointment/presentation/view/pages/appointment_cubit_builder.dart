import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/cubit/appointment_cubit.dart';
import '../widgets/appointment_page_view_body.dart';

class AppointmentCubitBuilder extends StatefulWidget {
  const AppointmentCubitBuilder({
    super.key,
  });

  @override
  State<AppointmentCubitBuilder> createState() =>
      _AppointmentCubitBuilderState();
}

class _AppointmentCubitBuilderState extends State<AppointmentCubitBuilder> {
  getAppointmnets() {
    context.read<AppointmentCubit>().getBookings();
  }

  @override
  void initState() {
    super.initState();

    getAppointmnets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AppointmentFailure) {
          return AppointmentPageViewBody(
            history: [],
            upcooming: [],
          );
        } else if (state is AppointmentSuccess) {
          return AppointmentPageViewBody(
            history: state.historyBookings ?? [],
            upcooming: state.upcomingBookings ?? [],
          );
          // return Column(
          //   children: [
          //     Text("Upcoming: ${state.upcomingBookings!.length}"),
          //     Text("History: ${state.historyBookings!.length}"),
          //   ],
          // );
        }
        return SizedBox.shrink();
      },
    );
  }
}
