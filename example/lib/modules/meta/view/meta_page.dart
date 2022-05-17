import 'package:flutter/material.dart';

class MetaPage extends StatelessWidget {
  const MetaPage({Key? key}) : super(key: key);

  static const String routeName = '/meta';
  static const String name = 'Meta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meta Page'),
      ),
      body: const Center(
        child: Text('Meta Page'),
      ),
    );
  }
}
