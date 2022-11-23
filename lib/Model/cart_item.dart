class CartModel {
  final String? id;
  final String productId;
  final String title;
  final dynamic price;
  final double quantity;
  final String imgUrl;

  CartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imgUrl,
  });
}
