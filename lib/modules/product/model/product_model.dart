class ProductModel {
  bool? status;
  List<Product>? product;

  ProductModel({this.status, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? productId;
  String? name;
  List<String?>? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;
  String? url;
  String? status;
  Mileage? mileage;
  String? html;
  int? is_recommended;

  Product(
      {this.productId,
      this.name,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.url,
      this.status,
      this.mileage,
      this.html,
      this.is_recommended});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    image = (json['image'] as List<dynamic>).map((e) => e as String).toList();
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    url = json['url'];
    status = json['status'];
    mileage = json['mileage'] != null ? Mileage.fromJson(json['mileage']) : null;
    html = json['html'];
    is_recommended = json['is_recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    data['url'] = url;
    data['status'] = status;
    if (mileage != null) {
      data['mileage'] = mileage!.toJson();
    }
    data['html'] = html;
    data['is_recommended'] = is_recommended;
    return data;
  }
}

class Mileage {
  dynamic value;
  String? status;

  Mileage({this.value, this.status});

  Mileage.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}
