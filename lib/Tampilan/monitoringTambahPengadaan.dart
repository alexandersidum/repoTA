import 'package:flutter/material.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';

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
  TextEditingController _namaPenyediaController;
  // 
  TextEditingController _paguPengadaanController;
  TextEditingController _hpsPengadaanController;
  TextEditingController _nilaiKontrakController;
  TextEditingController _usulanStatusController;
 String _titleProgress;
  // Proses _selectedProses;
  var selectedMethod;

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
        _usulanStatusController.text = '';
        
  }
   _addProsesDp() {
       if (_namaUnitController.text.trim().isEmpty ||
          _namaPengadaanController.text.trim().isEmpty ||
           _paguPengadaanController.text.trim().isEmpty ||
           _usulanStatusController.text.trim().isEmpty 
           
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Proses...');
      ServicePengadaan.addProses(_namaUnitController.text,_namaPengadaanController.text, _namaPenyediaController.text,  selectedMethod, _paguPengadaanController.text, _hpsPengadaanController.text, _nilaiKontrakController.text, _usulanStatusController.text).then((result)
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(_titleProgress),) ,
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _namaUnitController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Unit',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _namaPengadaanController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Pengadaan',

                  ),
                ),
              ),Padding(padding: EdgeInsets.all(20.0),
              child: DropdownButtonHideUnderline(
                
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
                    ),
                  Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                  controller: _paguPengadaanController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Pagu',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _usulanStatusController,
                  decoration: InputDecoration.collapsed(hintText: 'Status',

                  ),
                ),
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
            )
        ],
        ),
    ));
  }
}