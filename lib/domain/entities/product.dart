class Product {
  final String barcode;
  final String name;
  final String? category;
  final double price;
  final int stock;

  Product({
    required this.barcode,
    required this.name,
    this.category,
    required this.price,
    required this.stock,
  });

  //copyWith
  Product copyWith({
    String? barcode,
    String? name,
    String? category,
    double? price,
    int? stock,
  }) {
    return Product(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}