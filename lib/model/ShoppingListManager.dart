import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingListManager {
  final FirebaseFirestore _fireStore;
  String uid;

  Stream<DocumentSnapshot> get shoppingListStream =>
      _fireStore.collection('users').doc(uid).snapshots();

  ShoppingListManager(this._fireStore, this.uid);

  Future<List<String>> getShoppingList() async {
    DocumentReference shoppingListRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    var sh = await shoppingListRef.get();
    List<dynamic> isbn = sh.data()['shoppingCart'];
    List<String> list;
    isbn.map((e) => list.add(e));
    return list;
  }
}
