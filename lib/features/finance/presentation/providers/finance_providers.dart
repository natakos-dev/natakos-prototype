import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/bill_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/models/expense_model.dart';
import '../../data/repositories/finance_repository_impl.dart';

final billsProvider = StreamProvider<List<BillModel>>((ref) {
  return ref.watch(financeRepositoryProvider).getBills();
});

final paymentsProvider = StreamProvider<List<PaymentModel>>((ref) {
  return ref.watch(financeRepositoryProvider).getPayments();
});

final expensesProvider = StreamProvider<List<ExpenseModel>>((ref) {
  return ref.watch(financeRepositoryProvider).getExpenses();
});

// Computed Providers for Dashboard/Summary
final totalPendingBillsProvider = Provider<AsyncValue<double>>((ref) {
  return ref.watch(billsProvider).whenData((bills) {
    return bills
        .where((b) => b.status == 'Unpaid')
        .fold(0.0, (sum, b) => sum + b.totalAmount);
  });
});

final totalRevenueProvider = Provider<AsyncValue<double>>((ref) {
  // Revenue comes from Payments (collected money)
  return ref.watch(paymentsProvider).whenData((payments) {
    return payments.fold(0.0, (sum, p) => sum + p.amount);
  });
});

final totalExpensesProvider = Provider<AsyncValue<double>>((ref) {
  return ref.watch(expensesProvider).whenData((expenses) {
    return expenses.fold(0.0, (sum, e) => sum + e.amount);
  });
});

final netIncomeProvider = Provider<AsyncValue<double>>((ref) {
  final revenue = ref.watch(totalRevenueProvider).valueOrNull ?? 0.0;
  final expenses = ref.watch(totalExpensesProvider).valueOrNull ?? 0.0;
  return AsyncValue.data(revenue - expenses);
});
