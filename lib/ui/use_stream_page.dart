import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UseStreamPage extends HookConsumerWidget {
  const UseStreamPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget型の空っぽのリスト。この中に下のコードを格納する
    List<Widget> listTile = [];
    // useMemoizedでFirestoreのuserコレクションのキャッシュをとる.
    final memo = useMemoized(
        () => FirebaseFirestore.instance.collection('user').snapshots());
    // 更新があったときだけ、firestoreのuserコレクションを読み込む.
    final snapshot = useStream(memo);
    // listTileにfirestoreから取得したデータを追加する
    if (snapshot.hasData) {
      final docs = snapshot.data?.docs;
      docs?.forEach((element) {
        listTile.add(ListTile(
          title: Text(element.data()['name']),
          subtitle: Text(element.data()['age'].toString()),
        ));
      });
    }

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: listTile,// 画面に、List<Widget> listTile = [];の中身を表示する
        ));
  }
}
