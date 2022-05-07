import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:mason_logger/mason_logger.dart';

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
}
