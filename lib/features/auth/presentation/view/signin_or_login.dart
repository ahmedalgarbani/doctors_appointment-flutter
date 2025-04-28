import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/assets_helper/app_vectors.dart';
import '../../../../core/router/router.dart';
import '../../../../core/style/app_color.dart';
import '../../../../core/style/text_style.dart';
import '../../../../core/widgets/base_button.dart';

class SigninOrLogin extends StatelessWidget {
  const SigninOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : const Color(0xFFF9FAFB);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // الصورة والعنوان
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SvgPicture.asset(
                    AppVectors.logo,
                    height: size.height * 0.2,
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "مرحباً بك في Doccure!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "قم بالتسجيل أو تسجيل الدخول للحصول على تجربة حجز مواعيد طبية آمنة، سريعة وفريدة من نوعها.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // الأزرار
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicAppButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.KSignup);
                      },
                      title: "إنشاء حساب",
                      height: 56,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.KSignin);
                      },
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyles.Bold19.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
