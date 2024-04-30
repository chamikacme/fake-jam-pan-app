import 'package:fake_jam_pan/components/CustomButton.dart';
import 'package:fake_jam_pan/components/CustomTextFormField.dart';
import 'package:fake_jam_pan/components/VerticleGap.dart';
import 'package:fake_jam_pan/services/database_helper.dart';
import 'package:flutter/material.dart';

class AddFoodItemsPage extends StatelessWidget {
  AddFoodItemsPage({Key? key, this.id, this.name, this.price})
      : super(key: key);

  final int? id;
  final String? name;
  final double? price;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    final Map<String, dynamic> args =
        routeSettings?.arguments as Map<String, dynamic>? ?? {};
    final int? id = args['id'];
    final String? name = args['name'];
    final double? price = args['price'];

    bool isDataLoaded = false;

    if (!isDataLoaded) {
      nameController.text = name ?? '';
      priceController.text = price?.toString() ?? '';
      isDataLoaded = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(id == null ? 'Add Food Item' : 'Edit Food Item'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Name',
                    textAlign: TextAlign.left,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                  ),
                  VerticleGap(),
                  const Text(
                    'Price',
                    textAlign: TextAlign.left,
                  ),
                  CustomTextFormField(
                    controller: priceController,
                    isNumber: true,
                  ),
                ],
              ),
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
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      double.tryParse(priceController.text) != null) {
                    if (id != null) {
                      await DatabaseHelper.instance.updateFood({
                        DatabaseHelper.columnId: id,
                        DatabaseHelper.columnName: nameController.text,
                        DatabaseHelper.columnPrice:
                            double.parse(priceController.text),
                      });
                    } else {
                      await DatabaseHelper.instance.insertFood({
                        DatabaseHelper.columnName: nameController.text,
                        DatabaseHelper.columnPrice:
                            double.parse(priceController.text),
                      });
                    }
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/food-items');
                  }
                },
                buttonText: 'Save',
              ),
            ),
            if (id != null) const SizedBox(width: 8),
            if (id != null)
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteFood(id);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/food-items');
                  },
                  buttonText: 'Delete',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
