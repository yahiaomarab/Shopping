class ProductDetailsData {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String?>? images;

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toInt();
    oldPrice = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    if (json["images"] != null) {
      final v = json["images"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
  }
}

class ProductDetails {
  bool? status;
  String? message;
  ProductDetailsData? data;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null)
        ? ProductDetailsData.fromJson(json["data"])
        : null;
  }
}
