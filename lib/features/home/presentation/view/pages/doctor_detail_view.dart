import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import '../widgets/doctor_scedual_bottom_sheet.dart';
import '/core/style/app_color.dart';
import '/core/style/text_style.dart';
import '/core/widgets/custom_button.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_image.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_item_list.dart';

import 'package:flutter/material.dart';

class DoctorDetailView extends StatefulWidget {
  const DoctorDetailView({super.key, required this.doctorModel});
  final Doctor doctorModel;

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _reviewController = TextEditingController();

  List<Map<String, dynamic>> _reviews = [];

  double _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _reviews = [
      {
        'name': 'أحمد',
        'comment': 'طبيب رائع وخدمة ممتازة.',
        'rating': 5.0,
      },
      {
        'name': 'سارة',
        'comment': 'تعامل جيد ولكن الانتظار طويل.',
        'rating': 3.5,
      },
    ];
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
          _buildDoctorHeader(),
          _buildBookButton(),
          const SizedBox(height: 5),
          _buildTabBar(),
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

  Widget _buildDoctorHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                DoctorImage(
                  doctorImage: widget.doctorModel.photo ?? '',
                  doctorId: widget.doctorModel.id!.toInt(),
                  size: 5,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorModel.fullName ?? '',
                        style: TextStyles.Regular16.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.doctorModel.subTitle ?? 'التخصص غير معروف',
                        style:
                            TextStyles.Regular16.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star_rounded,
                            color: (widget.doctorModel.rating != null &&
                                    index < widget.doctorModel.rating!.toInt())
                                ? Colors.amber
                                : Colors.grey[300],
                            size: 18,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            DoctorItemList(doctorModel: widget.doctorModel),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TabBar(
        controller: _tabController,
        onTap: (index) => setState(() {}),
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.primaryColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.primaryColor,
        ),
        tabs: [
          Tab(child: _buildTabItem(Icons.info_outline, 'نظرة عامة', 0)),
          Tab(child: _buildTabItem(Icons.local_hospital, 'مستشفى', 1)),
          Tab(child: _buildTabItem(Icons.star_outline, 'التقييمات', 2)),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String text, int tabIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          if (_tabController.index == tabIndex)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
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
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(location, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('المواعيد المتاحة:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...schedules.map((schedule) => Padding(
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
                            style: TextStyle(color: Colors.grey[700])),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            const Text('السعر:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$$price',
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
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
    return List.generate(_reviews.length, (index) {
      final review = _reviews[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/alkuraimi.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        Icons.star,
                        color: i < review['rating'].round()
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 16,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(review['comment'],
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('أضف تقييمك:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _currentRating = index + 1.0;
                });
              },
            );
          }),
        ),
        TextField(
          controller: _reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب تعليقك هنا...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        CustomButton(
          onPressed: () {
            if (_currentRating > 0 && _reviewController.text.isNotEmpty) {
              setState(() {
                _reviews.add({
                  'name': 'مستخدم جديد',
                  'comment': _reviewController.text,
                  'rating': _currentRating,
                });
                _reviewController.clear();
                _currentRating = 0;
              });
            }
          },
          title: 'إرسال',
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Padding(
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
        title: "احجز موعد",
      ),
    );
  }
}
