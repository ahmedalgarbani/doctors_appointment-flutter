import 'package:flutter/material.dart';

class MedicalInfoSection extends StatelessWidget {
  final String? selectedBloodType;
  final String? notes;
  final void Function(String?)? onBloodTypeChanged;
  final void Function(String?)? onNotesSaved;

  const MedicalInfoSection({
    super.key,
    this.selectedBloodType,
    this.notes,
    this.onBloodTypeChanged,
    this.onNotesSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "معلومات طبية",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        
        const SizedBox(height: 16),
        _buildTextField("ملاحظات", notes, onNotesSaved),
      ],
    );
  }

  Widget _buildTextField(
      String label, String? initialValue, void Function(String?)? onSaved) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: 3,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      onSaved: onSaved,
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?)? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items
          .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e, textAlign: TextAlign.right),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      icon: Icon(Icons.arrow_drop_down,
          color: Theme.of(context).textTheme.bodyLarge?.color),
      alignment: Alignment.centerRight,
    );
  }
}
