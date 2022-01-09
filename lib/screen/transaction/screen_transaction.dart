import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transactiondb.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transation_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refresh();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (
        BuildContext context,
        List<TransactionModel> newList,
        _,
      ) {
        return ListView.separated(
          padding: EdgeInsets.all(2),
          itemBuilder: (context, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    TransactionDB.instance.delTransaction(_value.id!);
                  },
                  icon: Icons.delete,
                )
              ]),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      parseDate(_value.date),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text("Rs ${_value.amount}"),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 2,
          ),
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(" ");
    return "${_splitDate.last}\n${_splitDate.first}";
    //return '${date.day}\n${date.month}';
  }
}
