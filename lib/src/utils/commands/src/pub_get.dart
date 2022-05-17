import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';

/// Run [flutter pub get] in project
Future<void> flutterPubGet(Logger logger) async {
  final _shell = Shell();
  try {
    await _shell.run(
      '''
        # ✓ Running "flutter pub get" in projects
        flutter pub get
      ''',
    );
  } catch (e) {
    logger.err(e.toString());
  }
}
