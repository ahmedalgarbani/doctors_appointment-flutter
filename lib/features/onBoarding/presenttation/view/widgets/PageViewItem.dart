import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.subtitle,
      required this.title,
      required this.isVisible});
  final String image;
  final String subtitle;
  final Widget title;

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: [
            SvgPicture.asset(
              image,
            ),
            Visibility(
              visible: isVisible,
              child: GestureDetector(
                onTap: () {
                  // Prf.setBool(kIsOnBoardingViewSeen, true);

                  GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'تخط',
                    style: TextStyles.Regular16.copyWith(
                      color: const Color(0xFF949D9E),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 64,
      ),
      title,
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.001,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: Text(
          "$subtitle",
          textAlign: TextAlign.center,
          style: TextStyles.Bold12.copyWith(
            color: const Color(0xFF4E5456),
          ),
        ),
      )
    ]);
  }
}
