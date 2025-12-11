// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tenantListHash() => r'200791e1f5f8e7fa44f98bc4167b699bbdd44f64';

/// See also [tenantList].
@ProviderFor(tenantList)
final tenantListProvider =
    AutoDisposeStreamProvider<List<TenantModel>>.internal(
  tenantList,
  name: r'tenantListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tenantListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TenantListRef = AutoDisposeStreamProviderRef<List<TenantModel>>;
String _$tenantControllerHash() => r'aed264d3e12fc98ab1d1b706fddd97eb79c82db0';

/// See also [TenantController].
@ProviderFor(TenantController)
final tenantControllerProvider =
    AutoDisposeAsyncNotifierProvider<TenantController, void>.internal(
  TenantController.new,
  name: r'tenantControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tenantControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TenantController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
