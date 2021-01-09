// import 'dart:developer';

import 'package:Monitoring/Model/lpse.dart';
import 'package:Monitoring/Model/servicelpse.dart';
import 'package:flutter/material.dart';


class MonLpse extends StatefulWidget {
MonLpse():super();
final String title = 'Monitoring LPSE';

  @override
  _MonLpseState createState() => _MonLpseState();
}

class _MonLpseState extends State<MonLpse> {
  List<Lpse> _lpses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaPaketController;
  TextEditingController _jenisPengadaanController;
  TextEditingController _statusPengadaanController;
  Lpse _selectedLpse;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _getLpse();
    _lpses = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaPaketController = TextEditingController();
    _jenisPengadaanController = TextEditingController();
    _statusPengadaanController = TextEditingController();
  }
  // _showSnackBar(context,message){
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);

  // }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

//  _createLpse() {
//     _showProgress('Creating Table...');
//     ServiceLpse.createTable().then((result){
//       if  ('success' == result){
//         _showSnackBar(context, result);

//       }
//     });
//   }
 _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
     content: Text("Ditambahkan"),
    ));
  }
   _addLpse() {
       if (_namaPaketController.text.trim().isEmpty ||
        _jenisPengadaanController.text.trim().isEmpty ||
        _statusPengadaanController.text.trim().isEmpty
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Lpse...');
      ServiceLpse.addLpse(_namaPaketController.text,  _jenisPengadaanController.text, _statusPengadaanController.text).then((result)
      {
         if  ('success' == result){
           _showSnackBar(context, result);
           _getLpse();
           }
         _clearValues();

     });

  }
_getLpse() {
  _showProgress('Loading Lpse...');
    ServiceLpse.getLpse().then((lpses) {
      setState(() {
        _lpses = lpses;
      });
      _showProgress(widget.title);
      print("Length: ${lpses.length}");
    });
  }



  _updateLpse(Lpse lpse) {
    _showProgress('Updating Ekatalog...');
    ServiceLpse.updateLpse(
            lpse.id, _namaPaketController.text,  _jenisPengadaanController.text, _statusPengadaanController.text) 
        .then((result) {
      if ('success' == result) {
        setState(() {
          _isUpdating = false;
        });
        _namaPaketController.text = '';
        _jenisPengadaanController.text = '';
        _statusPengadaanController.text = '';

      }
    });

  }
  _deleteLpse(Lpse lpse) {
    _showProgress('Deleting Employee...');
    ServiceLpse.deleteLpse(lpse.id).then((result) {
      if ('success' == result) {
        setState(() {
          _lpses.remove(lpse);
        });
        _getLpse();
      }
    });
  }
   _showValues(Lpse lpse) {
    _namaPaketController.text = lpse.namaPaket;
    _statusPengadaanController.text = lpse.jenisPengadaan; 
    _jenisPengadaanController.text = lpse.statusPengadaan;
    setState(() {
      _isUpdating = true;
    });
  }
  _clearValues(){
      _namaPaketController.text = '';
      _statusPengadaanController.text = '';
      _jenisPengadaanController.text = '';
  }


SingleChildScrollView _databody(){
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
        // DataColumn(
        //   label: Text('ID'),
        
        // ),
         DataColumn(
          label: Text('Nama Paket'),
        
        ),
         DataColumn(
          label: Text('Jenis Pengadaan'),
        
        ),
         DataColumn(
          label: Text('Tahap Status'),
        
        ),
         DataColumn(
          label: Text('Hapus'),
        
        ),
      ],
      rows: _lpses
      .map(
        (lpse) => DataRow(cells: [
          // DataCell(
            // Text(lpse.id),
            // onTap: (){
            //   _showValues(lpse);
            //   _selectedLpse = lpse;
            // }
            
            // ),
            DataCell(
            Container(
            width: 300,
            child : Text(lpse.namaPaket.toUpperCase()),    
        ),
      onTap: (){
            _showValues(lpse);
            _selectedLpse = lpse;
          }),
          DataCell(
          Text(lpse.jenisPengadaan.toUpperCase()),
          onTap: (){
            _showValues(lpse);
            _selectedLpse = lpse;
            }
            ),
            DataCell(
            Text(lpse.statusPengadaan.toUpperCase()),
            onTap: (){
              _showValues(lpse);
              _selectedLpse = lpse;
            }),
            DataCell(IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              _deleteLpse(lpse);
            },
            ))
        ]

      )).toList(),
      ),
    ),
      

  );

}



  @override
  Widget build(BuildContext context) {
       return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          actions: <Widget>[
            // IconButton(
            //     icon: Icon(Icons.add),
            //     onPressed: () {
            //      _createLpse();
            //     }),
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getLpse();
                }),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _namaPaketController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Paket',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _jenisPengadaanController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Jenis Pengadaan',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _statusPengadaanController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Tahap Status',

                  ),
                ),
              ),

              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateLpse(_selectedLpse);
                  },
                  ),
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
          ),
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              _addLpse();
          } ,
          child: Icon(Icons.add),
          ),
        );
  }
}

