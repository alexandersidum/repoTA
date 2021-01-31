import 'package:Monitoring/Komponen/datePicker.dart';
import 'package:Monitoring/Model/ServiceEntryUnit.dart';
import 'package:Monitoring/Model/ServiceSumberDana.dart';
import 'package:Monitoring/Model/UnitEntry.dart';
import 'package:Monitoring/Model/sumberDana.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:intl/intl.dart';



class MonAddPengadaan extends StatefulWidget {
  MonAddPengadaan():super();
  final String title = 'Tambah Pengadaan';

  @override
  _MonAddPengadaanState createState() => _MonAddPengadaanState();
}

class _MonAddPengadaanState extends State<MonAddPengadaan> {
  
  //  List<Proses> _prosess;
  // List<Proses> _filterProses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaUnitController;
  TextEditingController _namaPengadaanController; 
  List<Unit> _units ;
  List<SumberDana> _sumberDana ;
  
  TextEditingController _namaPenyediaController;
  // 
  TextEditingController _paguPengadaanController;
  TextEditingController _hpsPengadaanController;
  TextEditingController _nilaiKontrakController;
  TextEditingController _volumeController;
  // TextEditingController _sumberDanaController;
  TextEditingController _sisaAnggaranController;
  TextEditingController _usulanStatusController;
  // TextEditingController _tahapController;
 String _titleProgress;
  // Proses _selectedProses;
  var selectedMethod;
  // var selectedJenisPengadaan;
  var selectedUnit;
  var selectedSumberDana;

  String pilihTanggal1,labelText1;
  DateTime tgl1 = DateTime.now();
   final TextStyle valueStyle1 = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate1(BuildContext context) async{
  final DateTime picked1 = await showDatePicker(context: context,
   initialDate: tgl1, firstDate: DateTime(1990), lastDate: DateTime(2099));
  if (picked1 != null && picked1 != tgl1){
    setState(() {
      tgl1 = picked1;
      pilihTanggal1 = new DateFormat.yMd().format(tgl1);

    });
   
  }
}
String pilihTanggal2,labelText2;
  DateTime tgl2 = DateTime.now();
   final TextStyle valueStyle2 = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate2(BuildContext context) async{
  final DateTime picked2 = await showDatePicker(context: context,
   initialDate: tgl2, firstDate: DateTime(1990), lastDate: DateTime(2099));
  if (picked2 != null && picked2 != tgl2){
    setState(() {
      tgl2 = picked2;
      pilihTanggal2 = new DateFormat.yMd().format(tgl2);

    });
   
  }
}
String pilihTanggal3,labelText3;
  DateTime tgl3 = DateTime.now();
   final TextStyle valueStyle3 = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate3(BuildContext context) async{
  final DateTime picked3 = await showDatePicker(context: context,
   initialDate: tgl3, firstDate: DateTime(1990), lastDate: DateTime(2099));
  if (picked3 != null && picked3 != tgl3){
    setState(() {
      tgl3 = picked3;
      pilihTanggal3 = new DateFormat.yMd().format(tgl3);

    });
   
  }
}
String pilihTanggal4,labelText4;
  DateTime tgl4 = DateTime.now();
   final TextStyle valueStyle4 = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate4(BuildContext context) async{
  final DateTime picked4 = await showDatePicker(context: context,
   initialDate: tgl4, firstDate: DateTime(1990), lastDate: DateTime(2099));
  if (picked4 != null && picked4 != tgl4){
    setState(() {
      tgl4 = picked4;
      pilihTanggal4 = new DateFormat.yMd().format(tgl4);

    });
   
  }
}

  @override
  void initState() {
    super.initState();  
   
   
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    listUnit();
    listSumberDana();
    _namaUnitController = TextEditingController();
    _namaPengadaanController = TextEditingController();
    _volumeController = TextEditingController();
    // _sumberDanaController = TextEditingController();
    _namaPenyediaController = TextEditingController();
    _paguPengadaanController = TextEditingController();
    _hpsPengadaanController = TextEditingController();
    _nilaiKontrakController = TextEditingController();
    _sisaAnggaranController = TextEditingController();
    _usulanStatusController = TextEditingController();
    // _tahapController = TextEditingController();

  }
Future<void> listUnit()async{
  await ServiceUnit.getUnit((List<Unit> list){
      setState(() {
          _units = list;  
        });
  }
  );
}
Future<void> listSumberDana()async{
  await ServiceSumberDana.getDana((List<SumberDana> list){
      setState(() {
          _sumberDana = list;  
        });
  }
  );
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
  _clearValues(){
        _namaUnitController.text = '';  
        _namaPengadaanController.text = '';
        _paguPengadaanController.text = '';
        // _usulanStatusController.text = '';
        _volumeController.text = '';
        
  }
   _addProsesDp() async {
       if (_namaUnitController.text.trim().isEmpty ||
          _namaPengadaanController.text.trim().isEmpty ||
           _paguPengadaanController.text.trim().isEmpty ||
           _volumeController.text.trim().isEmpty
          //  _usulanStatusController.text.trim().isEmpty 
           
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Proses...');
    var sisaAnggaran = int.parse(_paguPengadaanController.text);
    if(_paguPengadaanController.text.isNotEmpty){
      sisaAnggaran = int.parse(_paguPengadaanController.text);
    }
     await ServicePengadaan.addProses(selectedUnit,_namaPengadaanController.text, _volumeController.text, selectedSumberDana, tgl1.toString(), tgl2.toString(), tgl3.toString(),tgl4.toString(), _namaPenyediaController.text, selectedMethod, _paguPengadaanController.text, _hpsPengadaanController.text, _nilaiKontrakController.text, sisaAnggaran.toString(), _usulanStatusController.text).then((result)
      {
         if  ('success' == result){
           }
           print(result);
         _showSnackBar(context, result);
         _clearValues();
     });
   }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(_titleProgress),) ,
    body: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: CustomScrollView(
            slivers: [
              
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 16),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                       
                DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Nama Unit"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedUnit,
                          items: _units
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.unit),
                                    value: e.unit,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                              
                            });
                          }),
                    ),
                 SizedBox(
                    height: 10,
                  ), Text(
                  'Nama Pengadaan',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              TextField(
                  controller: _namaPengadaanController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Pengadaan',

                  ),
                ),
                  SizedBox(
                    height: 10,
                  ), Text(
                  'Metode Pengadaan',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Metode"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedMethod,
                          items: Proses.listMethod
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMethod = value;
                              
                            });
                          }),
                    ),
                             SizedBox(
                    height: 10,
                  ), Text(
                  'Pagu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),            
                TextField(
                        controller: _paguPengadaanController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(hintText: 'Pagu',

                  ),
                ),
                    SizedBox(
                    height: 10,
                  ), Text(
                  'Sumber Dana',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                   DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Sumber Dana"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedSumberDana,
                          items: _sumberDana
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.sumberDana),
                                    value: e.sumberDana,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSumberDana = value;
                              
                            });
                          }),
                    ),
                    SizedBox(
                    height: 10,
                  ), Text(
                  'volume',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  TextField(
                        controller: _volumeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(hintText: 'Volume',

                  ),
                ),
                    SizedBox(
                    height: 10,
                  ),
                  Text(
                  'Tanggal Pemilihan Awal',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                    Padding(padding: EdgeInsets.all(5.0),
              child: DateDropDown(
              labelText: labelText1,
              valueText: new DateFormat.yMd().format(tgl1),
              valueStyle: valueStyle1,
              onPressed: () {
                _selectedDate1(context);
              },
            ),),  
                     SizedBox(
                    height: 10,
                  ),
                  Text(
                  'Tanggal Pemilihan Akhir',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                  Padding(padding: EdgeInsets.all(5.0),
              child: DateDropDown(
              labelText: labelText2,
              valueText: new DateFormat.yMd().format(tgl2),
              valueStyle: valueStyle2,
              onPressed: () {
                _selectedDate2(context);
              },
            ),),  
                     SizedBox(
                    height: 10,
                  ),
                  Text(
                  'Tanggal Pekerjaan Awal',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Padding(padding: EdgeInsets.all(5.0),
              child: DateDropDown(
              labelText: labelText3,
              valueText: new DateFormat.yMd().format(tgl3),
              valueStyle: valueStyle3,
              onPressed: () {
                _selectedDate3(context);
              },
            ),),  
                     SizedBox(
                    height: 10,
                  ),
                  Text(
                  'Tanggal Pekerjaan Akhir',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Padding(padding: EdgeInsets.all(5.0),
              child: DateDropDown(
              labelText: labelText4,
              valueText: new DateFormat.yMd().format(tgl4),
              valueStyle: valueStyle4,
              onPressed: () {
                _selectedDate4(context);
              },
            ),),  
            
                SizedBox(
                    height: 20,
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Pengadaan"),
                  onPressed: (){
                    _addProsesDp();
            
                  },)
                  ]
                
                  )]
                )
                ),
              )
            ],
          ),
    )
    );
  }
}