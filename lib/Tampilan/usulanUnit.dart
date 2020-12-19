//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Monitoring/Komponen/kustom_button.dart';
import 'package:Monitoring/konstan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:Monitoring/Model/Item.dart';
// import 'package:Monitoring/databs/database.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({Key key}) : super(key: key);
//static const routeId = 'usulanUnit';

  @override
  _ProposalScreenState createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  var controllerJudul = TextEditingController();
  var controllerUnit = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String judul;
  String unit;
  String stateText = '';

  // @override
  _clearValue() {
    controllerJudul.clear();
    controllerUnit.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
	future: Firebase.initializeApp(),
	builder: (context, snapshot) {
      // Check errors
      if (snapshot.hasError) {
        return Center(
          child: Text('Error'),
        );
      }

      if (snapshot.connectionState == ConnectionState.done) {
        return Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Judul Usulan',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controllerJudul,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Judul..',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                Text(
                  'Nama Unit..',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  //flex: 1,
                  child: TextField(
                    controller: controllerUnit,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nama Unit..',
                      //contentPadding: EdgeInsets.only(top: 10, left: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Text(stateText),
                CustomRaisedButton(
                  color: Colors.blue[300],
                  buttonHeight: size.height / 10,
                  text: 'Submit Usulan',
                  callback: () {
                    //Upload ke firebase, masukkan fungsi ke class provider lebih baik
                    //Provider.of<Database>(context).addUsulan()
                    sendProposal(
                      controllerJudul.text.toString(),
                      controllerUnit.text.toString(),
                    );
                    _clearValue();
                  },
                  buttonChild: Text("Submit Usulan",
                      textAlign: TextAlign.center,
                      style:
                          kMavenBold.copyWith(fontSize: size.height * 0.028)),
                ),
              ],
            ));
      }

      // Kalau koneksi belum slesai
      return Center(
        child: Text('Loading'),
      );
    });
  }

  Future<void> sendProposal(String judul, String unit) async {
    await _firestore
        .collection('Usulan')
        .add({
          'judul': judul,
          'unit': unit,
        })
        .then((value) async {
          setState(() {
            value != null ? stateText = 'BERHASIL SUBMIT' : stateText = 'GAGAL';
          _clearValue();}); 
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          stateText = 'gagal $error';
        });
  }
}
