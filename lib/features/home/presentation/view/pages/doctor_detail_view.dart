import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import '../widgets/doctor_scedual_bottom_sheet.dart';
import '/core/style/app_color.dart';
import '/core/style/text_style.dart';
import '/core/widgets/custom_button.dart';
import '/features/home/presentation/view/widgets/about_doctor.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_image.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_item_list.dart';
import '/features/home/presentation/view/widgets/home_widgets/favorite_button_cubit.dart';
import '/features/home/presentation/view/widgets/location_doctor.dart';
import '/features/home/presentation/view/widgets/top_rating_doctor/starts_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/cubit/favorites_cubit/favorites_cubit.dart';

class DoctorDetailView extends StatefulWidget {
  const DoctorDetailView({super.key, required this.doctorModel});
  final Doctor doctorModel;

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _averageRating = 4.5;
  int _reviewCount = 24;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // اسم الطبيب
                          Text(
                            widget.doctorModel.fullName ?? '',
                            style: TextStyles.Regular16.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          // التخصص
                          Text(
                            widget.doctorModel.fullName ?? 'التخصص غير معروف',
                            style: TextStyles.Regular16.copyWith(
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          // التقييمات (نجوم)
                          const StarsSection(),
                        ],
                      ),
                    ),
                    // المستشفيات مع السعر
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'المستشفيات:',
                          style: TextStyles.Regular16.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('• مستشفى 1 - 50\$'),
                        Text('• مستشفى 2 - 60\$'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DoctorItemList(doctorModel: widget.doctorModel),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColor.primaryColor,
              tabs: const [
                Tab(text: 'نظرة عامة'),
                Tab(text: 'المواقع'),
                Tab(text: 'التقييمات'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildLocationsTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: CustomButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => DoctorScedualBottomSheet(
                    doctorModel: widget.doctorModel,
                  ),
                );
              },
              title: "حدد موعد",
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('تفاصيل الطبيب'),
      centerTitle: true,
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نبذة عن الطبيب:',
            style: TextStyles.Regular16.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.doctorModel.subTitle ?? 'لا توجد نبذة عن الطبيب.',
            style: TextStyles.Regular16.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // const LocationDoctor(),
        ],
      ),
    );
  }

  Widget _buildLocationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHospitalCard(
            name: 'مستشفى 1',
            location: 'المدينة 1',
            schedules: [
              {
                'day': 'الإثنين',
                'time': '9:00 صباحًا - 5:00 مساءً',
                'slots': 5
              },
              {
                'day': 'الأربعاء',
                'time': '9:00 صباحًا - 5:00 مساءً',
                'slots': 3
              },
            ],
            price: 50.0,
          ),
          const SizedBox(height: 16),
          _buildHospitalCard(
            name: 'مستشفى 2',
            location: 'المدينة 2',
            schedules: [
              {
                'day': 'الثلاثاء',
                'time': '10:00 صباحًا - 6:00 مساءً',
                'slots': 2
              },
              {
                'day': 'الخميس',
                'time': '10:00 صباحًا - 6:00 مساءً',
                'slots': 4
              },
            ],
            price: 60.0,
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard({
    required String name,
    required String location,
    required List<Map<String, dynamic>> schedules,
    required double price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child:
                      Icon(Icons.local_hospital, color: AppColor.primaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'المواعيد المتاحة:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...schedules.map(
              (schedule) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${schedule['day']}:',
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Text(
                        '${schedule['time']} (المواعيد المتاحة: ${schedule['slots']})',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'السعر:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$$price',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildAddReviewSection(),
          const SizedBox(height: 16),
          ..._buildReviews(),
        ],
      ),
    );
  }

  List<Widget> _buildReviews() {
    return List.generate(_reviewCount, (index) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/alkuraimi.png'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم المستخدم',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'التعليق على الخدمة...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddReviewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          const Text('أضف تقييمك'),
          const SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اكتب تعليقك هنا...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomButton(
            onPressed: () {
              setState(() {
                _reviewCount++;
                _reviewController.clear();
              });
            },
            title: 'إرسال التقييم',
          ),
        ],
      ),
    );
  }
}
