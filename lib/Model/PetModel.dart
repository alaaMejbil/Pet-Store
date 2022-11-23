/// age : "1.5 year"
/// creatorBy : "TCzdxLTnvyXKbLzLAGLRQlgGPen1"
/// description : "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."
/// id : "1"
/// imageUrl : "https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80"
/// ownerName : "Alaa Mejbil"
/// ownerPhone : 963959886594
/// petName : "Max"
/// price : 69.0
/// sex : "male"

class PetModel {
  String? _age;
  String? _creatorBy;
  String? _description;
  dynamic? _id;
  String? _imageUrl;
  String? _ownerName;
  int? _ownerPhone;
  String? _petName;
  dynamic? _price;
  String? _sex;
  dynamic? _weight;
  List<dynamic>? album;
  bool? _isFavorite;
  String? _petType;

  PetModel({
    String? age,
    String? creatorBy,
    String? description,
    String? id,
    String? imageUrl,
    String? ownerName,
    int? ownerPhone,
    String? petName,
    dynamic? price,
    String? sex,
    dynamic? weight,
    List<dynamic?>? album,
    bool? isFavorite,
    String? petType,
  }) {
    _age = age;
    _creatorBy = creatorBy;
    _description = description;
    _id = id;
    _imageUrl = imageUrl;
    _ownerName = ownerName;
    _ownerPhone = ownerPhone;
    _petName = petName;
    _price = price;
    _sex = sex;
    _weight = weight;
    this.album = album!;
    _isFavorite = isFavorite;
    _petType = petType;
  }

  PetModel.fromJson(dynamic json, bool? isFavorite, String id) {
    _age = json['age'];
    _creatorBy = json['creatorBy'];
    _description = json['description'];
    _id = id;
    _imageUrl = json['imageUrl'];
    _ownerName = json['ownerName'];
    _ownerPhone = json['ownerPhone'];
    _petName = json['petName'];
    _price = json['price'];
    _sex = json['sex'];
    album = json['album'];
    _weight = json['weight'];
    if (isFavorite == null) {
      _isFavorite = false;
    }
    _isFavorite = isFavorite;
    _petType = json['petType'];
  }

  PetModel copyWith({
    String? age,
    String? creatorBy,
    String? description,
    dynamic? id,
    String? imageUrl,
    String? ownerName,
    int? ownerPhone,
    String? petName,
    dynamic? price,
    String? sex,
  }) =>
      PetModel(
        age: age ?? _age,
        creatorBy: creatorBy ?? _creatorBy,
        description: description ?? _description,
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        ownerName: ownerName ?? _ownerName,
        ownerPhone: ownerPhone ?? _ownerPhone,
        petName: petName ?? _petName,
        price: price ?? _price,
        sex: sex ?? _sex,
      );
  String? get age => _age;
  String? get creatorBy => _creatorBy;
  String? get description => _description;
  String? get id => _id;
  String? get imageUrl => _imageUrl;
  String? get ownerName => _ownerName;
  int? get ownerPhone => _ownerPhone;
  String? get petName => _petName;
  dynamic? get price => _price;
  dynamic? get weight => _weight;
  String? get sex => _sex;
  bool? get isFavorite => _isFavorite;
  String? get petType => _petType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['creatorBy'] = _creatorBy;
    map['description'] = _description;
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['ownerName'] = _ownerName;
    map['ownerPhone'] = _ownerPhone;
    map['petName'] = _petName;
    map['price'] = _price;
    map['sex'] = _sex;
    map['weight'] = _weight;
    return map;
  }

  void isFavoriteSetValue(bool value) {
    _isFavorite = value;
  }
}
