import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  File? _image;
  final picker = ImagePicker();

  // نموذج البيانات الأولي
  String firstName = "أحمد";
  String lastName = "محمد";
  String email = "ahmed@example.com";
  String phone = "+967 777 123 456";
  String address = "شارع التحرير";
  String city = "صنعاء";
  String state = "التحرير";
  DateTime birthDate = DateTime(1990, 1, 1); 
  String gender = "ذكر";
  String age = "33";
  String bloodGroup = "A+";
  String notes = "";

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // دالة لفتح تقويم اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl, // لجعل التقويم يبدأ من اليمين
            child: child!,
          ),
        );
      },
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        // تحديث العمر تلقائياً عند تغيير تاريخ الميلاد
        age = (DateTime.now().year - birthDate.year).toString();
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Send data to backend or Cubit
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم حفظ التعديلات بنجاح'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل الملف الشخصي"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
            tooltip: 'حفظ التعديلات',
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // صورة الملف الشخصي
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.primaryColor.withOpacity(0.5),
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: theme.cardColor,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : const AssetImage("assets/images/profile.png")
                                  as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        left: -5,
                        child: Material(
                          shape: const CircleBorder(),
                          color: theme.primaryColor,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: _pickImage,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // معلومات الشخصية
                _buildSectionHeader("المعلومات الشخصية"),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "الاسم الأول",
                        initialValue: firstName,
                        onSaved: (val) => firstName = val!,
                        icon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        "الاسم الأخير",
                        initialValue: lastName,
                        onSaved: (val) => lastName = val!,
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "البريد الإلكتروني",
                  keyboardType: TextInputType.emailAddress,
                  initialValue: email,
                  onSaved: (val) => email = val!,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "رقم الهاتف",
                  keyboardType: TextInputType.phone,
                  initialValue: phone,
                  onSaved: (val) => phone = val!,
                  icon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                // حقل تاريخ الميلاد الجديد مع زر التقويم
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "تاريخ الميلاد",
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        "الجنس",
                        ["ذكر", "أنثى"],
                        value: gender,
                        onChanged: (val) => setState(() => gender = val!),
                        icon: Icons.transgender,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        "العمر",
                        keyboardType: TextInputType.number,
                        initialValue: age,
                        onSaved: (val) => age = val!,
                        icon: Icons.cake_outlined,
                        readOnly: true, // جعل حقل العمر للقراءة فقط
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // العنوان
                _buildSectionHeader("العنوان"),
                const SizedBox(height: 16),
                _buildTextField(
                  "العنوان",
                  initialValue: address,
                  onSaved: (val) => address = val!,
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "المدينة",
                        initialValue: city,
                        onSaved: (val) => city = val!,
                        icon: Icons.location_city_outlined,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        "المديرية",
                        initialValue: state,
                        onSaved: (val) => state = val!,
                        icon: Icons.map_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // معلومات طبية
                _buildSectionHeader("معلومات طبية"),
                const SizedBox(height: 16),
                _buildDropdown(
                  "فصيلة الدم",
                  ["A-", "A+", "B-", "B+", "AB-", "AB+", "O-", "O+"],
                  value: bloodGroup,
                  onChanged: (val) => setState(() => bloodGroup = val!),
                  icon: Icons.bloodtype_outlined,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "ملاحظات",
                  initialValue: notes,
                  onSaved: (val) => notes = val!,
                  maxLines: 3,
                  icon: Icons.notes_outlined,
                ),
                const SizedBox(height: 30),
                // زر الحفظ
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "حفظ التعديلات",
                    style: TextStyle(fontSize: 16),
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

  Widget _buildTextField(
    String label, {
    TextInputType keyboardType = TextInputType.text,
    required String initialValue,
    required void Function(String?) onSaved,
    int maxLines = 1,
    IconData? icon,
    bool readOnly = false,
  }) {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: keyboardType,
      maxLines: maxLines,
      initialValue: initialValue,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
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
        alignLabelWithHint: true,
      ),
      onSaved: onSaved,
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items, {
    required String value,
    required void Function(String?) onChanged,
    IconData? icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, textAlign: TextAlign.right),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        alignLabelWithHint: true,
      ),
      dropdownColor: Theme.of(context).cardColor,
      icon: Icon(Icons.arrow_drop_down,
          color: Theme.of(context).textTheme.bodyLarge?.color),
      alignment: Alignment.centerRight,
    );
  }
}
