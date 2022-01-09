import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transation_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDBFunction {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransaction();
}

class TransactionDB implements TransactionDBFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getTransaction();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
}
