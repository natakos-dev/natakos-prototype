// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionListHash() => r'ac51805cdbdb7db43207f6f49c3c56ae8a55e58e';

/// See also [transactionList].
@ProviderFor(transactionList)
final transactionListProvider =
    AutoDisposeStreamProvider<List<TransactionModel>>.internal(
  transactionList,
  name: r'transactionListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionListRef
    = AutoDisposeStreamProviderRef<List<TransactionModel>>;
String _$totalIncomeHash() => r'0ac2ee5ee7476dfd8d9a99590b9f3138c400e430';

/// See also [totalIncome].
@ProviderFor(totalIncome)
final totalIncomeProvider = AutoDisposeStreamProvider<double>.internal(
  totalIncome,
  name: r'totalIncomeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalIncomeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalIncomeRef = AutoDisposeStreamProviderRef<double>;
String _$totalExpenseHash() => r'8feb6dabe8d764dd3664b341d02e54cc22a39dc6';

/// See also [totalExpense].
@ProviderFor(totalExpense)
final totalExpenseProvider = AutoDisposeStreamProvider<double>.internal(
  totalExpense,
  name: r'totalExpenseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalExpenseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalExpenseRef = AutoDisposeStreamProviderRef<double>;
String _$netIncomeHash() => r'6f41cd955b2b8e92f6649e8eda44e198dc6e57e9';

/// See also [netIncome].
@ProviderFor(netIncome)
final netIncomeProvider = AutoDisposeStreamProvider<double>.internal(
  netIncome,
  name: r'netIncomeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$netIncomeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetIncomeRef = AutoDisposeStreamProviderRef<double>;
String _$transactionControllerHash() =>
    r'742fc11d312d1eccbf631c04bab0a8d596ace490';

/// See also [TransactionController].
@ProviderFor(TransactionController)
final transactionControllerProvider =
    AutoDisposeAsyncNotifierProvider<TransactionController, void>.internal(
  TransactionController.new,
  name: r'transactionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
