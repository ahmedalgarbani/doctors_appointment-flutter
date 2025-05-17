import 'package:dio/dio.dart';

class BookingPaymentTemp {
  final int doctor;
  final int hospital;
  final String appointmentDate;
  final String appointmentTime;
  final String amount;
  final int paymentMethod;
  final String? transferNumber;
  final String? paymentNotes;
  final String? paymentReceiptPath;
  final String? booking_date;

  BookingPaymentTemp({
    required this.doctor,
    required this.hospital,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.amount,
    required this.paymentMethod,
    required this.booking_date,
    this.transferNumber,
    this.paymentNotes,
    this.paymentReceiptPath,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> fields = {
      "doctor": doctor.toString(),
      "hospital": hospital.toString(),
      "appointment_date": appointmentDate,
      "appointment_time": appointmentTime,
      "amount": amount.toString(),
      "payment_method": paymentMethod,
      "booking_date": booking_date,
    };

    if (transferNumber != null) {
      fields["transfer_number"] = transferNumber;
    }

    if (paymentNotes != null) {
      fields["payment_notes"] = paymentNotes;
    }

    if (paymentReceiptPath != null) {
      fields["payment_receipt"] = await MultipartFile.fromFile(
        paymentReceiptPath!,
        filename: "receipt.jpg",
      );
    }

    return FormData.fromMap(fields);
  }
}
