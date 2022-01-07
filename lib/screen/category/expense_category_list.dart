import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Expense $index"),
            trailing: IconButton(onPressed: () {
              
            }, icon: Icon(Icons.delete,color: Colors.red,)),),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemCount: 200,
    );
  }
}
