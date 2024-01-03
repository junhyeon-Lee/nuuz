// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nuuz_my_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultsForDateRangeHash() =>
    r'4931d7906387c33a56df26a31c2240cc8b387233';

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

typedef ResultsForDateRangeRef = FutureProviderRef<ResultList?>;

/// See also [resultsForDateRange].
@ProviderFor(resultsForDateRange)
const resultsForDateRangeProvider = ResultsForDateRangeFamily();

/// See also [resultsForDateRange].
class ResultsForDateRangeFamily extends Family<AsyncValue<ResultList?>> {
  /// See also [resultsForDateRange].
  const ResultsForDateRangeFamily();

  /// See also [resultsForDateRange].
  ResultsForDateRangeProvider call(
    String startDate,
    String endDate,
  ) {
    return ResultsForDateRangeProvider(
      startDate,
      endDate,
    );
  }

  @override
  ResultsForDateRangeProvider getProviderOverride(
    covariant ResultsForDateRangeProvider provider,
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
  String? get name => r'resultsForDateRangeProvider';
}

/// See also [resultsForDateRange].
class ResultsForDateRangeProvider extends FutureProvider<ResultList?> {
  /// See also [resultsForDateRange].
  ResultsForDateRangeProvider(
    this.startDate,
    this.endDate,
  ) : super.internal(
          (ref) => resultsForDateRange(
            ref,
            startDate,
            endDate,
          ),
          from: resultsForDateRangeProvider,
          name: r'resultsForDateRangeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resultsForDateRangeHash,
          dependencies: ResultsForDateRangeFamily._dependencies,
          allTransitiveDependencies:
              ResultsForDateRangeFamily._allTransitiveDependencies,
        );

  final String startDate;
  final String endDate;

  @override
  bool operator ==(Object other) {
    return other is ResultsForDateRangeProvider &&
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
