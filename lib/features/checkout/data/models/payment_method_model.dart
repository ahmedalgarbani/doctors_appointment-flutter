class PaymentMethodModel {
  final int id;
  final int hospitalId;
  final String accountName;
  final String accountNumber;
  final String iban;
  final String description;
  final PaymentOption paymentOption;

  PaymentMethodModel({
    required this.id,
    required this.hospitalId,
    required this.accountName,
    required this.accountNumber,
    required this.iban,
    required this.description,
    required this.paymentOption,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      hospitalId: json['hospital'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      iban: json['iban'],
      description: json['description'],
      paymentOption: PaymentOption.fromJson(json['payment_option']),
    );
  }
}

class PaymentOption {
  final int id;
  final String methodName;
  final String logo;

  PaymentOption({
    required this.id,
    required this.methodName,
    required this.logo,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      id: json['id'],
      methodName: json['method_name'],
      logo: json['logo'],
    );
  }
}
