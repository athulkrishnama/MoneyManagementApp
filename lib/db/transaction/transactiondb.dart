import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transation_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDBFunction {
  Future<void> addTransaction(TransactionModel obj);
}

class TransactionDB implements TransactionDBFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }
}
