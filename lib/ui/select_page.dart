import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menta_app/ui/add_data.dart';
import 'package:menta_app/ui/stream_page.dart';
import 'package:menta_app/ui/use_stream_page.dart';

class SelectPage extends HookConsumerWidget {
  const SelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StreamPage()));
                },
                child: const Text('StreamPage')),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddData()));
            }, child: const Text('AddData')),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UseStreamPage()));
            }, child: const Text('UseStreamPage')),
          ],
        ),
      ),
    );
  }
}
