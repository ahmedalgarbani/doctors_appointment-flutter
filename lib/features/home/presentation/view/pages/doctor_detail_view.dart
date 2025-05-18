import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/doctor_header.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/doctor_tab_bar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/locations_tab.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/overview_tab.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/reviews_tab.dart';
import 'package:flutter/material.dart';
import '/core/style/app_color.dart';
import '/core/widgets/custom_button.dart';
import '../widgets/doctor_scedual_bottom_sheet.dart';

class DoctorDetailView extends StatefulWidget {
  final Doctor doctorModel;
  const DoctorDetailView({super.key, required this.doctorModel});

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تحديد الاتجاه من اليمين إلى اليسار
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الطبيب'),
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            DoctorHeader(doctor: widget.doctorModel),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Directionality(
                      textDirection: TextDirection.rtl, 
                      child: DoctorScedualBottomSheet(
                        doctorModel: widget.doctorModel,
                      ),
                    ),
                  );
                },
                title: 'احجز موعد',
              ),
            ),
            DoctorTabBar(controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  OverviewTab(doctor: widget.doctorModel),
                  LocationsTab(
                      doctorId: widget.doctorModel.id != null
                          ? widget.doctorModel.id!.toInt()
                          : 0),
                   ReviewsTab(doctor: widget.doctorModel),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
