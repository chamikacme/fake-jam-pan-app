import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/components/CustomTextFormField.dart';
import 'package:fake_jam_pan/components/HorizontalGap.dart';
import 'package:fake_jam_pan/components/VerticleGap.dart';
import 'package:fake_jam_pan/models/Food.dart';
import 'package:fake_jam_pan/models/Order.dart';
import 'package:fake_jam_pan/services/database_helper.dart';
import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  AddOrderPage({Key? key}) : super(key: key);

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  Future<List<Food>> getFoodItemsFromDB() async {
    final data = await DatabaseHelper.instance.getAllFood();
    return data.map((item) => Food.fromJson(item)).toList();
  }

  Future<List<Order>> getRecentOrdersFromDB() async {
    final data = await DatabaseHelper.instance.getRecentOrders();
    return data.map((item) => Order.fromJson(item)).toList();
  }

  String getFoodItemName(int foodId, List<Food> foodItems) {
    return foodItems.firstWhere((foodItem) => foodItem.id == foodId).name;
  }

  @override
  void initState() {
    countController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> recentOrders = [];
    List<Food> foodItems = [];

    Food? selectedFoodItem;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Add Order',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 223, 195),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Name'),
                  CustomTextFormField(
                    controller: nameController,
                  ),
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
                            FutureBuilder<List<Food>>(
                              future: getFoodItemsFromDB(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.data!.isEmpty) {
                                  return const Text('No food items found');
                                } else {
                                  selectedFoodItem =
                                      selectedFoodItem ?? snapshot.data!.first;
                                  foodItems = snapshot.data!;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.orange),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: DropdownMenu(
                                      dropdownMenuEntries: snapshot.data!
                                          .map((foodItem) =>
                                              DropdownMenuEntry<Food>(
                                                  value: foodItem,
                                                  label: foodItem.name))
                                          .toList(),
                                      onSelected: (food) =>
                                          {selectedFoodItem = food},
                                      initialSelection: selectedFoodItem,
                                      inputDecorationTheme:
                                          const InputDecorationTheme(
                                        border: InputBorder.none,
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
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
                            CustomTextFormField(
                              controller: countController,
                              isNumber: true,
                            ),
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
                          onPressed: () async {
                            if (nameController.text.isNotEmpty &&
                                countController.text.isNotEmpty &&
                                int.tryParse(countController.text) != null &&
                                selectedFoodItem != null) {
                              await DatabaseHelper.instance.insertOrder({
                                DatabaseHelper.ordersColumnName:
                                    nameController.text,
                                DatabaseHelper.ordersColumnFoodId:
                                    selectedFoodItem!.id,
                                DatabaseHelper.ordersColumnCount:
                                    int.parse(countController.text),
                              });

                              nameController.clear();
                              countController.text = '1';
                              setState(() {});
                            }
                          },
                          buttonText: 'Add',
                        ),
                      ),
                      HorizontalGap(),
                      Expanded(
                        child: CustomButton(
                          onPressed: () => {
                            nameController.clear(),
                            countController.text = '1',
                          },
                          buttonText: 'Clear',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {});
                        },
                        buttonText: 'Refresh',
                      )
                    ],
                  ),
                  const Divider(),
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
              child: FutureBuilder<List<Order>>(
                future: getRecentOrdersFromDB(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data'));
                  } else {
                    recentOrders = snapshot.data!;
                    return ListView.builder(
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
                                  "${getFoodItemName(recentOrders[index].foodId, foodItems)} x ${recentOrders[index].count.toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/order-list'),
                },
                buttonText: 'Order List',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
