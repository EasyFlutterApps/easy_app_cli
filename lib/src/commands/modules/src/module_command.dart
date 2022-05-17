import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_dialog/cli_dialog.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:easy_app_cli/src/utils/core/bricks.dart';
import 'package:easy_app_cli/src/utils/generator/generate_bricks.dart';
import 'package:mason/mason.dart';

part 'blank.dart';

/// Command for the module.
class ModuleCommand extends Command<int> {
  /// Constructor.
  /// {@macro easy_app_cli}
  ModuleCommand({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super();

  final Logger _logger;

  @override
  String get description => 'create a new module';

  @override
  String get name => 'module';

  /// The function that is executed when the command is run.
  @override
  String get invocation => '${Constants.packageCli} make [template]';

  @override
  String get summary => '$invocation\n$description';

  /// [ArgResults] which can be overridden for testing.
  ArgResults? argResultOverrides;

  ArgResults get _argResults => argResultOverrides ?? argResults!;

  @override
  Future<int> run() async {
    final generateDone = _logger.progress('Bootstrapping');
    generateDone.call();

    final String template;

    if (_argResults.arguments.isEmpty) {
      final dialog = CLI_Dialog(
        questions: <dynamic>[
          ['What is your module name?', 'name']
        ],
      );

      template = dialog.ask()['name'].toString();
    } else {
      template = _argResults.arguments.first;
    }

    await generateBricks(
      _logger,
      brickName: BricksName.blank,
      brickVersion: kBricks[BricksName.blank]!,
      vars: <String, dynamic>{
        'name': template,
      },
    );

    return ExitCode.usage.code;
  }
}
