import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String name;
  final String location;
  final double price;
  final List<Map<String, dynamic>> schedules;

  const HospitalCard({
    super.key,
    required this.name,
    required this.location,
    required this.price,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  child: Icon(Icons.local_hospital, color: AppColor.primaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(location, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('المواعيد المتاحة:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...schedules.map((schedule) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${schedule['day']}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Text(
                      '${schedule['time']} (المواعيد المتاحة: ${schedule['slots']})',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 8),
            const Text('السعر:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$$price',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
