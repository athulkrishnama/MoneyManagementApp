import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryList,
      builder: (BuildContext context, List<CategoryModel> value, child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final category = value[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(category.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 2,
          ),
          itemCount: value.length,
        );
      },
    );
  }
}
