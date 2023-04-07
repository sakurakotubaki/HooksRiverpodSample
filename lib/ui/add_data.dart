// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menta_app/repository/user.dart';

final userStreamProvider = StreamProvider((ref) {
  final db = FirebaseFirestore.instance;
  final streamData = db.collection('user').snapshots();
  return streamData;
});

class AddData extends HookConsumerWidget {
  const AddData({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データを保存するメソッドを呼び出すプロバイダー
    final userData = ref.watch(userDataProvider);

    // Firestoreに入力フォームの値を保存するuseTextEditingController
    final nameController = useTextEditingController();
    final ageController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'input name'),
            ),
          ),
          const SizedBox(height: 20),
          // 間にContainerを入れないと左端に寄ってしまうので、配置した
          Container(),
          SizedBox(
            width: 300,
            child: TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'input age'),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                userData.addUser(nameController.text, ageController.text);
              },
              child: const Text('Send'))
        ],
      ),
    );
  }
}
