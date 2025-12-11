import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/transaction_model.dart';
// import '../../domain/repositories/transaction_repository.dart'; // Unused
import '../../data/repositories/transaction_repository_impl.dart';

part 'transaction_provider.g.dart';

@riverpod
Stream<List<TransactionModel>> transactionList(TransactionListRef ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.getTransactions();
}

@riverpod
class TransactionController extends _$TransactionController {
  @override
  FutureOr<void> build() {
    // Initial state is void
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = const AsyncValue.loading();
    final repository = ref.read(transactionRepositoryProvider);
    final result = await repository.addTransaction(transaction);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => const AsyncValue.data(null),
    );
  }

  Future<void> deleteTransaction(String id) async {
    state = const AsyncValue.loading();
    final repository = ref.read(transactionRepositoryProvider);
    final result = await repository.deleteTransaction(id);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (success) => const AsyncValue.data(null),
    );
  }
}

// Derived providers for summary
@riverpod
Stream<double> totalIncome(TotalIncomeRef ref) {
  final transactionsStream = ref.watch(transactionListProvider.stream);
  return transactionsStream.map((transactions) {
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  });
}

@riverpod
Stream<double> totalExpense(TotalExpenseRef ref) {
  final transactionsStream = ref.watch(transactionListProvider.stream);
  return transactionsStream.map((transactions) {
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  });
}

@riverpod
Stream<double> netIncome(NetIncomeRef ref) {
  final incomeAsync = ref.watch(totalIncomeProvider);
  final expenseAsync = ref.watch(totalExpenseProvider);

  return Stream.value(
    (incomeAsync.valueOrNull ?? 0) - (expenseAsync.valueOrNull ?? 0),
  );
}
