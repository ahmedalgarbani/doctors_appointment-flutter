// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../../../core/constant/constant.dart';
// import '../../../../../../core/helpers/build_snacbar.dart';
// import '../../../../../../core/helpers/shared_prefrace.dart';
// import '../../../../../../core/router/router.dart';
// import '../../../../../../core/style/text_style.dart';
// import '../../../../data/models/doctor_model.dart';
// import '../../../view_model/cubit/favorites_cubit/favorites_cubit.dart';
// import '../in_active_item.dart';

// class TopRatingDoctorList extends StatelessWidget {
//   const TopRatingDoctorList({super.key, required this.allDoctors});

//   final List<DoctorModel> allDoctors;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: allDoctors.length,
//       itemBuilder: (context, index) {
//         return TopRatingDoctorItem(
//           doctorModel: allDoctors[index],
//           trailing: UnActiveItem(
//             icon: Icons.favorite_border_outlined,
//             onPressed: () => _toggleFavorite(context, index),
//           ),
//           onPress: () {
//             GoRouter.of(context).push(
//               AppRouter.KDoctorDetail,
//               extra: allDoctors[index],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _toggleFavorite(BuildContext context, int index) async {
//     final cubit = BlocProvider.of<FavoritesCubit>(context);
//     final isFavorite = await cubit.isFavorite(doctorId: allDoctors[index].id!);

//     if (isFavorite) {
//       _addFavorite(context, index);
//     } else {
//       _removeFavorite(context, index);
//     }
//   }

//   Future<void> _addFavorite(BuildContext context, int index) async {
//     final cubit = BlocProvider.of<FavoritesCubit>(context);
//     final patientId = await Pref.getInt(KauthUserId);

//     if (patientId == 0) {
//       buildSnackbar(
//         context,
//         "You need to login first!",
//         color: Colors.redAccent,
//       );
//       return;
//     }

//     final result = await cubit.addNewFavorite(
//       patientId: patientId,
//       doctorId: allDoctors[index].id!,
//     );

//     if (result) {
//       buildSnackbar(context, "Added to favorites!", color: Colors.greenAccent);
//     } else {
//       _removeFavorite(context, index);
//     }

//     cubit.getAllFavorites(patientId);
//   }

//   Future<void> _removeFavorite(BuildContext context, int index) async {
//     final cubit = BlocProvider.of<FavoritesCubit>(context);
//     final patientId = await Pref.getInt(KauthUserId);

//     if (patientId == 0) {
//       buildSnackbar(
//         context,
//         "You need to login first!",
//         color: Colors.redAccent,
//       );
//       return;
//     }

//     await cubit.removeFavorite(
//       doctorId: allDoctors[index].id!,
//       patientId: patientId,
//     );

//     cubit.getAllFavorites(patientId);
//     buildSnackbar(context, "Removed from favorites!", color: Colors.orange);
//   }
// }

// class TopRatingDoctorItem extends StatelessWidget {
//   const TopRatingDoctorItem({
//     super.key,
//     required this.doctorModel,
//     this.trailing,
//     this.onPress,
//   });

//   final DoctorModel doctorModel;
//   final Widget? trailing;
//   final VoidCallback? onPress;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPress,
//       child: Card(
//         elevation: 1,
//         color: Colors.white,
//         child: ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//           trailing: trailing ?? const UnActiveItem(icon: Icons.favorite_border),
//           subtitle: Text(
//             doctorModel.specialtyName ?? 'Specialty unavailable',
//             style: TextStyles.Bold12.copyWith(color: Colors.grey),
//           ),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Hero(
//               tag: 'doctor-${doctorModel.id}',
//               child: Image.asset(
//                 doctorModel.imagePath ?? 'assets/default_image.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           title: Text(
//             doctorModel.name,
//             style: TextStyles.Bold16.copyWith(color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
// }
