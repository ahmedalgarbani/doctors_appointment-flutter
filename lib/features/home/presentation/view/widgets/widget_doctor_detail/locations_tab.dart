import 'package:flutter/material.dart';
import 'hospital_card.dart';

class LocationsTab extends StatelessWidget {
  const LocationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          HospitalCard(
            name: 'مستشفى 1',
            location: 'المدينة 1',
            price: 50.0,
            schedules: [
              {'day': 'الإثنين', 'time': '9:00 صباحًا - 5:00 مساءً', 'slots': 5},
              {'day': 'الأربعاء', 'time': '9:00 صباحًا - 5:00 مساءً', 'slots': 3},
            ],
          ),
          SizedBox(height: 16),
          HospitalCard(
            name: 'مستشفى 2',
            location: 'المدينة 2',
            price: 60.0,
            schedules: [
              {'day': 'الثلاثاء', 'time': '10:00 صباحًا - 6:00 مساءً', 'slots': 2},
              {'day': 'الخميس', 'time': '10:00 صباحًا - 6:00 مساءً', 'slots': 4},
            ],
          ),
        ],
      ),
    );
  }
}
