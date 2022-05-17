import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';

/// Generate the bricks.
Future<void> generateBricks(
  Logger logger, {
  required String brickName,
  required String brickVersion,
  required Map<String, dynamic> vars,
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
      vars: vars,
    );
  } catch (e) {
    logger.err(e.toString());
  }
}
