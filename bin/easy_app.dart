import 'package:easy_app_cli/easy_app_cli.dart';
import 'package:universal_io/io.dart';

Future<void> main(List<String> args) async {
  await _flushThenExit(await EasyAppCli().run(args));
}

/// Flushes stdout and stderr, then exits the program with the given [exitCode].
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future _flushThenExit(int? status) async {
  await Future.wait<void>([
    stdout.flush(),
    stderr.flush(),
  ]).then<void>((value) => exit(status!));
}
