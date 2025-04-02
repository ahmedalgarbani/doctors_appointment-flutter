import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
  });

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
          DumyData.paymets.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
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
                    image: AssetImage(
                      DumyData.paymets[index],
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
