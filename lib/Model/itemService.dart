import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Monitoring/Model/item.dart';

class ItemService{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


Stream<List<Item>> getItems() {
    return _firestore.collection('Usulan').snapshots().map(
        (QuerySnapshot snapshot) => snapshot.docs
            .map((DocumentSnapshot document) =>
               Item.fromDb(document.data(), document.id))
            .toList());

}

Future<void> deleteProps({String id})async{
    var docRef = _firestore.collection('Usulan');
    await docRef.doc(id).delete();
  }
}