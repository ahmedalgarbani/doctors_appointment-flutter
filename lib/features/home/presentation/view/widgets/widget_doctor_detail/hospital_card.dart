import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctors_appointment/core/models/hospital_model.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({
    super.key,
    required this.hospital,
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
                _buildHospitalLogo(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
            ...hospital.schedules.map((schedule) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${schedule.dayDisplay}:',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: schedule.shifts.map((shift) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8), // Add space between each shift
                              child: Text(
                                '${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)} (المواعيد المتاحة: ${shift.availableSlots})',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            const Text(
              'السعر:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${hospital.price.toStringAsFixed(2)} ر.ي',
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

  Widget _buildHospitalLogo() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipOval(
        child: hospital.logoUrl != null && hospital.logoUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: hospital.logoUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: Icon(
                    Icons.local_hospital,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.local_hospital,
                  color: Colors.blue,
                  size: 30,
                ),
              )
            : const Icon(
                Icons.local_hospital,
                color: Colors.blue,
                size: 30,
              ),
      ),
    );
  }

  String _formatTime(String time) {
    try {
      final timeParts = time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = timeParts[1];

      if (hour < 12) {
        return '${hour == 0 ? 12 : hour}:$minute ص';
      } else {
        return '${hour == 12 ? 12 : hour - 12}:$minute م';
      }
    } catch (e) {
      return time;
    }
  }
}
