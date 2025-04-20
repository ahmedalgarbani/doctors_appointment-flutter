
class BookingModel {
  final int id;
  final int doctor;
  final String doctorimg;
  final String doctor_name;
  final int patient;
  final int hospital;
  final String hospitalName;
  final int appointmentDate;
  final int appointmentTime;
  final String bookingDate;
  final String amount;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int? paymentMethod;
  final String? transferNumber;
  final bool paymentVerified;
  final String? paymentVerifiedAt;
  final int? paymentVerifiedBy;
  final String? paymentNotes;

  BookingModel( {
    required this.id,
    required this.doctor,
    required this.doctorimg,
    required this.doctor_name,
    required this.patient,
    required this.hospital,
    required this.hospitalName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.bookingDate,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.paymentMethod,
    this.transferNumber,
    required this.paymentVerified,
    this.paymentVerifiedAt,
    this.paymentVerifiedBy,
    this.paymentNotes,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      doctor: json["doctor"],
      doctorimg: json["doctorimg"],
      doctor_name: json["doctor_name"],
      patient: json["patient"],
      hospital: json["hospital"],
      hospitalName: json["hospital_name"],
      appointmentDate: json["appointment_date"],
      appointmentTime: json["appointment_time"],
      bookingDate: json["booking_date"],
      amount: json["amount"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      paymentMethod: json["payment_method"],
      transferNumber: json["transfer_number"],
      paymentVerified: json["payment_verified"],
      paymentVerifiedAt: json["payment_verified_at"],
      paymentVerifiedBy: json["payment_verified_by"],
      paymentNotes: json["payment_notes"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "doctor": doctor,
      "patient": patient,
      "doctorimg":doctorimg,
      "doctor_name":doctor_name,
      "hospital": hospital,
      "hospital_name": hospitalName,
      "appointment_date": appointmentDate,
      "appointment_time": appointmentTime,
      "booking_date": bookingDate,
      "amount": amount,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "payment_method": paymentMethod,
      "transfer_number": transferNumber,
      "payment_verified": paymentVerified,
      "payment_verified_at": paymentVerifiedAt,
      "payment_verified_by": paymentVerifiedBy,
      "payment_notes": paymentNotes,
    };
  }

  static List<BookingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BookingModel.fromJson(json)).toList();
  }
}
