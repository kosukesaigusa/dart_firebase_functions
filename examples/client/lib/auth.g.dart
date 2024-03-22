// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'd16c749264a27d9c7764e2bf1221402e2e866d8f';

/// See also [_firebaseAuth].
@ProviderFor(_firebaseAuth)
final _firebaseAuthProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  _firebaseAuth,
  name: r'_firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _FirebaseAuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$authUserHash() => r'21036150886a36562e41e7295deee5d04283fd53';

/// See also [authUser].
@ProviderFor(authUser)
final authUserProvider = AutoDisposeStreamProvider<User?>.internal(
  authUser,
  name: r'authUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthUserRef = AutoDisposeStreamProviderRef<User?>;
String _$currentUserIdHash() => r'bb5814629d28f8a2cd250170c37fb5e1ab16fd4f';

/// See also [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$authHash() => r'a871fac06fc2bfbb8f81ff6ca482ac40c4cb8f99';

/// See also [Auth].
@ProviderFor(Auth)
final authProvider = AutoDisposeAsyncNotifierProvider<Auth, User?>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = AutoDisposeAsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
