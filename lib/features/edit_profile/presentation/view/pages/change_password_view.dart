import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/style/app_color.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // متغيرات كلمات المرور
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  // متغيرات لإظهار/إخفاء كلمة المرور
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: إرسال البيانات للخادم أو Cubit
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم تغيير كلمة المرور بنجاح'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.primaryColor,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تغيير كلمة المرور"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _changePassword,
              tooltip: 'حفظ التغييرات',
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // صورة القفل
                Center(
                  child: Icon(
                    Icons.lock_outlined,
                    size: 100,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                
                // كلمة المرور القديمة
                _buildSectionHeader("تغيير كلمة المرور"),
                const SizedBox(height: 16),
                
                _buildPasswordField(
                  "كلمة المرور الحالية",
                  onSaved: (val) => oldPassword = val!,
                  obscureText: !_showOldPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showOldPassword ? Icons.visibility : Icons.visibility_off,
                      color: theme.hintColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _showOldPassword = !_showOldPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                
                // كلمة المرور الجديدة
                _buildPasswordField(
                  "كلمة المرور الجديدة",
                  onSaved: (val) => newPassword = val!,
                  obscureText: !_showNewPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showNewPassword ? Icons.visibility : Icons.visibility_off,
                      color: theme.hintColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور الجديدة';
                    }
                    if (value.length < 8) {
                      return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // تأكيد كلمة المرور الجديدة
                _buildPasswordField(
                  "تأكيد كلمة المرور الجديدة",
                  onSaved: (val) => confirmPassword = val!,
                  obscureText: !_showConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      color: theme.hintColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value != newPassword) {
                      return 'كلمة المرور غير متطابقة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                
                // زر الحفظ
                ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColor.primaryColor,
                  ),
                  child: const Text(
                    "حفظ التغييرات",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  Widget _buildPasswordField(
    String label, {
    required void Function(String?) onSaved,
    required bool obscureText,
    required Widget suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      textAlign: TextAlign.right,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        fillColor: Theme.of(context).cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // منع المسافات
      ],
    );
  }
}