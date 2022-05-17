import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:easy_app_cli/src/commands/components/components.dart';
import 'package:easy_app_cli/src/commands/init/init.dart';
import 'package:easy_app_cli/src/commands/modules/modules.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:easy_app_cli/src/version.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template easy_app_cli}
/// A Good Command Line Application created by Easy Apps
/// {@endtemplate}
class EasyAppCli extends CommandRunner<int> {
  /// {@macro easy_app_cli}
  EasyAppCli({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super(
          Constants.packageName,
          'A command line interface for the easy_app package.',
        ) {
    argParser
      ..addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
      )
      ..addFlag(
        'auto',
        negatable: false,
        help: 'Automatically run the command.',
    );

    /// Add the commands to the runner.
    addCommand(InitCommand(logger: _logger));
    addCommand(ModuleCommand(logger: _logger));
    addCommand(BottomNavBarCommand(logger: _logger));
  }

  final Logger _logger;

  @override
  Future<int?> run(Iterable<String> args) async {
    try {
      final _argResults = parse(args);
      return await runCommand(_argResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    }
  }

  /// Runs the command.
  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    int? exitCode = ExitCode.unavailable.code;
    if (topLevelResults['version'] == true) {
      _logger.info('Version: $packageVersion');
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }
    return exitCode;
  }
}
