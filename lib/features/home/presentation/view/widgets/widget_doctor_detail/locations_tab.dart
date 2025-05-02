import 'package:doctors_appointment/features/home/presentation/view/widgets/widget_doctor_detail/hospital_card.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/hodpital_cubit/hospital_cubit.dart';
import 'package:doctors_appointment/features/home/data/models/hospital_repository.dart';
import 'package:doctors_appointment/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsTab extends StatelessWidget {
  final int doctorId;

  const LocationsTab({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HospitalRepository(apiService: ApiService()),
      child: BlocProvider(
        create: (context) {
          final repository = RepositoryProvider.of<HospitalRepository>(context);
          return HospitalCubit(repository)..fetchHospitals(doctorId);
        },
        child: _LocationsView(),
      ),
    );
  }
}

class _LocationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final doctorId = context.read<HospitalCubit>().doctorId;
        if (doctorId != null) {
          await context.read<HospitalCubit>().fetchHospitals(doctorId);
        }
      },
      child: BlocBuilder<HospitalCubit, HospitalState>(
        builder: (context, state) {
          if (state is HospitalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HospitalError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final doctorId = context.read<HospitalCubit>().doctorId;
                      if (doctorId != null) {
                        context.read<HospitalCubit>().fetchHospitals(doctorId);
                      }
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else if (state is HospitalLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.hospitals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HospitalCard(hospital: state.hospitals[index]),
                );
              },
            );
          }
          return const Center(child: Text('لا توجد بيانات متاحة'));
        },
      ),
    );
  }
}
