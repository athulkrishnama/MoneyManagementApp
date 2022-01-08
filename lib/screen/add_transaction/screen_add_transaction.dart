import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routename = "add-transaction";
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedcategorytype;
  CategoryModel? _selectedcategorymodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //purpose
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Purpose"),
              ),
              const SizedBox(
                height: 15,
              ),

              //amount
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Amount"),
              ),
              SizedBox(
                height: 15,
              ),
              //Date

              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now());

                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(
                  _selectedDate == null
                      ? "Select Date"
                      : _selectedDate!.toString(),
                ),
              ),
              //Radio button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: CategoryType.income,
                        onChanged: (value) {},
                      ),
                      Text("Income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: CategoryType.income,
                        onChanged: (value) {},
                      ),
                      Text("Expense")
                    ],
                  )
                ],
              ),
              // DropDown
              DropdownButton(
                hint: Text("select category"),
                items: CategoryDB.instance.incomeCategoryList.value.map((e) {
                  return DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              ElevatedButton(onPressed: () {}, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
