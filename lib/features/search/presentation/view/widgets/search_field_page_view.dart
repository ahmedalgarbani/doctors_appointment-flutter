import 'package:flutter/material.dart';
import '../../../../../core/style/app_color.dart';
import '../../../../../core/widgets/puffix_search_icon.dart';
import '../../../../../core/widgets/suffix_filter_icon.dart';
import 'filter_bottom_sheet.dart';

class SearchFieldPageView extends StatelessWidget {
  const SearchFieldPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.primaryColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _buildOutlinedBorder(),
        errorBorder: _buildOutlinedBorder(),
        focusedBorder: _buildOutlinedBorder(),
        disabledBorder: _buildOutlinedBorder(),
        prefixIcon: const SuffixSearchIcon(),
        suffixIcon: SuffixFilterIcon(
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
      borderSide: BorderSide.none,
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
