import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/bill_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/models/expense_model.dart';
import '../../data/models/other_cost_model.dart';

abstract class FinanceRepository {
  // Bills
  Stream<List<BillModel>> getBills();
  Stream<List<BillModel>> getBillsByContractId(String contractId);
  Future<Either<Failure, void>> addBill(BillModel bill);
  Future<Either<Failure, void>> updateBill(BillModel bill);
  Future<Either<Failure, void>> deleteBill(String billId);

  // Payments
  Stream<List<PaymentModel>> getPayments();
  Stream<List<PaymentModel>> getPaymentsByBillId(String billId);
  Future<Either<Failure, void>> addPayment(PaymentModel payment);
  Future<Either<Failure, void>> deletePayment(String paymentId);

  // Expenses
  Stream<List<ExpenseModel>> getExpenses();
  Future<Either<Failure, void>> addExpense(ExpenseModel expense);
  Future<Either<Failure, void>> updateExpense(ExpenseModel expense);
  Future<Either<Failure, void>> deleteExpense(String expenseId);

  // Other Costs
  Stream<List<OtherCostModel>> getOtherCosts();
  Future<Either<Failure, void>> addOtherCost(OtherCostModel cost);
  Future<Either<Failure, void>> updateOtherCost(OtherCostModel cost);
  Future<Either<Failure, void>> deleteOtherCost(String costId);
}
