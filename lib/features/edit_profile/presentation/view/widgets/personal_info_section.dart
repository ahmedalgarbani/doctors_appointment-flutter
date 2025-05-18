import 'package:flutter/material.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "المعلومات الشخصية",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 16),
        _buildTextField("الاسم الأول"),
        const SizedBox(height: 16),
        _buildTextField("الاسم الأخير"),
        const SizedBox(height: 16),
        _buildTextField("البريد الإلكتروني"),
        const SizedBox(height: 16),
        _buildTextField("رقم الهاتف"),
        const SizedBox(height: 16),
        _buildDateField("تاريخ الميلاد"),
        const SizedBox(height: 16),
        _buildDropdown("الجنس", ["ذكر", "أنثى"]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(String label, {bool readOnly = false}) {
    return TextFormField(
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateField(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        // Implement date picker logic here
      },
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (val) {},
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
