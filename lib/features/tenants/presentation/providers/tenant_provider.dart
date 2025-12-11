import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/tenant_model.dart';
import '../../domain/repositories/tenant_repository.dart';
import '../../data/repositories/tenant_repository_impl.dart';

part 'tenant_provider.g.dart';

@riverpod
Stream<List<TenantModel>> tenantList(TenantListRef ref) {
  final repository = ref.watch(tenantRepositoryProvider);
  return repository.getTenants();
}

@riverpod
class TenantController extends _$TenantController {
  @override
  FutureOr<void> build() {
    // Initial state is void
  }

  Future<void> addTenant(TenantModel tenant) async {
    state = const AsyncValue.loading();
    final repository = ref.read(tenantRepositoryProvider);
    final result = await repository.addTenant(tenant);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (success) => state = const AsyncValue.data(null),
    );
  }

  Future<void> updateTenant(TenantModel tenant) async {
    state = const AsyncValue.loading();
    final repository = ref.read(tenantRepositoryProvider);
    final result = await repository.updateTenant(tenant);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (success) => state = const AsyncValue.data(null),
    );
  }

  Future<void> deleteTenant(String tenantId) async {
    state = const AsyncValue.loading();
    final repository = ref.read(tenantRepositoryProvider);
    final result = await repository.deleteTenant(tenantId);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (success) => state = const AsyncValue.data(null),
    );
  }
}
