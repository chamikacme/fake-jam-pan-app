import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/models/ItemCount.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();

    var counts = List<ItemCount>.generate(
        5, (index) => ItemCount('Item $index', index + 1));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Fake Jam Pan',
          )),
      body: Column(
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
                CustomButton(onPressed: () => {}, buttonText: 'Reset Counts')
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
            child: ListView.builder(
              itemCount: counts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          counts[index].name,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          counts[index].count.toString(),
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
          )
        ],
      ),
    );
  }
}
