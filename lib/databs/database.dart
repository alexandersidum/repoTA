// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:Monitoring/Model/item.dart';

// class Database {

//   Database({this.uid});

//   final String uid;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String usulanPath = 'usulan';
 



//   Stream<List<Item>> getUsulan() {
//     return _firestore.collection(usulanPath).snapshots().map(
//         (QuerySnapshot snapshot) => snapshot.documents
//             .map((DocumentSnapshot document) => Item.fromDb(document.data)).toList());
//   }

//   //Belum diberi method
//   Future<void> deleteItem() async{
    
//   }

//   Future<void> updateItem() async{

//   }

//   Future<void> addUsulan(Item usulan, Function callback) async{
//     await _firestore.collection(usulanPath).add(usulan.toMap()).then((value) async{
//       value!=null? callback(value.path.toString(), await _firestore.document(value.path).documentID.toString()) : callback('GAGAL', 'GAGAL');
//     }).timeout(Duration(seconds: 10)).catchError((error){callback('GAGAL EROR $error');});
//   }



// }