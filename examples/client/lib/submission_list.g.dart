// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionQueryHash() => r'6eba7086f077d984c2691f060c2dab76f204986b';

/// See also [submissionQuery].
@ProviderFor(submissionQuery)
final submissionQueryProvider = AutoDisposeProvider<SubmissionQuery>.internal(
  submissionQuery,
  name: r'submissionQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submissionQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubmissionQueryRef = AutoDisposeProviderRef<SubmissionQuery>;
String _$submissionsHash() => r'a62fd6e3e416b935fc931bb9c42c40b72be24795';

/// See also [submissions].
@ProviderFor(submissions)
final submissionsProvider =
    AutoDisposeStreamProvider<List<Submission>>.internal(
  submissions,
  name: r'submissionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$submissionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubmissionsRef = AutoDisposeStreamProviderRef<List<Submission>>;
String _$userQueryHash() => r'aded169a363a8bf9a870aebfaa06501b5546a82d';

/// See also [userQuery].
@ProviderFor(userQuery)
final userQueryProvider = AutoDisposeProvider<UserQuery>.internal(
  userQuery,
  name: r'userQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserQueryRef = AutoDisposeProviderRef<UserQuery>;
String _$userHash() => r'67213eae01786433e922af63407cd641691f6f33';

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

/// See also [user].
@ProviderFor(user)
const userProvider = UserFamily();

/// See also [user].
class UserFamily extends Family<AsyncValue<User?>> {
  /// See also [user].
  const UserFamily();

  /// See also [user].
  UserProvider call(
    String userId,
  ) {
    return UserProvider(
      userId,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userProvider';
}

/// See also [user].
class UserProvider extends AutoDisposeStreamProvider<User?> {
  /// See also [user].
  UserProvider(
    String userId,
  ) : this._internal(
          (ref) => user(
            ref as UserRef,
            userId,
          ),
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<User?> Function(UserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        (ref) => create(ref as UserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<User?> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef on AutoDisposeStreamProviderRef<User?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProviderElement extends AutoDisposeStreamProviderElement<User?>
    with UserRef {
  _UserProviderElement(super.provider);

  @override
  String get userId => (origin as UserProvider).userId;
}

String _$userFcmTokenQueryHash() => r'79d8352e7829f78b84f2e297ded0216bc33784ba';

/// See also [userFcmTokenQuery].
@ProviderFor(userFcmTokenQuery)
final userFcmTokenQueryProvider =
    AutoDisposeProvider<UserFcmTokenQuery>.internal(
  userFcmTokenQuery,
  name: r'userFcmTokenQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userFcmTokenQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserFcmTokenQueryRef = AutoDisposeProviderRef<UserFcmTokenQuery>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
