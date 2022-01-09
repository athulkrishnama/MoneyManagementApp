import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transactiondb.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transation_model.dart';
import 'package:money_management/screen/category/category_add_popup.dart';

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

  String? categoryid;

  final _purposeTesteditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  @override
  void initState() {
    _selectedcategorytype = CategoryType.income;
    super.initState();
  }

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
                controller: _purposeTesteditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Purpose"),
              ),
              const SizedBox(
                height: 15,
              ),

              //amount
              TextFormField(
                controller: _amountEditingController,
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
                        value: CategoryType.income,
                        groupValue: _selectedcategorytype,
                        onChanged: (value) {
                          setState(() {
                            _selectedcategorytype = CategoryType.income;
                            categoryid = null;
                          });
                        },
                      ),
                      Text("Income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedcategorytype,
                        onChanged: (value) {
                          setState(() {
                            _selectedcategorytype = CategoryType.expense;
                            categoryid = null;
                          });
                        },
                      ),
                      Text("Expense")
                    ],
                  )
                ],
              ),
              // DropDown
              DropdownButton<String>(
                value: categoryid,
                hint: Text("select category"),
                items: (_selectedcategorytype == CategoryType.income
                        ? CategoryDB.instance.incomeCategoryList
                        : CategoryDB.instance.expenseCategoryList)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    onTap: () {
                      _selectedcategorymodel = e;
                    },
                    child: Text(e.name),
                    value: e.id,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    categoryid = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    addTransation();
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransation() async {
    final _purpose = _purposeTesteditingController.text;
    final _amountString = _amountEditingController.text;
    if (_purpose.isEmpty || _amountString.isEmpty) {
      return;
    }
    if (categoryid == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final amount = double.tryParse(_amountString);
    if (amount == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }
    final _model = TransactionModel(
        purpose: _purpose,
        amount: amount,
        date: _selectedDate!,
        type: _selectedcategorytype!,
        category: _selectedcategorymodel!);

    TransactionDB.instance.addTransaction(_model);
  }
}
