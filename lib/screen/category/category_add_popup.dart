import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text("Add category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category Name"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                RadioButton(title: "Income", type: CategoryType.income),
                RadioButton(title: "Expense", type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  final _name = _nameController.text;
                  final _type = selectedCategory.value;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type,
                  );
                  CategoryDB.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: Text("Add")),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (BuildContext context, CategoryType value, _) {
        return Row(
          children: [
            Radio<CategoryType>(
              value: type,
              groupValue: value,
              onChanged: (updated_value) {
                if (updated_value == null) {
                  return;
                }
                selectedCategory.value = updated_value;
                selectedCategory.notifyListeners();
              },
            ),
            Text(title),
          ],
        );
      },
    );
  }
}
