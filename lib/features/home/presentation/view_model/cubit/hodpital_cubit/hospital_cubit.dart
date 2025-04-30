import 'package:doctors_appointment/core/models/hospital_model.dart';
import 'package:doctors_appointment/features/home/data/models/hospital_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalRepository repository;
  int? doctorId;

  HospitalCubit(this.repository) : super(HospitalInitial());

 Future<void> fetchHospitals(int doctorId) async {
  this.doctorId = doctorId;
  if (isClosed) return; // تأكد من أن الـ Cubit غير مغلق قبل إصدار الحالة

  emit(HospitalLoading());
  
  final result = await repository.getDoctorHospitals(doctorId);
  
  if (isClosed) return; // تأكد مرة أخرى من أن الـ Cubit غير مغلق قبل إصدار الحالة النهائية

  result.fold(
    (failure) => emit(HospitalError(failure.errorMessage)),
    (hospitals) => emit(HospitalLoaded(hospitals)),
  );
}

}