import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/models/FoodItem.dart';
import 'package:flutter/material.dart';

class FoodItemsPage extends StatelessWidget {
  const FoodItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counts = List<FoodItem>.generate(
        5, (index) => FoodItem('Item $index', index + 50));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Food Items',
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: counts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(counts[index].name),
                  subtitle: Text(
                    'Rs. ${counts[index].price.toStringAsFixed(2)}',
                  ),
                  trailing: Icon(
                    Icons.dining,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () => {},
                    buttonText: 'Add',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
