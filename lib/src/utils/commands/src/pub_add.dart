import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';

/// Add Flutter Package in project
Future<void> flutterPubAdd(
  Logger logger, {
  required String packageName,
  String? operation = 'add',
}) async {
  final _shell = Shell();
  try {
    await _shell.run(
      '''
        # ✓ Running "flutter pub $operation $packageName" in projects
        flutter pub $operation $packageName
      ''',
    );
  } on ShellException {
    await flutterPubAdd(logger, packageName: packageName, operation: 'upgrade');
  } catch (e) {
    logger.err(e.toString());
  }
}
