// import 'dart:developer';

import 'package:Monitoring/Model/rekap.dart';
import 'package:Monitoring/Model/ServiceRekap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MonRekap extends StatefulWidget {
MonRekap():super();
final String title = 'Monitoring Rekap';

  @override
  _MonRekapState createState() => _MonRekapState();
}

class _MonRekapState extends State<MonRekap> {
  List<Rekap> _rekaps;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaPengadaansController;
  TextEditingController _totalRekapController;
  Rekap _selectedRekap;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _rekaps = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaPengadaansController = TextEditingController();
    _totalRekapController = TextEditingController();
  }
  // _showSnackBar(context,message){
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);

  // }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  // _createRekap() {
  //   _showProgress('Creating Table...');
  //   ServiceRekap.createTable().then((result){
  //     if  ('success' == result){
  //       _showSnackBar(context, result);

  //     }
  //   });
  // }
 _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
   _addRekap() {
       if (_namaPengadaansController.text.trim().isEmpty ||
        _totalRekapController.text.trim().isEmpty
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Rekap...');
      ServiceRekap.addRekap(_namaPengadaansController.text,  _totalRekapController.text).then((result){ 
         if  ('success' == result){
           _getRekap();//
         }
         _clearValue();

     });

  }
_getRekap() {
  _showProgress('Loading Rekap...');
    ServiceRekap.getRekap().then((rekaps) {
      setState(() {
        _rekaps = rekaps;
      });
      _showProgress(widget.title);
      print("Length: ${rekaps.length}");
    });
  }



  _updateRekap(Rekap rekap) {
    _showProgress('Updating Ekatalog...');
    ServiceRekap.updateRekap(
            rekap.id, _namaPengadaansController.text,  _totalRekapController.text) 
        .then((result) {
      if ('success' == result) {
        setState(() {
          _isUpdating = false;
        });
       _namaPengadaansController.text = '';
        _totalRekapController.text = '';


      }
    });

  }
  _deleteRekap(Rekap rekap) {
    _showProgress('Deleting Employee...');
    ServiceRekap.deleteRekap(rekap.id).then((result) {
      if ('success' == result) {
        setState(() {
          _rekaps.remove(rekap);
        });
        _getRekap();
      }
    });
  }
   _showValues(Rekap rekap) {
    _namaPengadaansController.text = rekap.namaPengadaans;
    _totalRekapController.text = rekap.totalPengadaan; 
    setState(() {
      _isUpdating = true;
    });
  }
  _clearValue(){
    _namaPengadaansController.text = '';
    _totalRekapController.text = '';
  }


SingleChildScrollView _databody(){
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [

         DataColumn(
          label: Text('Nama Pengadaan'),
        
        ),
         DataColumn(
          label: Text('Total Rekap'),
        
        ),
         DataColumn(
          label: Text('Hapus'),
        
        ),
      ],
      rows: _rekaps
      .map(
        (rekap) => DataRow(cells: [
          // DataCell(
          //   Text(rekap.id),
          //   onTap: (){
          //     _showValues(rekap);
          //     _selectedRekap = rekap;
          //   }
            
          //   ),
            DataCell(
            Text(rekap.namaPengadaans.toUpperCase()),
            onTap: (){
              _showValues(rekap);
              _selectedRekap = rekap;
            }
            ),
            DataCell(
            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(rekap.totalPengadaan)),
              ),
            onTap: (){
              _showValues(rekap);
              _selectedRekap = rekap;

            }
            ),
            DataCell(IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              _deleteRekap(rekap);
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
            //      _createRekap();
            //     }),
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getRekap();
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
                  controller: _namaPengadaansController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Pengadaan',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _totalRekapController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Total Rekap',

                  ),
                ),
              ),

              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateRekap(_selectedRekap);
                  },
                  ),
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValue();
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
              _addRekap();
          } ,
          child: Icon(Icons.add),
          ),
        );
  }
}

