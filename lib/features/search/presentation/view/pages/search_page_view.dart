import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/repositories/home_repository.dart';
import '../widgets/search_page_view_body.dart';

class SearchPageView extends StatefulWidget {
  final String? textString;
  const SearchPageView({super.key, this.textString});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(getIt.get<HomeRepository>()),
      child: Scaffold(
        backgroundColor: AppColor.whiteBackgrond,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 8, 16),
          child: SearchPageViewBody(
            textString: widget.textString ?? '',
          ),
        ),
      ),
    );
  }
}
