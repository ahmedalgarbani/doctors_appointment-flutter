import 'package:doctors_appointment/features/edit_profile/presentation/view_model/models/user_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class EditProfileCubit extends Cubit<UserProfileModel> {
  EditProfileCubit()
      : super(UserProfileModel(
          firstName: "أحمد",
          lastName: "محمد",
          email: "ahmed@example.com",
          phone: "+967 777 123 456",
          address: "شارع التحرير",
          city: "صنعاء",
          state: "التحرير",
          birthDate: DateTime(1990, 1, 1),
          gender: "ذكر",
          age: "33",
          bloodGroup: "A+",
          notes: "",
        ));

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'firstName':
        emit(state.copyWith(firstName: value));
        break;
      case 'lastName':
        emit(state.copyWith(lastName: value));
        break;
      case 'email':
        emit(state.copyWith(email: value));
        break;
      case 'phone':
        emit(state.copyWith(phone: value));
        break;
      case 'address':
        emit(state.copyWith(address: value));
        break;
      case 'city':
        emit(state.copyWith(city: value));
        break;
      case 'state':
        emit(state.copyWith(state: value));
        break;
      case 'gender':
        emit(state.copyWith(gender: value));
        break;
      case 'bloodGroup':
        emit(state.copyWith(bloodGroup: value));
        break;
      case 'notes':
        emit(state.copyWith(notes: value));
        break;
    }
  }

  void updateBirthDate(DateTime date) {
    final newAge = (DateTime.now().year - date.year).toString();
    emit(state.copyWith(birthDate: date, age: newAge));
  }

  void updateImage(File image) {
    emit(state.copyWith(imagePath: image.path));
  }
}
