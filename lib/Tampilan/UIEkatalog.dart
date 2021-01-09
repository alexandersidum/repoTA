// import 'dart:async';
import 'package:Monitoring/Tampilan/monitoringekatalog.dart';
import 'package:Monitoring/Tampilan/tambahekatalog.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/Ekatalog.dart';
import 'package:Monitoring/Model/ServiceEkatalog.dart';
import 'package:intl/intl.dart';

class UIEkatalog extends StatefulWidget {
  UIEkatalog():super();
  final String title = 'Monitoring Ekatalog';
  @override
  _UIEkatalogState createState() => _UIEkatalogState();
}

class _UIEkatalogState extends State<UIEkatalog> {

  List<Ekatalog> _ekatalogs;
  List<Ekatalog> _filterEkatalog;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  bool onSearch = false;
  // String searchedYear;
  // var selectedYear;
  var searchYear ;

  List<DropdownMenuItem> dropDownMenu(Map input) {
    List<DropdownMenuItem> output = [];
    input.forEach((key, value) {
      output.add(DropdownMenuItem<int>(
        child: Text(value),
        value: key,
      ));
    });
    return output;
  }
  @override
  void initState() {
    super.initState();
    _getEkatalog();
    _ekatalogs = [];
    _filterEkatalog =[];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); 
  }
_showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
   _createEkatalog() {
    _showProgress('Creating Table...');
    ServiceEkat.createTable1().then((result){
      if  ('success' == result){
        _showSnackBar(context, result);

      }
    });
  }
   _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  _getEkatalog() {
  _showProgress('Loading Ekatalog...');
    ServiceEkat.getEkatalog().then((List<Ekatalog> listEkatalog) {
      if (listEkatalog.isNotEmpty) {
        setState(() {
          _ekatalogs = listEkatalog;
          _filterEkatalog = listEkatalog;
        });
        _showProgress(widget.title);
        print("Length: ${listEkatalog.length}");
      }
    });
  }
  SingleChildScrollView _databody(){
  _filterEkatalog.forEach((Ekatalog e) { 
      print(e.id);
      print(e.namaUnit);
      print(e.jumlahTransaksi);
      print(e.tanggal);

    });
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
  
         DataColumn(
          label: Text('Nama Unit'),
        
        ),
         DataColumn(
          label: Text('Jumlah Transaksi'),
        
        )
        
      ],
      rows: _filterEkatalog
      .map(
        (ekatalog) => 
        DataRow(cells: [
          
  
            DataCell(
            Text(ekatalog.namaUnit.toString()),
           
            ),
            DataCell(
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(ekatalog.jumlahTransaksi)),),
            
            ),
           
        ]

      )).toList(),
      ),
    ),
      

  );
}
Widget searchedYear(){
return
Padding( padding : EdgeInsets.all(10.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Year"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: searchYear,
                          items: Ekatalog.listYear
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              searchYear = value;
                              
                            });
                          }),
                    )
                    );

}

void filterYear() {
  
    var initialList = _ekatalogs;
    if(onSearch){
      initialList = _filterEkatalog;
    }
    switch (searchYear) {
      case '2018':
        _filterEkatalog = initialList
            .where((element) => element.tanggal
                .toLowerCase()
                .trim()
                .contains('2018'.toLowerCase()))
            .toList();
        break;
      case '2019':
        _filterEkatalog= initialList
            .where((element) => element.tanggal
                .toLowerCase()
                .trim()
                .contains('2019'.toLowerCase()))
            .toList();
        break;
      case '2020':
        _filterEkatalog = initialList
            .where((element) => element.tanggal
                .toLowerCase()
                .trim()
                .contains('2020'.toLowerCase()))
            .toList();
        break;
      case '2021':
        _filterEkatalog = initialList
            .where((element) =>
                element.tanggal.toLowerCase().trim() ==
                ('2021'.toLowerCase())
                )
            .toList();
        break;
      default:
        _filterEkatalog = initialList;
    }
  }

  @override
  Widget build(BuildContext context) {
    filterYear();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                 _createEkatalog();
                }),
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getEkatalog();
                }),
          ],
        ),
         body:Container(
          child: Column(
            children : [
            searchedYear(),
              
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Ekatalog"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TambahEkatalog()));
            
                  },)
                  ,
                  SizedBox(
          width: 10,
        )
                  ,  RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonEkatalog()));
            
                  },)
                  ]
            )
              
        ])
          ),

        );
  }
}