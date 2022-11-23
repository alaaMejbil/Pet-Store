/// brand  : "xxx"
/// description : "Food packaging requires protection, interfere confrontation and chemical or biological needs. Food packaging is important as it also shows the product that is labeled to show any nutrition values on the food being frenzied. The food enclosed in the packaging may require protection from, temperature, shock s and vibrations. Attractive food packaging can be proved as strong marketing tool."
/// id  : 0
/// imageUrl : "https://www.asianflexipack.com/images/media/fp-pro-2.jpg"
/// isFavorate : true
/// price : 21
/// title : "Potato Chips"
/// weight : "300g"

class ProductModel {
  String? _brand;
  String? _description;
  String? _id;
  String? _imageUrl;
  bool? _isFavorate;
  dynamic? _price;
  String? _title;
  dynamic? _weight;

  ProductModel({
    String? brand,
    String? description,
    String? id,
    String? imageUrl,
    bool? isFavorate,
    dynamic? price,
    String? title,
    dynamic? weight,
  }) {
    _brand = brand;
    _description = description;
    _id = id;
    _imageUrl = imageUrl;
    _isFavorate = isFavorate;
    _price = price;
    _title = title;
    _weight = weight;
  }

  ProductModel.fromJson(dynamic json, String id, bool isFavorite) {
    _brand = json['brand'];
    _description = json['description'];
    _id = id;
    _imageUrl = json['imageUrl'];
    _isFavorate = isFavorite;
    _price = json['price'];
    _title = json['title'];
    _weight = json['weight'];
  }

  ProductModel copyWith({
    String? brand,
    String? description,
    String? id,
    String? imageUrl,
    bool? isFavorate,
    dynamic? price,
    String? title,
    dynamic? weight,
  }) =>
      ProductModel(
        brand: brand ?? _brand,
        description: description ?? _description,
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        isFavorate: isFavorate ?? _isFavorate,
        price: price ?? _price,
        title: title ?? _title,
        weight: weight ?? _weight,
      );
  String? get brand => _brand;
  String? get description => _description;
  String? get id => _id;
  String? get imageUrl => _imageUrl;
  bool? get isFavorate => _isFavorate;
  dynamic? get price => _price;
  String? get title => _title;
  dynamic? get weight => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = _brand;
    map['description'] = _description;
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['isFavorate'] = _isFavorate;
    map['price'] = _price;
    map['title'] = _title;
    map['weight'] = _weight;
    return map;
  }
}
