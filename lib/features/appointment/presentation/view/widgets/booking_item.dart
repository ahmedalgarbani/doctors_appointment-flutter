import 'package:flutter/material.dart';

import '../../../../../core/style/text_style.dart';
import '../../../data/models/booking_model.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.bookingModel,
    this.trailing,
    this.onPress,
  });

  final BookingModel bookingModel;
  final Widget? trailing;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ?? () {},
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(255, 225, 236, 251),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  bookingModel.doctorimg,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookingModel.hospitalName ?? 'Unknown Hospital',
                      style: TextStyles.Bold16.copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'د. ${bookingModel.doctor_name}',
                      style: TextStyles.Bold12.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'تاريخ: ${bookingModel.bookingDate}',
                      style: TextStyles.Bold12.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    // Text(
                    //   'Status: ${bookingModel.status}',
                    //   style: TextStyles.Bold12.copyWith(
                    //     color: bookingModel.status == 'pending'
                    //         ? Colors.orange
                    //         : bookingModel.status == 'confirmed'
                    //             ? Colors.green
                    //             : Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
