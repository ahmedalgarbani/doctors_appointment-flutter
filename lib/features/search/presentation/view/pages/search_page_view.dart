import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/search_page_view_body.dart';

class SearchPageView extends StatefulWidget {
  final String? textString;
  const SearchPageView({super.key, this.textString});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackgrond,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 8, 16),
        child: SearchPageViewBody(
          textString: widget.textString ?? '',
        ),
      ),
    );
  }
}
