import 'dart:developer';

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/date_picker_input_field.dart';
import '../../../../search/presentation/view/widgets/filter_card.dart';
import '../../../data/models/speciality_response/hospital.dart';

class DoctorScedualBottomSheet extends StatefulWidget {
  const DoctorScedualBottomSheet({
    Key? key,
    required this.doctorModel,
  }) : super(key: key);

  final Doctor doctorModel;

  @override
  State<DoctorScedualBottomSheet> createState() =>
      _DoctorScedualBottomSheetState();
}

class _DoctorScedualBottomSheetState extends State<DoctorScedualBottomSheet> {
  Hospital? _selectedHospital;
  String? _selectedDay;
  String? _selectedDay_id;
  String? _selectedTime;
  String? _selectedTime_id;
  String? _bookingDate;

  @override
  void initState() {
    super.initState();
    if (widget.doctorModel.hospitals != null &&
        widget.doctorModel.hospitals!.isNotEmpty) {
      _selectedHospital = widget.doctorModel.hospitals!.first;
    }
  }

  List<String> get availableDays {
    if (_selectedHospital == null || widget.doctorModel.schedules == null) {
      return [];
    }
    return widget.doctorModel.schedules!
        .where((schedule) => schedule.hospital?.id == _selectedHospital!.id)
        .map((schedule) => schedule.dayName ?? '')
        .toSet()
        .toList();
  }

  List<String> get availableTimes {
    if (_selectedHospital == null ||
        _selectedDay == null ||
        widget.doctorModel.schedules == null) {
      return [];
    }
    try {
      final schedule = widget.doctorModel.schedules!.firstWhere(
        (s) =>
            s.hospital?.id == _selectedHospital!.id &&
            s.dayName == _selectedDay,
      );
      return schedule.shifts
              ?.map((shift) =>
                  "${shift.startTime ?? ''} - ${shift.endTime ?? ''}")
              .toSet()
              .toList() ??
          [];
    } catch (e) {
      return [];
    }
  }

  void _selectHospital(Hospital hospital) {
    setState(() {
      if (_selectedHospital?.id != hospital.id) {
        _selectedHospital = hospital;
        _selectedDay = null;
        _selectedTime = null;
        _selectedDay_id = null;
        _selectedTime_id = null;
      }
    });
  }

  void _selectDay(String day) {
    setState(() {
      _selectedDay = day;
      _selectedTime = null;
      _selectedTime_id = null;

      try {
        final schedule = widget.doctorModel.schedules!.firstWhere(
          (s) =>
              s.hospital?.id == _selectedHospital!.id &&
              s.dayName == _selectedDay,
        );
        _selectedDay_id = schedule.id?.toString();
      } catch (e) {
        _selectedDay_id = null;
      }
    });
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;

      try {
        final schedule = widget.doctorModel.schedules!.firstWhere(
          (s) =>
              s.hospital?.id == _selectedHospital!.id &&
              s.dayName == _selectedDay,
        );

        final shift = schedule.shifts!.firstWhere((shift) =>
            "${shift.startTime ?? ''} - ${shift.endTime ?? ''}" == time);

        _selectedTime_id = shift.id?.toString();
      } catch (e) {
        _selectedTime_id = null;
      }
    });
  }

  void _clearSelections() {
    setState(() {
      _selectedDay = null;
      _selectedTime = null;
      _selectedDay_id = null;
      _selectedTime_id = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Hospitals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.doctorModel.hospitals
                        ?.map(
                          (hospital) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(
                                hospital.name ?? '',
                              ),
                              labelStyle: TextStyle(
                                  color: _selectedHospital?.id == hospital.id
                                      ? Colors.white
                                      : Colors.black),
                              selected: _selectedHospital?.id == hospital.id,
                              selectedColor: AppColor.primaryColor,
                              backgroundColor: Colors.transparent,
                              onSelected: (_) => _selectHospital(hospital),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DatePickerInputField(
              hintText: "birthDate",
              onDateSelected: (date) {
                _bookingDate = DateFormat('yyyy-MM-dd').format(date);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Days',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemCount: availableDays.length,
              itemBuilder: (context, index) {
                final day = availableDays[index];
                return FilterCard(
                  title: day,
                  isActive: _selectedDay == day,
                  onTap: () => _selectDay(day),
                );
              },
            ),
            const SizedBox(height: 20),
            if (_selectedDay != null) ...[
              const Text(
                'Times',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                ),
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  final time = availableTimes[index];
                  return FilterCard(
                    title: time,
                    isActive: _selectedTime == time,
                    onTap: () => _selectTime(time),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
            CustomButton(
              height: 55,
              title: "Apply",
              onPressed: () {
                if (_selectedHospital != null &&
                    _selectedDay != null &&
                    _selectedTime != null &&
                    _selectedDay_id != null &&
                    _selectedTime_id != null) {
                  GoRouter.of(context).pushReplacement(
                    AppRouter.KCheckOutPageView,
                    extra: {
                      'hospital': _selectedHospital,
                      'doctor': widget.doctorModel,
                      'day': _selectedDay,
                      'day_id': _selectedDay_id,
                      'time': _selectedTime,
                      'time_id': _selectedTime_id,
                      'booking_date': _bookingDate,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select all fields')),
                  );
                }
              },
            ),
            TextButton(
              onPressed: _clearSelections,
              child: Text(
                "Clear the Filter",
                style: TextStyles.Bold12.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
