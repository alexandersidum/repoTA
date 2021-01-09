import 'package:Monitoring/Model/rekap.dart';
import 'package:Monitoring/Model/ServiceRekap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Monitoring/Tampilan/monitoringrekap.dart';
import 'package:Monitoring/Tampilan/tambarhRekap.dart';

class UIRekap extends StatefulWidget {
  UIRekap():super();
  final String title = 'Rekap Pengadaan';
  @override
  _UIRekapState createState() => _UIRekapState();
}
  // List<DropdownMenuItem> dropDownMenu(Map input) {
  //   List<DropdownMenuItem> output = [];
  //   input.forEach((key, value) {
  //     output.add(DropdownMenuItem<int>(
  //       child: Text(value),
  //       value: key,
  //     ));
  //   });
  //   return output;
  // }

class _UIRekapState extends State<UIRekap> {
List<Rekap> _rekaps;
  List<Rekap> _filterRekap;
  GlobalKey<ScaffoldState> _scaffoldKey;
 String _titleProgress;
  bool onSearch = false;
  var searchYear;

  @override
  void initState() {
    super.initState();
    _getRekap();
    _rekaps = [];
    _filterRekap = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
  }
_showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
  _createRekap() {
    _showProgress('Creating Table...');
    ServiceRekap.createTable().then((result){
      if  ('success' == result){
        _showSnackBar(context, result);

      }
    });
  }
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Ditambahkan"),
    ));
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
  SingleChildScrollView _databody(){
  _filterRekap.forEach((Rekap e) { 
      print(e.id);
      print(e.namaPengadaans);
      print(e.totalPengadaan);
      print(e.tahun);

    });
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
     
      ],
      rows: _filterRekap
      .map(
        (rekap) => DataRow(cells: [
 
            DataCell(
            Text(rekap.namaPengadaans.toString()),
            
            ),
            DataCell(
            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(rekap.totalPengadaan)),
              ),

            ),
            
        ]

      )).toList(),
      ),
    ),
      

  );

}
Widget searchedYear(){
return
Padding( padding : EdgeInsets.all(20.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Year"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: searchYear,
                          items: Rekap.listTahun
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
  
    var initialList = _rekaps;
    if(onSearch){
      initialList = _filterRekap;
    }
    switch (searchYear) {
      case '2018':
        _filterRekap = initialList
            .where((element) => element.tahun
                .toLowerCase()
                .trim()
                .contains('2018'.toLowerCase()))
            .toList();
        break;
      case '2019':
        _filterRekap= initialList
            .where((element) => element.tahun
                .toLowerCase()
                .trim()
                .contains('2019'.toLowerCase()))
            .toList();
        break;
      case '2020':
        _filterRekap = initialList
            .where((element) => element.tahun
                .toLowerCase()
                .trim()
                .contains('2020'.toLowerCase()))
            .toList();
        break;
      case '2021':
        _filterRekap = initialList
            .where((element) =>
                element.tahun.toLowerCase().trim() ==
                ('2021'.toLowerCase())
                )
            .toList();
        break;
      default:
        _filterRekap = initialList;
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
                 _createRekap();
                }),
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getRekap();
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
                  child: Text("Tambah Rekap"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TambahRekap()));
            
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
                      builder: (context) => MonRekap()));
            
                  },)
                  ]
            )
              
        ])
          ),
        );
  }
}