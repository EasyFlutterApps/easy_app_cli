import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:mason_logger/mason_logger.dart';

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
}
