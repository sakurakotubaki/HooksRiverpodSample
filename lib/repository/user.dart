import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// UserDataクラスをプロバイダーで読み込めるようにする.
// こうすることで、メソッドを呼び出せる
final userDataProvider = Provider<UserData>((ref) {
  return UserData();
});

class UserData {
  // Firestoreを使用するパッケージのクラスをインスタンス化する
  final db = FirebaseFirestore.instance;
  // データを保存するメソッド
  Future<void> addUser(String nameController, String ageController) async {
    await db.collection('user').add({
      'name': nameController,
      'age': int.parse(ageController),// 数値のデータに型変換して保存する
    });
  }
}
