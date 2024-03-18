// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoQueryHash() => r'1ae9990e8428b0fd8b6e46f9f84089d61a9b9926';

/// See also [todoQuery].
@ProviderFor(todoQuery)
final todoQueryProvider = AutoDisposeProvider<TodoQuery>.internal(
  todoQuery,
  name: r'todoQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoQueryRef = AutoDisposeProviderRef<TodoQuery>;
String _$todosHash() => r'faae4309417da5c8e17d8e20451249704bd6e009';

/// See also [todos].
@ProviderFor(todos)
final todosProvider = AutoDisposeStreamProvider<List<Todo>>.internal(
  todos,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodosRef = AutoDisposeStreamProviderRef<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
