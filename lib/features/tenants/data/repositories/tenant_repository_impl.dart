import 'dart:async';
import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/providers/shared_prefs_provider.dart';
import '../../domain/repositories/tenant_repository.dart';
import '../models/contract_model.dart';
import '../models/tenant_model.dart';

part 'tenant_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TenantRepository tenantRepository(TenantRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider).asData!.value;
  return TenantRepositoryLocalImpl(prefs);
}

class TenantRepositoryLocalImpl implements TenantRepository {
  final SharedPreferences _prefs;
  final _tenantsController = BehaviorSubject<List<TenantModel>>();
  final _contractsController = BehaviorSubject<List<ContractModel>>();

  List<TenantModel> _tenants = [];
  List<ContractModel> _contracts = [];
  bool _initialized = false;

  TenantRepositoryLocalImpl(this._prefs);

  void _init() {
    if (_initialized) return;
    _initialized = true;

    // Load Tenants
    final tenantsJson = _prefs.getString('local_tenants');
    if (tenantsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(tenantsJson);
        _tenants = decoded.map((e) => TenantModel.fromJson(e)).toList();
      } catch (e) {
        print('Error decoding tenants: $e');
        _tenants = [];
      }
    }
    _tenantsController.add(_tenants);

    // Load Contracts
    final contractsJson = _prefs.getString('local_contracts');
    if (contractsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(contractsJson);
        _contracts = decoded.map((e) => ContractModel.fromJson(e)).toList();
      } catch (e) {
        print('Error decoding contracts: $e');
        _contracts = [];
      }
    }
    _contractsController.add(_contracts);
  }

  Future<void> _saveTenants() async {
    final encoded = jsonEncode(_tenants.map((e) => e.toJson()).toList());
    await _prefs.setString('local_tenants', encoded);
    _tenantsController.add(_tenants);
  }

  Future<void> _saveContracts() async {
    final encoded = jsonEncode(_contracts.map((e) => e.toJson()).toList());
    await _prefs.setString('local_contracts', encoded);
    _contractsController.add(_contracts);
  }

  @override
  Stream<List<TenantModel>> getTenants() {
    if (!_initialized) _init();
    Future.microtask(() {
      if (!_tenantsController.hasValue) {
        _tenantsController.add(_tenants);
      }
    });
    return _tenantsController.stream;
  }

  @override
  Stream<List<ContractModel>> getContracts() {
    if (!_initialized) _init();
    Future.microtask(() {
      if (!_contractsController.hasValue) {
        _contractsController.add(_contracts);
      }
    });
    return _contractsController.stream;
  }

  @override
  Stream<List<ContractModel>> getContractsByRoomId(String roomId) {
    if (!_initialized) _init();
    return _contractsController.stream.map((contracts) {
      return contracts.where((c) => c.roomId == roomId).toList();
    });
  }

  @override
  Future<Either<Failure, String>> addTenant(TenantModel tenant) async {
    try {
      if (!_initialized) _init();
      final newId = tenant.id.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : tenant.id;
      final newTenant = tenant.copyWith(id: newId);
      _tenants.add(newTenant);
      await _saveTenants();
      return right(newId);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTenant(TenantModel tenant) async {
    try {
      if (!_initialized) _init();
      final index = _tenants.indexWhere((t) => t.id == tenant.id);
      if (index != -1) {
        _tenants[index] = tenant;
        await _saveTenants();
        return right(null);
      }
      return left(ServerFailure('Tenant not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTenant(String tenantId) async {
    try {
      if (!_initialized) _init();
      _tenants.removeWhere((t) => t.id == tenantId);
      await _saveTenants();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addContract(ContractModel contract) async {
    try {
      if (!_initialized) _init();
      final newContract = contract.copyWith(
        id: contract.id.isEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : contract.id,
      );
      _contracts.add(newContract);
      await _saveContracts();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateContract(ContractModel contract) async {
    try {
      if (!_initialized) _init();
      final index = _contracts.indexWhere((c) => c.id == contract.id);
      if (index != -1) {
        _contracts[index] = contract;
        await _saveContracts();
        return right(null);
      }
      return left(ServerFailure('Contract not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContract(String contractId) async {
    try {
      if (!_initialized) _init();
      _contracts.removeWhere((c) => c.id != contractId);
      await _saveContracts();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
