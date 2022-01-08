

import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screen/add_transaction/screen_add_transaction.dart';
import 'package:money_management/screen/category/category_add_popup.dart';
import 'package:money_management/screen/category/screen_category.dart';
import 'package:money_management/screen/home/widgets/bottam_navigation.dart';
import 'package:money_management/screen/transaction/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selected_index_notifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    Screencategory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Manager"),
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selected_index_notifier,
        builder: (BuildContext context, int _indexValue, _) {
          return _pages[_indexValue];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selected_index_notifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction.routename);
          } else {
            // print("Add Category");
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: "Travel",
            //     type: CategoryType.expense);
            // CategoryDB().insertCategory(_sample);
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
