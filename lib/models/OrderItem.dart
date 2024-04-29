import 'package:fake_jam_pan/models/FoodItem.dart';

class OrderItem {
  String name;
  FoodItem foodItem;
  int count;
  bool isPaid;
  bool isIssued;

  OrderItem(this.name, this.foodItem, this.count, this.isPaid, this.isIssued);
}
