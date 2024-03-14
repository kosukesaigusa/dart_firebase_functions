// ignore_for_file: directives_ordering, depend_on_referenced_packages
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i7;
import 'dart:io';
import 'dart:isolate' as _i5;

import 'package:build_resolvers/builder.dart' as _i4;
import 'package:build_runner/build_runner.dart' as _i6;
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:dart_firebase_functions_builder/builder.dart' as _i3;
import 'package:source_gen/builder.dart' as _i2;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    'source_gen:combining_builder',
    [_i2.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const ['source_gen:part_cleanup'],
  ),
  _i1.apply(
    'dart_firebase_functions_builder:dart_firebase_functions_builder',
    [_i3.dartFirebaseFunctionsBuilder],
    _i1.toDependentsOf('dart_firebase_functions_builder'),
    hideOutput: false,
  ),
  _i1.apply(
    'build_resolvers:transitive_digests',
    [_i4.transitiveDigestsBuilder],
    _i1.toAllPackages(),
    isOptional: true,
    appliesBuilders: const ['build_resolvers:transitive_digest_cleanup'],
  ),
  _i1.applyPostProcess(
    'build_resolvers:transitive_digest_cleanup',
    _i4.transitiveDigestCleanup,
  ),
  _i1.applyPostProcess(
    'source_gen:part_cleanup',
    _i2.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i5.SendPort? sendPort,
]) async {
  final buildDirectory = Directory('.dart_tool/build');
  if (buildDirectory.existsSync()) {
    await buildDirectory.delete(recursive: true);
  }
  final result = await _i6.run(
    ['build', '-d'],
    _builders,
  );
  sendPort?.send(result);
  _i7.exitCode = result;
}
