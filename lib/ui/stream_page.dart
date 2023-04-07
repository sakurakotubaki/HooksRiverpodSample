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

class StreamPage extends HookConsumerWidget {
  const StreamPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Streamと呼ばれているデータの変化を監視しているものを呼び出す.
    // Riverpodで状態をずっと監視するときは、ref.watchを使う
    // ref.watchは、変数の中で使う。ボタンとかロジックを呼び出すところでは、ref.readを使う
    final userStream = ref.watch(userStreamProvider);

    // データを保存するメソッドを呼び出すプロバイダー
    final userData = ref.watch(userDataProvider);

    // Firestoreに入力フォームの値を保存するuseTextEditingController
    final nameController = useTextEditingController();
    final ageController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            userStream.when(
              // データがあった（データはqueryの中にある）
              data: (QuerySnapshot query) {
                // user内のドキュメントをリストで表示する
                return ListView(
                  // user内のドキュメント１件ずつをCard枠を付けたListTileのListとしてListViewのchildrenとする
                  children: query.docs.map((document) {
                    return Card(
                      child: ListTile(
                        // userで送った内容を表示する
                        title: Text(document['name']),
                        subtitle: Text(document['age']
                            .toString()), // int型のデータはString型に変換しないと表示できない
                      ),
                    );
                  }).toList(),
                );
              },

              // データの読み込み中（FireStoreではあまり発生しない）
              loading: () {
                return const Text('Loading');
              },

              // エラー（例外発生）時
              error: (e, stackTrace) {
                return Text('error: $e');
              },
            )
          ],
        ),
      ),
    );
  }
}
