import 'package:flutter/material.dart';
import '../../../../../core/style/app_color.dart';
import '../../../../../core/widgets/puffix_search_icon.dart';
import '../../../../../core/widgets/suffix_filter_icon.dart';
import 'filter_bottom_sheet.dart';

class SearchFieldPageView extends StatelessWidget {
  SearchFieldPageView({super.key, this.onPress, this.defaultValue, this.onChanged, this.filter});
  final VoidCallback? onPress;
  final String? defaultValue;
  final ValueChanged<String>? onChanged;
  final bool? filter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: defaultValue ?? '',
      cursorColor: AppColor.primaryColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _buildOutlinedBorder(),
        errorBorder: _buildOutlinedBorder(),
        focusedBorder: _buildOutlinedBorder(),
        disabledBorder: _buildOutlinedBorder(),
        prefixIcon: SuffixSearchIcon(
          onTap: onPress ?? () {},
        ),
        suffixIcon:filter==false? SuffixFilterIcon(
        ): SuffixFilterIcon(
          onTap: () => _showFilterBottomSheet(context),
        ),
      ),
    );
  }

  OutlineInputBorder _buildOutlinedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(15),
        right: Radius.circular(15),
      ),
      borderSide: BorderSide(color: AppColor.primaryColor),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColor.whiteBackgrond,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
