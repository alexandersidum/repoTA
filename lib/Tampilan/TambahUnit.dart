import 'package:Monitoring/Komponen/kustom_button.dart';
import 'package:Monitoring/Model/ServiceEntryUnit.dart';
import 'package:Monitoring/konstan.dart';
import 'package:flutter/material.dart';
class TambahUnit extends StatefulWidget {
  TambahUnit():super();
  final String title = 'Tambah Unit';
  @override
  _TambahUnitState createState() => _TambahUnitState();
}

class _TambahUnitState extends State<TambahUnit> {
    GlobalKey<ScaffoldState> _scaffoldKey;
    TextEditingController _namaUnitEntry;
    String _titleProgress;


  @override
  void initState() {
    super.initState();  
    
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaUnitEntry = TextEditingController();
    
    
  }
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Ditambahkan"),
    ));
  }
  _showProgress(String message){
      setState(() {
      _titleProgress = message;
    });
  }
   _clearValue(){
     _namaUnitEntry.text = '';
  }
   _addUnit() {
       if (_namaUnitEntry.text.trim().isEmpty 
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Rekap...');
      ServiceUnit.addUnit(_namaUnitEntry.text).then((result){ 
         if  ('success' == result){
           _showSnackBar(context, result);

         }
         _clearValue();

     });


  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
        ),
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child:CustomScrollView(
            slivers: [
              
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 16),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                     Text(
                  'Nama Unit',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  TextField(
                   controller: _namaUnitEntry,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Isi Nama Unit',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                
                CustomRaisedButton(
                  color: Colors.blue[300],
                  buttonHeight: size.height / 10,
                  text: 'Unit Ditambahkan',
                  callback: () {
                   _addUnit();
                  },
                  buttonChild: Text("Tambahkan Unit",
                      textAlign: TextAlign.center,
                      style:
                          kMavenBold.copyWith(fontSize: size.height * 0.028)),
                ),
                ])),
              )
            ],
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget> [
          //      Padding(

          //       padding: EdgeInsets.all(20.0),
          //       child: TextField(
          //         controller: _namaUnitEntry,
          //         decoration: InputDecoration.collapsed(hintText: 'Isi Nama Unit',

          //         ),
          //       ),
          //     ),
              
          //            Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //     children : [
               
          //     SizedBox(width: 20),
          //       RaisedButton(
          //         color: Colors.greenAccent,
          //         child: Text("Tambah Unit"),
          //         onPressed: (){
          //           _addUnit();
            
          //         },)
          //         ]
          //   )

              
              
          //   ],
          // ),
        )
    );
  }
}