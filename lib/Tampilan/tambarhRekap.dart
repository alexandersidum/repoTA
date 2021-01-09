import 'package:flutter/material.dart';
import 'package:Monitoring/Model/rekap.dart';
import 'package:Monitoring/Model/ServiceRekap.dart';

class TambahRekap extends StatefulWidget {
TambahRekap():super();
  final String title = 'Tambah Rekap';

  @override
  _TambahRekapState createState() => _TambahRekapState();
}

class _TambahRekapState extends State<TambahRekap> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaPengadaansController;
  TextEditingController _totalRekapController;
  String _titleProgress;
  var selectedYear;



  @override
  void initState() {
    super.initState();  
    
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaPengadaansController = TextEditingController();
    _totalRekapController = TextEditingController();
    // _tanggalController = TextEditingController();
    
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
     _namaPengadaansController.text = '';
    _totalRekapController.text = '';
  }
   _addRekap() {
       if (_namaPengadaansController.text.trim().isEmpty ||
        _totalRekapController.text.trim().isEmpty
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Rekap...');
      ServiceRekap.addRekap(selectedYear,_namaPengadaansController.text,  _totalRekapController.text).then((result){ 
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
          title: Text(_titleProgress),
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(Icons.add),
          //       onPressed: () {
          //        _createRekap();
          //       }),
          //       IconButton(
          //       icon: Icon(Icons.refresh),
          //       onPressed: () {
          //         _getRekap();
          //       }),
          // ],
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
             Padding(padding: EdgeInsets.all(20.0),
              child: DropdownButtonHideUnderline(
                
                      child: DropdownButton(
                        hint: Text("Tahun"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedYear,
                          items: Rekap.listTahun
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
                  child: Text("Tambah Rekap"),
                  onPressed: (){
                    _addRekap();
            
                  },)
                  ]
            )

              
              
            ],
          ),
        ));
  }
}