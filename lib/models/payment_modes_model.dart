
class PaymentModesModel {
  final String? paymentIcon;
  final String? paymentMode;

  PaymentModesModel({
    this.paymentMode,
    this.paymentIcon,
  }) : super();

  factory PaymentModesModel.fromMap(Map<String, dynamic> data) {
    return PaymentModesModel(
      paymentIcon: data["paymentIcon"],
      paymentMode: data["paymentMode"],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "paymentIcon": paymentIcon,
        "paymentMode": paymentMode,
      };
}
