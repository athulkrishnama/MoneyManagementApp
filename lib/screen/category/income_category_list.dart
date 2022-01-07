import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Income $index"),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.red,),
              onPressed: () {},
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemCount: 200,
    );
  }
}
