import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/providers/shared_prefs_provider.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

part 'transaction_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider).asData!.value;
  return TransactionRepositoryImpl(prefs);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final SharedPreferences _prefs;
  final _key = 'transactions';
  final _transactionController = BehaviorSubject<List<TransactionModel>>();

  TransactionRepositoryImpl(this._prefs) {
    _init();
  }

  void _init() {
    final jsonString = _prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final transactions = jsonList
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _transactionController.add(transactions);
    } else {
      _transactionController.add([]);
    }
  }

  Future<void> _saveTransactions(List<TransactionModel> transactions) async {
    final jsonList = transactions.map((e) => e.toJson()).toList();
    await _prefs.setString(_key, jsonEncode(jsonList));
    _transactionController.add(transactions);
  }

  @override
  Future<Either<Failure, void>> addTransaction(
      TransactionModel transaction) async {
    try {
      final currentList = _transactionController.valueOrNull ?? [];
      final newList = [...currentList, transaction];
      await _saveTransactions(newList);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      final currentList = _transactionController.valueOrNull ?? [];
      final newList = currentList.where((t) => t.id != id).toList();
      await _saveTransactions(newList);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<TransactionModel>> getTransactions() {
    return _transactionController.stream;
  }

  @override
  Future<Either<Failure, void>> updateTransaction(
      TransactionModel transaction) async {
    try {
      final currentList = _transactionController.valueOrNull ?? [];
      final index = currentList.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        final newList = [...currentList];
        newList[index] = transaction;
        await _saveTransactions(newList);
        return right(null);
      } else {
        return left(const ServerFailure('Transaction not found'));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
