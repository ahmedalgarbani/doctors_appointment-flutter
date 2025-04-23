import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../data/models/payment_method_model.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
    required this.paymentData,
    required this.onChange,
  });
  final List<PaymentMethodModel> paymentData;
  final ValueChanged<int> onChange;

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int SelectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.paymentData.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChange(index);
                  SelectedItem = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: SelectedItem == index
                        ? AppColor.primaryColor
                        : Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.paymentData[index].paymentOption.logo,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




// import 'package:doctors_appointment/features/checkout/data/models/payment_method_model.dart';
// import 'package:flutter/material.dart';

// class PaymentMethod extends StatelessWidget {
//   final List<PaymentMethodModel> paymentData;

//   const PaymentMethod({super.key, required this.paymentData});

//   @override
//   Widget build(BuildContext context) {
//     if (paymentData.isEmpty) {
//       return Center(
//         child: Text(
//           "No payment method available",
//           style: TextStyle(color: Colors.grey),
//         ),
//       );
//     }

//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
//         ],
//       ),
//       child: Column(
//         children: paymentData.map((e) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     e.paymentOption.logo, 
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       e.paymentOption.methodName, 
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "Account: ${e.accountName}", 
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
