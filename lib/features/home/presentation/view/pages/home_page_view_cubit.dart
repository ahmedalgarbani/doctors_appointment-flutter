import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_view_body.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/home_cubit.dart';


class HomePageViewCubit extends StatefulWidget {
  const HomePageViewCubit({super.key});

  @override
  State<HomePageViewCubit> createState() => _HomePageViewCubitState();
}

class _HomePageViewCubitState extends State<HomePageViewCubit> {
  getHomeFeatures(){
    
    context.read<HomeCubit>().getHomeFeatures();
    context.read<FavoritesCubit>().getAllFavorites();
  }
  @override
  void initState() {
    getHomeFeatures();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return HomePageViewBody();
  }
}
