class Food {
  final int? id;
  final String name;
  final double price;

  const Food({
    this.id,
    required this.name,
    required this.price,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
