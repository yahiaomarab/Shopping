class CartModel {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String?>? images;
  bool? inFavorites;
  bool? inCart;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toInt();
    oldPrice = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
    if (json["images"] != null) {
      final v = json["images"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}

class InCartsModelDataCartItems {
  int? id;
  int? quantity;
  CartModel? product;

  InCartsModelDataCartItems.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    quantity = json["quantity"]?.toInt();
    product =
        (json["product"] != null) ? CartModel.fromJson(json["product"]) : null;
  }
}

class InCartsModelData {
  List<InCartsModelDataCartItems?>? cartItems;
  int? subTotal;
  int? total;

  InCartsModelData.fromJson(Map<String, dynamic> json) {
    if (json["cart_items"] != null) {
      final v = json["cart_items"];
      final arr0 = <InCartsModelDataCartItems>[];
      v.forEach((v) {
        arr0.add(InCartsModelDataCartItems.fromJson(v));
      });
      cartItems = arr0;
    }
    subTotal = json["sub_total"]?.toInt();
    total = json["total"]?.toInt();
  }
}

class InCartsModel {
  bool? status;
  String? message;
  InCartsModelData? data;

  InCartsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data =
        (json["data"] != null) ? InCartsModelData.fromJson(json["data"]) : null;
  }
}
