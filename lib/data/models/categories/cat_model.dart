class CategoryProductsDataData {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String?>? images;
  bool? inFavorites;
  bool? inCart;

  CategoryProductsDataData({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });
  CategoryProductsDataData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toDouble();
    oldPrice = json["old_price"]?.toDouble();
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

class CategoryProductsData {
  int? currentPage;
  List<CategoryProductsDataData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  CategoryProductsData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
  CategoryProductsData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <CategoryProductsDataData>[];
      v.forEach((v) {
        arr0.add(CategoryProductsDataData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json["first_page_url"]?.toString();
    from = json["from"]?.toInt();
    lastPage = json["last_page"]?.toInt();
    lastPageUrl = json["last_page_url"]?.toString();
    nextPageUrl = json["next_page_url"]?.toString();
    path = json["path"]?.toString();
    perPage = json["per_page"]?.toInt();
    prevPageUrl = json["prev_page_url"]?.toString();
    to = json["to"]?.toInt();
    total = json["total"]?.toInt();
  }
}

class CategoryProducts {
  bool? status;
  String? message;
  CategoryProductsData? data;

  CategoryProducts({
    this.status,
    this.message,
    this.data,
  });
  CategoryProducts.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null)
        ? CategoryProductsData.fromJson(json["data"])
        : null;
  }
}
