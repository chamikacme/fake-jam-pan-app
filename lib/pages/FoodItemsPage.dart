import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/services/database_helper.dart';
import 'package:flutter/material.dart';

class FoodItemsPage extends StatelessWidget {
  const FoodItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Food Items',
          )),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DatabaseHelper.instance.getAllFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  List<Map<String, dynamic>> foods = snapshot.data!;
                  if (foods.isEmpty) {
                    return const Center(child: Text('No data'));
                  }
                  return ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => {
                          Navigator.pushNamed(
                            context,
                            '/add-food-item',
                            arguments: {
                              'id': foods[index]['_id'],
                              'name': foods[index]['name'],
                              'price': foods[index]['price'],
                            },
                          ),
                        },
                        title: Text(foods[index]['name']),
                        subtitle: Text(
                          'Rs. ${foods[index]['price'].toStringAsFixed(2)}',
                        ),
                        trailing: const Icon(
                          Icons.dining,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/add-food-item'),
                },
                buttonText: 'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
