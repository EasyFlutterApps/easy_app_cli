import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:easy_app_cli/src/utils/constants/constants.dart';
import 'package:mason_logger/mason_logger.dart';

/// Command for the module.
class BottomNavBarCommand extends Command<int> {
  /// Constructor.
  /// {@macro easy_app_cli}
  BottomNavBarCommand({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super();

  final Logger _logger;

  @override
  String get description => 'Create a bottom navigation bar.';

  @override
  String get name => 'bottom_navbar';

  /// The function that is executed when the command is run.
  @override
  String get invocation => '${Constants.packageCli} init';

  @override
  String get summary => '$invocation\n$description';

  /// [ArgResults] which can be overridden for testing.
  ArgResults? argResultOverrides;

  ArgResults get _argResults => argResultOverrides ?? argResults!;
}
