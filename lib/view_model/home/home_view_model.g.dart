// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchHomeProjectHash() => r'43c326288fe978a9aeaa2ec052cce90a6bc2faf6';

/// See also [fetchHomeProject].
@ProviderFor(fetchHomeProject)
final fetchHomeProjectProvider = AutoDisposeFutureProvider<HomeModel>.internal(
  fetchHomeProject,
  name: r'fetchHomeProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchHomeProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchHomeProjectRef = AutoDisposeFutureProviderRef<HomeModel>;
String _$fetchHomeCategoriesHash() =>
    r'83b3e45b1d6918624afecb5b5ad10e7f5314a88d';

/// See also [fetchHomeCategories].
@ProviderFor(fetchHomeCategories)
final fetchHomeCategoriesProvider =
    AutoDisposeFutureProvider<List<ProjectCategory>>.internal(
  fetchHomeCategories,
  name: r'fetchHomeCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchHomeCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchHomeCategoriesRef
    = AutoDisposeFutureProviderRef<List<ProjectCategory>>;
String _$homeViewModelHash() => r'dcb3daba5fdd4af188142f6e4dc7467f1e92a72d';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, HomeState?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<HomeState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
