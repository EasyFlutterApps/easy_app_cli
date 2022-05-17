import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';

/// Generate the bricks.
Future<void> generateBricks(
  Logger logger, {
  required String brickName,
  required String brickVersion,
  Map<String, dynamic>? vars = const <String, dynamic>{},
  FileConflictResolution? conflictResolution = FileConflictResolution.append,
}) async {
  try {
    final brick = Brick.version(
      name: brickName,
      version: brickVersion,
    );
    final generator = await MasonGenerator.fromBrick(brick);
    final target = DirectoryGeneratorTarget(Directory.current);
    await generator.generate(
      target,
      vars: vars!,
      fileConflictResolution: conflictResolution,
    );
  } catch (e) {
    logger.err(e.toString());
  }
}
