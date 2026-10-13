class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}