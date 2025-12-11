import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/tenant_model.dart';
import '../../data/models/contract_model.dart';

abstract class TenantRepository {
  // Tenants
  Stream<List<TenantModel>> getTenants();
  Future<Either<Failure, String>> addTenant(
      TenantModel tenant); // Returns new ID
  Future<Either<Failure, void>> updateTenant(TenantModel tenant);
  Future<Either<Failure, void>> deleteTenant(String tenantId);

  // Contracts
  Stream<List<ContractModel>> getContracts();
  Stream<List<ContractModel>> getContractsByRoomId(String roomId);
  Future<Either<Failure, void>> addContract(ContractModel contract);
  Future<Either<Failure, void>> updateContract(ContractModel contract);
}
