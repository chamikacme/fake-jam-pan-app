class FoodCount {
  final String name;
  final double price;
  final int count;

  const FoodCount({
    required this.name,
    required this.price,
    required this.count,
  });

  factory FoodCount.fromJson(Map<String, dynamic> json) {
    return FoodCount(
      name: json['name'],
      price: json['price'],
      count: json['count'] ?? 0,
    );
  }
}
