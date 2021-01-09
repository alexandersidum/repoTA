
import 'dart:async';

import 'package:Monitoring/Komponen/datePicker.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';


class MonPengadaan extends StatefulWidget {
MonPengadaan():super();
final String title = 'Monitoring Pengadaan';

  @override
  _MonPengadaanState createState() => _MonPengadaanState();
}

class Debouncerr{
    final int milliseconds;
    VoidCallback action;
    Timer _timer;

    Debouncerr({this.milliseconds});

    run(VoidCallback action){
      if (null != _timer){
        _timer.cancel();

      }
      _timer = Timer(Duration(milliseconds: milliseconds), action);
    }
}


class _MonPengadaanState extends State<MonPengadaan> {
  List<Proses> _prosess;
  List<Proses> _filterProses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaUnitController;
  TextEditingController _namaPengadaanController;
  TextEditingController _namaPenyediaController;
  TextEditingController _nilaiKontrakController;
  TextEditingController _paguPengadaanController;
  TextEditingController _hpsPengadaanController;
  // TextEditingController _tanggalPengadaanController;
  TextEditingController _usulanStatusController;
  Proses _selectedProses;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncerr(milliseconds: 1000);
  var selectedMethod;
  var searchMethod;
  bool onSearch = false;
  String searchedText;
  


  String pilihTanggal,labelText;
  DateTime tgl = DateTime.now();
   final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async{
  final DateTime picked = await showDatePicker(context: context,
   initialDate: tgl, firstDate: DateTime(1990), lastDate: DateTime(2099));
  if (picked != null && picked != tgl){
    setState(() {
      tgl = picked;
      pilihTanggal = new DateFormat.yMd().format(tgl);

    });
   
  }
}
// List<DropdownMenuItem> dropDownMenu(Map input) {
//     List<DropdownMenuItem> output = [];
//     input.forEach((key, value) {
//       output.add(DropdownMenuItem<int>(
//         child: Text(value),
//         value: key,
//       ));
//     });
//     return output;
//   }

  @override
  void initState() {
    super.initState();
    _getProses();
    _prosess = [];
    _isUpdating = false;
    _filterProses =[];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaUnitController = TextEditingController();
    _namaPengadaanController = TextEditingController();
    _namaPenyediaController = TextEditingController();
    _paguPengadaanController = TextEditingController();
    _hpsPengadaanController = TextEditingController();
    _nilaiKontrakController = TextEditingController();
    _usulanStatusController = TextEditingController();
  }

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }


 _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Ditambahkan"),
    ));
  }
   
_getProses() {
    _showProgress('Loading Pengadaan...');
    ServicePengadaan.getProses((List<Proses> listProses) {
      if (listProses.isNotEmpty) {
        setState(() {
          _prosess = listProses;
          _filterProses = listProses;
        });
        _showProgress(widget.title);
        print("Length: ${listProses.length}");
      }
    });
  }



 
    _updateProsesPPK(Proses proses) async {
    _showProgress('Updating Ekatalog...');
    // var sisaAnggaran = int.parse(proses.paguPengadaan) - int.parse(_nilaiKontrakController.text);
    var sisaAnggaran = 0;
    if(proses.paguPengadaan.isNotEmpty&& proses.nilaiKontrak.isNotEmpty){
      sisaAnggaran = int.parse(proses.paguPengadaan) - int.parse(_nilaiKontrakController.text);
    }
    await ServicePengadaan.updateProsesPPK(
            proses.id, _namaUnitController.text, _namaPengadaanController.text, tgl.toString(), _namaPenyediaController.text,  selectedMethod, _paguPengadaanController.text, _hpsPengadaanController.text, _nilaiKontrakController.text, sisaAnggaran.toString(), _usulanStatusController.text) 
        .then((result) {
      if ('success' == result) {
        _showSnackBar(context, result);
        _getProses();
        setState(() {
          _isUpdating = false;
        });
        
        
         _paguPengadaanController.text = '';
        _hpsPengadaanController.text = '';
        
        _usulanStatusController.text = '';
      }
    });

  }
  
  void _deleteProses(Proses proses) {
    _showProgress('Deleting Employee...');
    ServicePengadaan.deleteProses(proses.id).then((result) {
      if ('success' == result) {
        setState(() {
          _prosess.remove(proses);
        });
        _getProses();
      }
    });
  }

   _showValues(Proses proses) {//memunculkan value yang nantinya ditunjukkan
   _namaUnitController.text = proses.namaUnit;
    _namaPengadaanController.text = proses.namaPengadaan;
    _namaPenyediaController.text = proses.namaPenyedia;
    selectedMethod = proses.metodePengadaan;
    _paguPengadaanController.text = proses.paguPengadaan;
    _hpsPengadaanController.text = proses.hpsPengadaan;
    _nilaiKontrakController.text = proses.nilaiKontrak;
    
    _usulanStatusController.text = proses.usulanStatus;
    

    setState(() {
      _isUpdating = true;
    });
  }
 void _clearValues(){
      
        _namaPengadaanController.text = '';
        _namaPenyediaController.text = '';   
        _paguPengadaanController.text = '';
        _hpsPengadaanController.text = '';
        _nilaiKontrakController.text = '';
        _usulanStatusController.text = '';
        
  }


SingleChildScrollView _databody(){


  _filterProses.forEach((Proses e) { 
      print(e.id);
      print(e.namaUnit);
      print(e.metodePengadaan);
      print(e.namaPengadaan);
      print(e.tanggalPengadaan);
      print(e.namaPenyedia);
      print(e.paguPengadaan);
      print(e.hpsPengadaan);
      print(e.nilaiKontrak);
      print(e.sisaAnggaran);
      print(e.usulanStatus);
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
          label: Text('Nama Pengadaan'),
        
        ),
         DataColumn(
          label: Text('Tanggal Pengadaan'),
        
        ),
        DataColumn(
          label: Text('Nama Penyedia'),
        
        ),
         DataColumn(
          label: Text('Metode Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

        ),
        DataColumn(
          label: Text('Sisa Anggaran'),
        
        ),
         DataColumn(
          label: Text('Status'),
        
        ),
         DataColumn(
          label: Text('Hapus'),
        
        ),
      ],
      rows: _filterProses.map(
        (proses){
 var tanggal = "";
if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
print(proses.tanggalPengadaan);
}
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValues(proses);
              _selectedProses = proses;
          }),
          DataCell(
              proses.tanggalPengadaan.isNotEmpty && proses.tanggalPengadaan!=null?
            Text(tanggal):
            Text(""),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.metodePengadaan.toString()),
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
          }),
            DataCell(
                      proses.hpsPengadaan.isNotEmpty && proses.hpsPengadaan != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.hpsPengadaan),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              _deleteProses(proses);
            },
            ))
        ]

      );}).toList(),
      ),
    ),
      

  );

}

searchField() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filter by Status',
        ),
        onChanged: (string) {
          _debouncer.run(() {
            
            searchedText = string;
            if (string != null || string != '') {
              onSearch = true;
              _filterProses = _prosess
                .where((u) => (u.usulanStatus
                    .toLowerCase()
                    .contains(string.toLowerCase())))
                .toList();
            }else{
              onSearch = false;
            }
            setState(() {});
          });
        },
      ),
    );
  }
Widget searchedMethod(){
return Padding( padding : EdgeInsets.all(10.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Filter Metode"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: searchMethod,
                          items: Proses.listMethod
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              searchMethod = value;
                              
                            });
                          }),
                    )
                    );

}

void filterMethod() {
  print(searchMethod);
    var initialList = _prosess;
    if(onSearch){
      initialList = _filterProses;
    }
    switch (searchMethod) {
      case 'Pengadaan Langsung':
        _filterProses = initialList
            .where((element) => element.metodePengadaan
                .toLowerCase()
                .trim()
                .contains('Pengadaan Langsung'.toLowerCase()))
            .toList();
        break;
      case 'Penunjukan Langsung':
        _filterProses = initialList
            .where((element) => element.metodePengadaan
                .toLowerCase()
                .trim()
                .contains('Penunjukan Langsung'.toLowerCase()))
            .toList();
        break;
      case 'Tender Cepat':
        _filterProses = initialList
            .where((element) => element.metodePengadaan
                .toLowerCase()
                .trim()
                .contains('Tender Cepat'.toLowerCase()))
            .toList();
        break;
      case 'Tender':
        _filterProses = initialList
            .where((element) =>
                element.metodePengadaan.toLowerCase().trim() ==
                ('Tender'.toLowerCase())
                )
            .toList();
        break;
      default:
        _filterProses = initialList;
    }
  }
  @override
  Widget build(BuildContext context) {
    filterMethod();
       return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          actions: <Widget>[
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getProses();
                }),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _namaUnitController,
              //     decoration: InputDecoration.collapsed(hintText: 'Nama Unit',

              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _namaPengadaanController,
              //     decoration: InputDecoration.collapsed(hintText: 'Nama Pengadaan',

              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _namaPenyediaController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Penyedia',

                  ),
                ),
              ),
  
              
              
              // DropdownButtonHideUnderline(
              //         child: DropdownButton(
              //           hint: Text("      Metode"),
              //             isExpanded: true,
              //             dropdownColor: Colors.white,
              //             value: selectedMethod,
              //             items: Proses.listMethod
              //                 .map((e) => DropdownMenuItem<String>(
              //                       child: Text(e),
              //                       value: e,
              //                     ))
              //                 .toList(),
              //             onChanged: (value) {
              //               setState(() {
              //                 selectedMethod = value;
                              
              //               });
              //             }),
              //       ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _paguPengadaanController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration.collapsed(hintText: 'Pagu',

              //     ),
              //   ),
              // ),
              //  Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _hpsPengadaanController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration.collapsed(hintText: 'HPS',

              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _nilaiKontrakController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration.collapsed(hintText: 'Nilai Kontrak',

              //     ),
              //   ),
              // ),
            Padding(padding: EdgeInsets.all(10.0),
             child: DateDropDown(
              labelText: labelText,
              valueText: new DateFormat.yMd().format(tgl),
              valueStyle: valueStyle,
              onPressed: () {
                _selectedDate(context);
              },
            ),),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _usulanStatusController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Status',

                  ),
                ),
              ),



              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
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
              searchedMethod(),
              searchField(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          ),
        ),
         
        );
  }
}

