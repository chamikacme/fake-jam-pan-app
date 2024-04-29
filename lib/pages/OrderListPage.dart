import 'package:fake_jam_pan/components/CustomTextFormField.dart';
import 'package:fake_jam_pan/models/FoodItem.dart';
import 'package:fake_jam_pan/models/OrderItem.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recentOrders = List<OrderItem>.generate(
        5,
        (index) => OrderItem(index.toString() + " name",
            FoodItem("Rolls", 100.00), 1, true, false));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Order List',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recentOrders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          recentOrders[index].name,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${recentOrders[index].foodItem.name} x ${recentOrders[index].count.toString()}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
