import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/models/Count.dart';
import 'package:fake_jam_pan/services/database_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodCount> foodCounts = [];
  double total = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    foodCounts = await getSummary();
    _calculateTotal(foodCounts);
    setState(() {
      isLoading = false;
    });
  }

  Future<List<FoodCount>> getSummary() async {
    final data = await DatabaseHelper.instance.getFoodCounts();
    return data.map((item) => FoodCount.fromJson(item)).toList();
  }

  _calculateTotal(List<FoodCount> list) {
    total = 0;
    for (var item in list) {
      total += item.price * item.count;
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Fake Jam Pan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Reset Counts'),
                      content:
                          const Text('Are you sure you want to reset counts?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await DatabaseHelper.instance.resetCounts();
                            await _fetchData();
                            Navigator.pop(context);
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text(
              'Reset Counts',
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                CustomButton(
                    onPressed: () async {
                      await _fetchData();
                    },
                    buttonText: 'Refresh')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Total: Rs. ${total.toInt()}/-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                    'Item',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Price',
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
                    'Count',
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : foodCounts.isEmpty
                    ? const Center(child: Text('No data'))
                    : ListView.builder(
                        itemCount: foodCounts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    foodCounts[index].name,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    foodCounts[index].price.toInt().toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    foodCounts[index].count.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/food-items'),
                },
                buttonText: 'Food Items',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/add-order'),
                },
                buttonText: 'Orders',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
