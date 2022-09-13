
class FavouritesModel {
  final String? favouritesId;
  final String? userId;
  final double? productPrice;
  final String? productName;
  final String? productImage;

  FavouritesModel({
    this.productName,
    this.favouritesId,
    this.userId,
    this.productPrice,
    this.productImage,

  }) : super();

  factory FavouritesModel.fromMap(Map<String, dynamic> data) {
    return FavouritesModel(
      favouritesId: data["favouritesId"],
      userId: data["userId"],
      productPrice: data["productPrice"],
      productName: data["productName"],
      productImage: data["productImage"],

    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "favouritesId": favouritesId,
        "userId": userId,
        "productPrice": productPrice,
        "productName": productName,
        "productImage": productImage,

      };
}
