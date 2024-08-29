// ignore_for_file: public_member_api_docs, sort_constructors_first
// Vai representar um produto

class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });
}
