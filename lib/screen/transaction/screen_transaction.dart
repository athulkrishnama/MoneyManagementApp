import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(2),
      itemBuilder: (context, index) {
        return const Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Text(
                "01\nMar",
                textAlign: TextAlign.center,
              ),
            ),
            title: Text("1000 Rs"),
            subtitle: Text("Travel"),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemCount: 20,
    );
  }
}
