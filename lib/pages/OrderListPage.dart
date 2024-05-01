import 'package:fake_jam_pan/components/CustomTextFormField.dart';
import 'package:fake_jam_pan/models/Food.dart';
import 'package:fake_jam_pan/models/Order.dart';
import 'package:fake_jam_pan/services/database_helper.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final TextEditingController queryController = TextEditingController();

  List<Order> filteredOrders = [];
  List<Order> orders = [];
  List<Food> food = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    queryController.addListener(_performSearch);
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    final data = await DatabaseHelper.instance.getAllOrders();
    final items = await DatabaseHelper.instance.getAllFood();
    setState(() {
      orders = data.map((order) => Order.fromJson(order)).toList();
      food = items.map((item) => Food.fromJson(item)).toList();
      _performSearch();
      isLoading = false;
    });
  }

  void _performSearch() {
    setState(() {
      filteredOrders = orders
          .where((order) => order.name
              .toLowerCase()
              .contains(queryController.text.toLowerCase()))
          .toList()
        ..sort((a, b) => a.isIssued ? 1 : -1);
    });
  }

  String getFoodItemName(int foodId, List<Food> foodItems) {
    return foodItems.firstWhere((foodItem) => foodItem.id == foodId).name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Order List',
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
              child: CustomTextFormField(
                controller: queryController,
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : orders.isEmpty
                      ? const Center(child: Text('No data'))
                      : ListView.builder(
                          itemCount: filteredOrders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: VisualDensity.compact,
                              tileColor: filteredOrders[index].isIssued
                                  ? Colors.amber[100]
                                  : null,
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      filteredOrders[index].name,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "${getFoodItemName(filteredOrders[index].foodId, food)} x ${filteredOrders[index].count.toString()}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Delete Order'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this order?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await DatabaseHelper
                                                            .instance
                                                            .deleteOrder(
                                                                filteredOrders[
                                                                        index]
                                                                    .id!);
                                                        setState(() {
                                                          orders.remove(
                                                              filteredOrders[
                                                                  index]);
                                                          filteredOrders
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Delete'),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await DatabaseHelper.instance
                                                .issueOrder(
                                                    filteredOrders[index].id!,
                                                    filteredOrders[index]
                                                            .isIssued
                                                        ? 0
                                                        : 1);
                                            setState(() {
                                              filteredOrders[index].isIssued =
                                                  !filteredOrders[index]
                                                      .isIssued;
                                            });
                                            _performSearch();
                                          },
                                          icon: Icon(
                                            filteredOrders[index].isIssued
                                                ? Icons.undo
                                                : Icons.check,
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
      ),
    );
  }
}
