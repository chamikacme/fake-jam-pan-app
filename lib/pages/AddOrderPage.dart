import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/components/CustomTextFormField.dart';
import 'package:fake_jam_pan/components/HorizontalGap.dart';
import 'package:fake_jam_pan/components/VerticleGap.dart';
import 'package:fake_jam_pan/models/FoodItem.dart';
import 'package:fake_jam_pan/models/OrderItem.dart';
import 'package:flutter/material.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({Key? key}) : super(key: key);

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
            'Add Order',
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                CustomButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/order-list')},
                  buttonText: 'Full List',
                )
              ],
            ),
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
                  flex: 2,
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
                        flex: 2,
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
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                VerticleGap(),
                const Text('Name'),
                CustomTextFormField(),
                VerticleGap(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Item',
                            textAlign: TextAlign.left,
                          ),
                          CustomTextFormField(),
                        ],
                      ),
                    ),
                    HorizontalGap(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Count',
                            textAlign: TextAlign.left,
                          ),
                          CustomTextFormField(),
                        ],
                      ),
                    ),
                  ],
                ),
                VerticleGap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => {},
                        buttonText: 'Add',
                      ),
                    ),
                    HorizontalGap(),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => {},
                        buttonText: 'Clear',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
