class EndPoints {
  static const String imageBaseUrl = "http://192.168.8.178:8000"; // ← مهم للصور
  static const String baseUrl = "http://192.168.1.151:8000/api/";
  static const String refreshToken = "token/refresh/";
  static const String login = "login/";
  static const String logout = "logout/";
  static const String register = "register/";
  static const String specialties = "specialties/";
  static const String favorites = "favourites/";
  static const String removeFavorites = "favourites/remove/";
  static const String historyBooking = "bookings/history_bookings/";
  static const String upcommingBooking = "bookings/upcoming_bookings/";
  static const String createBooking = "bookings/create_booking/";
  static const String getPaymentMethod =
      "hospital-payment-methods/active_payment_methods/";
  static const String profile = "profile/";
  static const String notifications = "notifications/";
  static const String doctor_search = "doctors/";
  static const String doctor_filter = "doctors/filter/";
}
