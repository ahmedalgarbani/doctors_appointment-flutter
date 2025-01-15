import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerInputField extends StatefulWidget {
  const DatePickerInputField({
    super.key,
    required this.onDateSelected,
    this.hintText = "Select Date",
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  final Function(DateTime) onDateSelected;
  final String hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<DatePickerInputField> createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {
  DateTime? _selectedDate;

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            
            hintText: _selectedDate == null
                ? widget.hintText
                : DateFormat('yyyy-MM-dd').format(_selectedDate!),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(
                color: AppColor.secondaryColor.withOpacity(.5),
              ),
            ),
            filled: true,
            fillColor: AppColor.secondaryColor.withOpacity(.5),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (_selectedDate == null) {
              return 'Date is required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
