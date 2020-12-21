import 'package:flutter/material.dart';
import 'package:Monitoring/Model/Ekatalog.dart';
import 'package:Monitoring/Model/ServiceEkatalog.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MonEkatalog extends StatefulWidget {
  MonEkatalog() : super();
  final String title = 'Monitoring Ekatalog';

  @override
  _MonEkatalogState createState() => _MonEkatalogState();
}

class _MonEkatalogState extends State<MonEkatalog> {
  List<Ekatalog> _ekatalogs;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaUnitController;
  TextEditingController _jumlahTransaksiController;
  Ekatalog _selectedEkatalog;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _ekatalogs = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaUnitController = TextEditingController();
    _jumlahTransaksiController = TextEditingController();
  }
  // _showSnackBar(context,message){
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);

  // }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  // _createEkatalog() {
  //   // print("berhasil");
  //   _showProgress('Creating Table...');
  //   ServiceEkat.createTable1().then((result){
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
   _addEkatalog() {
    //  print("berhasil");
       if (_namaUnitController.text.trim().isEmpty ||
        _jumlahTransaksiController.text.trim().isEmpty) {
        print("Empty fields");
       return;
       
    }
    _showProgress('Adding Ekatalog...');
      ServiceEkat.addEkatalog(_namaUnitController.text, _jumlahTransaksiController.text).then((result){ // controller integer
         if  ('success' == result){
           _getEkatalog();//
         }
         _clearValue();

     });

  }
_getEkatalog() {
  _showProgress('Loading Ekatalog...');
    ServiceEkat.getEkatalog().then((ekatalogs) {
      setState(() {
        _ekatalogs = ekatalogs;
      });
      _showProgress(widget.title);
      print("Length: ${ekatalogs.length}");
    });
  }



  _updateEkatalog(Ekatalog ekatalog) {
    _showProgress('Updating Ekatalog...');
    ServiceEkat.updateEkatalog(
            ekatalog.id, _namaUnitController.text, _jumlahTransaksiController.text) //controller integer
        .then((result) {
      if ('success' == result) {
        setState(() {
          _isUpdating = false;
        });
        _namaUnitController.text = '';
        _jumlahTransaksiController.text = '';
      }
    });

  }
  _deleteEkatalog(Ekatalog ekatalog) {
    _showProgress('Deleting Employee...');
    ServiceEkat.deleteEkatalog(ekatalog.id).then((result) {
      if ('success' == result) {
        setState(() {
          _ekatalogs.remove(ekatalog);
        });
        _getEkatalog();
      }
    });
  }
   _showValues(Ekatalog ekatalog) {
    _namaUnitController.text = ekatalog.namaUnit;
    _jumlahTransaksiController.text = ekatalog.jumlahTransaksi; 
    setState(() {
      _isUpdating = true;
    });
  }
  _clearValue(){
    _namaUnitController.text = '';
    _jumlahTransaksiController.text = '';
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
          label: Text('Nama Unit'),
        
        ),
         DataColumn(
          label: Text('Jumlah Transaksi'),
        
        ),
         DataColumn(
          label: Text('Hapus'),
        
        ),
      ],
      rows: _ekatalogs
      .map(
        (ekatalog) => 
        DataRow(cells: [
          
        //   DataCell(
        //     Container(
        //     width: 10,
        //     child : Text(ekatalog.id),
            
            
        // )),
            DataCell(
            Text(ekatalog.namaUnit.toString()),
            onTap: (){
              _showValues(ekatalog);
              _selectedEkatalog = ekatalog;
            }
            ),
            DataCell(
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(ekatalog.jumlahTransaksi)),),
            onTap: (){
              _showValues(ekatalog);
              _selectedEkatalog = ekatalog;
            }
            ),
            DataCell(IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              _deleteEkatalog(ekatalog);
            },
            ))
        ]

      )).toList(),
      ),
    ),
      

  );

}




  //UI
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
            //      _createEkatalog();
            //     }),
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getEkatalog();
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
                  controller: _namaUnitController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Unit',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                   inputFormatters: <TextInputFormatter>[
        // ignore: deprecated_member_use
        WhitelistingTextInputFormatter.digitsOnly
    ],
                  controller: _jumlahTransaksiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Jumlah Transaksi',

                  ),
                ),
              ),

              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateEkatalog(_selectedEkatalog);
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
              _addEkatalog();
          } ,
          child: Icon(Icons.add),
          ),
        );
  }
}
