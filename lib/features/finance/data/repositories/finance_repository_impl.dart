import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/bill_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/models/expense_model.dart';
import '../../data/models/other_cost_model.dart';
import '../../domain/repositories/finance_repository.dart';

part 'finance_repository_impl.g.dart';

@Riverpod(keepAlive: true)
FinanceRepository financeRepository(FinanceRepositoryRef ref) {
  return FinanceRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
}

class FinanceRepositoryImpl implements FinanceRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FinanceRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> _collection(String name) {
    if (_userId.isEmpty) throw Exception('User not logged in');
    return _usersCollection.doc(_userId).collection(name);
  }

  // --- Bills ---

  @override
  Stream<List<BillModel>> getBills() {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('bills').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => BillModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Stream<List<BillModel>> getBillsByContractId(String contractId) {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('bills')
          .where('contractId', isEqualTo: contractId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => BillModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Either<Failure, void>> addBill(BillModel bill) async {
    try {
      final docRef = _collection('bills').doc();
      final billWithId = bill.copyWith(id: docRef.id);
      await docRef.set(billWithId.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBill(BillModel bill) async {
    try {
      await _collection('bills')
          .doc(bill.id)
          .update(bill.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBill(String billId) async {
    try {
      await _collection('bills').doc(billId).delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  // --- Payments ---

  @override
  Stream<List<PaymentModel>> getPayments() {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('payments').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => PaymentModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Stream<List<PaymentModel>> getPaymentsByBillId(String billId) {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('payments')
          .where('billId', isEqualTo: billId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => PaymentModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Either<Failure, void>> addPayment(PaymentModel payment) async {
    try {
      final docRef = _collection('payments').doc();
      final paymentWithId = payment.copyWith(id: docRef.id);
      await docRef.set(paymentWithId.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePayment(String paymentId) async {
    try {
      await _collection('payments').doc(paymentId).delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  // --- Expenses ---

  @override
  Stream<List<ExpenseModel>> getExpenses() {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('expenses').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => ExpenseModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(ExpenseModel expense) async {
    try {
      final docRef = _collection('expenses').doc();
      final expenseWithId = expense.copyWith(id: docRef.id);
      await docRef.set(expenseWithId.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(ExpenseModel expense) async {
    try {
      await _collection('expenses')
          .doc(expense.id)
          .update(expense.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String expenseId) async {
    try {
      await _collection('expenses').doc(expenseId).delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  // --- Other Costs ---

  @override
  Stream<List<OtherCostModel>> getOtherCosts() {
    try {
      if (_auth.currentUser == null) return Stream.value([]);
      return _collection('other_costs').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => OtherCostModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Either<Failure, void>> addOtherCost(OtherCostModel cost) async {
    try {
      final docRef = _collection('other_costs').doc();
      final costWithId = cost.copyWith(id: docRef.id);
      await docRef.set(costWithId.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOtherCost(OtherCostModel cost) async {
    try {
      await _collection('other_costs')
          .doc(cost.id)
          .update(cost.toJson()..remove('id'));
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOtherCost(String costId) async {
    try {
      await _collection('other_costs').doc(costId).delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
