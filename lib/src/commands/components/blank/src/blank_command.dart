import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:easy_app_cli/src/utils/bricks/bricks.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:mason/mason.dart';

/// Command for the module.
class BlankCommand extends Command<int> {
  /// Constructor.
  /// {@macro easy_app_cli}
  BlankCommand({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super();

  final Logger _logger;

  @override
  String get description => 'Create a blank Screen.';

  @override
  String get name => 'blank';

  /// The function that is executed when the command is run.
  @override
  String get invocation => '${Constants.packageCli} $name [template]';

  @override
  String get summary => '$invocation\n$description';

  /// [ArgResults] which can be overridden for testing.
  ArgResults? argResultOverrides;

  ArgResults get _argResults => argResultOverrides ?? argResults!;

  @override
  Future<int> run() async {
    final generateDone = _logger.progress('Bootstrapping');
    generateDone.call();

    try {
      await _generate();
    } catch (e) {
      _logger.err(e.toString());
    }

    return ExitCode.usage.code;
  }

  Future<void> _generate() async {
    final brick = Brick.version(
      name: BricksName.blank,
      version: kBricks[BricksName.blank]!,
    );
    final generator = await MasonGenerator.fromBrick(brick);
    final target = DirectoryGeneratorTarget(Directory.current);
    await generator.generate(
      target,
      vars: <String, dynamic>{
        'name': _argResults.arguments[0],
      },
    );
  }
}
