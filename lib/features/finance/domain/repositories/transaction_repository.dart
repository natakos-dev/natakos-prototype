import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> addTransaction(TransactionModel transaction);
  Future<Either<Failure, void>> deleteTransaction(String id);
  Stream<List<TransactionModel>> getTransactions();
  Future<Either<Failure, void>> updateTransaction(TransactionModel transaction);
}
