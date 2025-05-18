import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../logic/profile_method.dart';
import '../../../logic/profile_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final picker = ImagePicker();

  bool _isLoading = true;
  UserProfile? _profile;
  File? _image;

  // Profile fields
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String address = '';
  String city = '';
  String state = '';
  DateTime birthDate = DateTime.now();
  String gender = '';
  String bloodGroup = '';
  String notes = '';

  // Mapping between backend values and UI dropdown values
  static const Map<String, String> genderBackendToUi = {
    'male': 'ذكر',
    'female': 'أنثى',
  };

  static const Map<String, String> genderUiToBackend = {
    'ذكر': 'male',
    'أنثى': 'female',
  };

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await ProfileMethod.getProfile();
      setState(() {
        _profile = profile;
        firstName = profile.firstName;
        lastName = profile.lastName;
        email = profile.email;
        phone = profile.mobileNumber;
        address = profile.address;
        city = profile.city ?? '';
        state = profile.state ?? '';
        birthDate =
            DateTime.tryParse(profile.birthDate.toString()) ?? DateTime.now();
        gender = genderBackendToUi[profile.gender.toLowerCase()] ?? '';
        bloodGroup = profile.bloodGroup;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل تحميل البيانات")),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
          child: Container(
            child: child!,
          ),
        );
      },
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_profile == null) return;

      final updatedProfile = _profile!.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNumber: phone,
        address: address,
        city: city,
        state: state,
        birthDate: birthDate.toIso8601String(),
        gender: genderUiToBackend[gender] ?? '',
        bloodGroup: bloodGroup,
        age: DateTime.now().year - birthDate.year,
      );

      try {
        await ProfileMethod.updateProfile(updatedProfile);
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
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل حفظ التعديلات')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل الملف الشخصي"),
        centerTitle: true,
      ),
      body: Container(
        // textDirection: TextDirection.RTL,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile picture
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

                // Personal Information
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
                        "اسم العائلة",
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

                // Birth date field
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
                          DateFormat('yyyy-MM-dd').format(birthDate),
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
                        value: gender.isEmpty ? null : gender,
                        onChanged: (val) {
                          if (val != null) setState(() => gender = val);
                        },
                        icon: Icons.transgender,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        "العمر",
                        keyboardType: TextInputType.number,
                        initialValue:
                            (DateTime.now().year - birthDate.year).toString(),
                        onSaved: (val) {},
                        icon: Icons.cake_outlined,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Address
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
                        "الولاية",
                        initialValue: state,
                        onSaved: (val) => state = val!,
                        icon: Icons.map_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Medical Information
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

               
                const SizedBox(height: 30),

                // Save button
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
      validator: (value) =>
          value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items, {
    required String? value,
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
      validator: (value) =>
          value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
    );
  }
}
