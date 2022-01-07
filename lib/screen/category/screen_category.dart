import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/screen/category/expense_category_list.dart';
import 'package:money_management/screen/category/income_category_list.dart';

class Screencategory extends StatefulWidget {
  const Screencategory({Key? key}) : super(key: key);

  @override
  State<Screencategory> createState() => _ScreencategoryState();
}

class _ScreencategoryState extends State<Screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabcon;

  @override
  void initState() {
    // TODO: implement initState
    _tabcon = TabController(length: 2, vsync: this);
    CategoryDB().refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabcon,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: "EXPENCE",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: const [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ],
            controller: _tabcon,
          ),
        )
      ],
    );
  }
}
