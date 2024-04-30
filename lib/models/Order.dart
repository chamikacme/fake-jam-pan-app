class Order {
  int? id;
  String name;
  int foodId;
  int count;
  bool isIssued;

  Order({
    this.id,
    required this.name,
    required this.foodId,
    required this.count,
    this.isIssued = false,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      name: json['name'],
      foodId: json['food_id'],
      count: json['count'],
      isIssued: json['isIssued'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'foodId': foodId,
      'count': count,
      'isIssued': isIssued,
    };
  }
}
