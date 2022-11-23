/// address : "mazzah street, near Akram Most"
/// city : "Damascus"
/// phoneNumber : 963959886594
/// userName : "Alaa Mejbil"
/// zip : 0

class AddressModel {
  AddressModel({
    String? address,
    String? city,
    dynamic? phoneNumber,
    String? userName,
    dynamic? zip,
  }) {
    _address = address;
    _city = city;
    _phoneNumber = phoneNumber;
    _userName = userName;
    _zip = zip;
  }

  AddressModel.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _phoneNumber = json['phoneNumber'];
    _userName = json['userName'];
    _zip = json['zip'];
  }
  String? _address;
  String? _city;
  dynamic? _phoneNumber;
  String? _userName;
  dynamic? _zip;
  AddressModel copyWith({
    String? address,
    String? city,
    dynamic? phoneNumber,
    String? userName,
    dynamic? zip,
  }) =>
      AddressModel(
        address: address ?? _address,
        city: city ?? _city,
        phoneNumber: phoneNumber ?? _phoneNumber,
        userName: userName ?? _userName,
        zip: zip ?? _zip,
      );
  String? get address => _address;
  String? get city => _city;
  dynamic? get phoneNumber => _phoneNumber;
  String? get userName => _userName;
  dynamic? get zip => _zip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['phoneNumber'] = _phoneNumber;
    map['userName'] = _userName;
    map['zip'] = _zip;
    return map;
  }
}
