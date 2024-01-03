// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_care_program_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCareProgramForDateRangeHash() =>
    r'5b20172d23a2415869ad0c88ef5876b9792f0e4c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef UserCareProgramForDateRangeRef
    = FutureProviderRef<List<UserCareProgram>?>;

/// See also [userCareProgramForDateRange].
@ProviderFor(userCareProgramForDateRange)
const userCareProgramForDateRangeProvider = UserCareProgramForDateRangeFamily();

/// See also [userCareProgramForDateRange].
class UserCareProgramForDateRangeFamily
    extends Family<AsyncValue<List<UserCareProgram>?>> {
  /// See also [userCareProgramForDateRange].
  const UserCareProgramForDateRangeFamily();

  /// See also [userCareProgramForDateRange].
  UserCareProgramForDateRangeProvider call(
    String startDate,
    String endDate,
  ) {
    return UserCareProgramForDateRangeProvider(
      startDate,
      endDate,
    );
  }

  @override
  UserCareProgramForDateRangeProvider getProviderOverride(
    covariant UserCareProgramForDateRangeProvider provider,
  ) {
    return call(
      provider.startDate,
      provider.endDate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userCareProgramForDateRangeProvider';
}

/// See also [userCareProgramForDateRange].
class UserCareProgramForDateRangeProvider
    extends FutureProvider<List<UserCareProgram>?> {
  /// See also [userCareProgramForDateRange].
  UserCareProgramForDateRangeProvider(
    this.startDate,
    this.endDate,
  ) : super.internal(
          (ref) => userCareProgramForDateRange(
            ref,
            startDate,
            endDate,
          ),
          from: userCareProgramForDateRangeProvider,
          name: r'userCareProgramForDateRangeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userCareProgramForDateRangeHash,
          dependencies: UserCareProgramForDateRangeFamily._dependencies,
          allTransitiveDependencies:
              UserCareProgramForDateRangeFamily._allTransitiveDependencies,
        );

  final String startDate;
  final String endDate;

  @override
  bool operator ==(Object other) {
    return other is UserCareProgramForDateRangeProvider &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
