import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_dialog/cli_dialog.dart';
import 'package:easy_app_cli/src/utils/commands/commands.dart';
import 'package:easy_app_cli/src/utils/commands/src/pub_get.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:easy_app_cli/src/utils/core/bricks.dart';
import 'package:easy_app_cli/src/utils/core/packages.dart';
import 'package:easy_app_cli/src/utils/generator/generate_bricks.dart';
import 'package:mason_logger/mason_logger.dart';

/// Command for the module.
class InitCommand extends Command<int> {
  /// Constructor.
  /// {@macro easy_app_cli}
  InitCommand({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super();

  final Logger _logger;

  @override
  String get description => 'Initialize a new project.';

  @override
  String get name => 'init';

  /// The function that is executed when the command is run.
  @override
  String get invocation => '${Constants.packageCli} init';

  @override
  String get summary => '$invocation\n$description';

  /// [ArgResults] which can be overridden for testing.
  ArgResults? argResultOverrides;

  /// No Need for now.
  // ArgResults get _argResults => argResultOverrides ?? argResults!;

  @override
  Future<int> run() async {
    _logger.info('Running command: ${Constants.packageCli} $name');

    /// No Need for now.
    // _logger.info('Running command: $name ${_argResults.arguments}');

    await flutterPubAdd(_logger, packageName: PackagesName.goRoute);
    await flutterPubAdd(_logger, packageName: PackagesName.flexColorScheme);
    await flutterPubAdd(_logger, packageName: PackagesName.googleFonts);

    await flutterPubGet(_logger);

    await generateBricks(
      _logger,
      brickName: BricksName.init,
      brickVersion: kBricks[BricksName.init]!,
    );

    try {
      final dialog = CLI_Dialog(
        booleanQuestions: <dynamic>[
          ['Do you want to create a new module?', 'name']
        ],
      );
      final flag = dialog.ask()['name'] as bool;

      if (flag) {
        await _addExtraModules(flag);
      }
    } catch (e) {
      _logger.err('Error: $e');
      return 1;
    }

    return ExitCode.usage.code;
  }

  Future<void> _addExtraModules(bool flag) async {
    var temp = flag;
    do {
      /// Generate a new module.
      final templateDialog = CLI_Dialog(
        questions: <dynamic>[
          ['What is your module name?', 'name']
        ],
      );

      final template = templateDialog.ask()['name'].toString();

      await generateBricks(
        _logger,
        brickName: BricksName.blank,
        brickVersion: kBricks[BricksName.blank]!,
        vars: <String, dynamic>{
          'name': template,
        },
      );

      /// Ask for the module name.
      final dialog = CLI_Dialog(
        booleanQuestions: <dynamic>[
          ['Again create a new module?', 'name']
        ],
      );
      final flag = dialog.ask()['name'] as bool;
      temp = flag;
    } while (temp);
  }
}
