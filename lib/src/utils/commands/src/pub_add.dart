import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';

/// Add Flutter Package in project
Future<void> flutterPubAdd(Logger logger, {required String packageName}) async {
  final _shell = Shell();
  try {
    await _shell.run(
      '''
        # ✓ Running "flutter pub add $packageName" in projects
        flutter pub add $packageName
        ''',
    );
  } catch (e) {
    logger.err(e.toString());
  }
}
