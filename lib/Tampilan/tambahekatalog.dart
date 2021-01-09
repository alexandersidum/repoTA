import 'package:flutter/material.dart';
import 'package:Monitoring/Model/Ekatalog.dart';
import 'package:Monitoring/Model/ServiceEkatalog.dart';

class TambahEkatalog extends StatefulWidget {
  TambahEkatalog():super();
  final String title = 'Tambah Ekatalog';
  @override
  _TambahEkatalogState createState() => _TambahEkatalogState();
}

class _TambahEkatalogState extends State<TambahEkatalog> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaUnitController;
  TextEditingController _jumlahTransaksiController;
  TextEditingController _tanggalController;
  String _titleProgress;
  // Proses _selectedProses;
  var selectedYear;



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
    _jumlahTransaksiController = TextEditingController();
    _tanggalController = TextEditingController();
    
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
    _namaUnitController.text = '';
    _jumlahTransaksiController.text = '';
  }
  _addEkatalog() {
    //  print("berhasil");
       if (_namaUnitController.text.trim().isEmpty ||
        _jumlahTransaksiController.text.trim().isEmpty) {
        print("Empty fields");
       return;
       
    }
    _showProgress('Adding Ekatalog...');
      ServiceEkat.addEkatalog(_namaUnitController.text, selectedYear, _jumlahTransaksiController.text).then((result){ // controller integer
         if  ('success' == result){
           _showSnackBar(context, result);

         }
         _clearValue();

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
                  controller: _jumlahTransaksiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Jumlah Transaksi',

                  ),
                ),
              ),Padding(padding: EdgeInsets.all(20.0),
              child: DropdownButtonHideUnderline(
                
                      child: DropdownButton(
                        hint: Text("Tahun"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedYear,
                          items: Ekatalog.listYear
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                              
                            });
                          }),
                    ),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Ekatalog"),
                  onPressed: (){
                    _addEkatalog();
            
                  },)
                  ]
            )
        ],
        ),
    ));
  }
}