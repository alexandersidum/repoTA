import 'dart:async';
import 'package:Monitoring/Model/Akun.dart';
import 'package:Monitoring/Model/UsulanStatus.dart';
import 'package:Monitoring/Model/ServiceUsulan.dart';
import 'package:Monitoring/Tampilan/monitoringTambahPengadaan.dart';
import 'package:Monitoring/authent.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'monitoringpengadaan.dart';


class MonitoringPUI extends StatefulWidget {
MonitoringPUI():super();
final String title = 'Monitoring Pengadaan';

  @override
  _MonitoringPUIState createState() => _MonitoringPUIState();
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

class _MonitoringPUIState extends State<MonitoringPUI> {
  List<UsulanStatus> _status;
  List<Proses> _prosess;
  List<Proses> _filterProses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // Proses _selectedProses;
  String _titleProgress;
  final _debouncer = Debouncerr(milliseconds: 1000);
  // var selectedMethod;
  var searchMethod;
  bool onSearch = false;
  String searchedText;
  var searchStatus;

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
    var roles = Provider.of<Auth>(context,listen:false).getUserInfo.getRole();
     listStat(roles);
    _getProses();
    _prosess = [];
    _status = [];
    _filterProses =[];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); 

  }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
  _createProses() {
    _showProgress('Creating Table...');
    ServicePengadaan.createTable().then((result){
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
  Future<void>filter()async{
  await ServicePengadaan.getFilter(usulanStatus: searchStatus, callback : (a){
   setState(() {
     _filterProses = a??[];
   });
  });}
  Future<void>listStat(roles)async{
  print("atas role");

print("bawah role");
  await ServiceUsulan.getUsulan(role: roles,callback : (a){
   setState(() {
     _status = a??[];
   });
   print("dalam callback");
  }

  );
}

SingleChildScrollView _databody(){


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
          label: Text('Nilai Kontrak'),
        
        ),
         
        DataColumn(
          label: Text('Sisa Anggaran'),
        
        ),
         DataColumn(
          label: Text('Status'),
        
        ),
      ],
      rows: _filterProses.map(
        (proses){
    return DataRow(cells: [
             DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            ),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
            ),
            DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
           
          ),
            DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            ),
            DataCell(
            Text(proses.metodePengadaan.toString()),
            ),
            DataCell(
            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
            ),),    
            ),
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
                        , ),
            DataCell(
                        proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),),): 
                            Text(
                          "0"
                          )
                        ,
           ),
            
            DataCell(
             proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,
           ),
            DataCell(
            Text(proses.usulanStatus.toString()),
          ),         
        ]
      );}).toList(),
      ),
    ),
  );
}

// searchField() {
//     return Padding(
//       padding: EdgeInsets.all(20.0),
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(5.0),
//           hintText: 'Filter by Status',
//         ),
//         onChanged: (string) {
//           _debouncer.run(() {
            
//             searchedText = string;
//             if (string != null || string != '') {
//               onSearch = true;
//               _filterProses = _prosess
//                 .where((u) => (u.usulanStatus
//                     .toLowerCase()
//                     .contains(string.toLowerCase())))
//                 .toList();
//             }else{
//               onSearch = false;
//             }
//             setState(() {});
//           });
//         },
//       ),
//     );
//   }
Widget searchFilter(){
return Padding( padding : EdgeInsets.all(10.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Filter Metode"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: searchStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              searchStatus = value;
                              filter();
                            });
                          }),
                    )
                    );

}
Widget searchedMethod(){
return Padding( padding : EdgeInsets.all(20.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Metode Pengadaan"),
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
                    ));

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
                ('Tender'.toLowerCase()))
            .toList();
        break;
      default:
        _filterProses = initialList;
    }
  }

  @override
  Widget build(BuildContext context) {
  Akun account = Provider.of<Auth>(context).getUserInfo;
    int role = Provider.of<Auth>(context).getUserInfo.role;  
      filterMethod();
  if (account.role == 1) {
       return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _createProses();
                }),
            
                IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getProses();
                }),

          ]
          ),
          body:Container(
          child: roleMenuList(role, context, account),
          ),        
          );
          }else{
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
          ]
          ),
          body:Container(
          child: roleMenuList(role, context, account),
          ),        
          );
          }        
  }
Widget roleMenuList(int role, BuildContext context, Akun account) {
  switch (role) {
      case 0:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonAddPengadaan()));
            
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
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )
              
        ]);
        break;
      case 1:
        return Column(
            children : [
            searchedMethod(),
            searchFilter(),
              // searchField(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonAddPengadaan()));            
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
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )
              
        ]);
        break;
      case 2:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),]);
        break;
      case 3:
        return Column(
            children : [
            searchedMethod(),
            searchFilter(),
              // searchField(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )      
        ]
        )
        ;
        break;
      case 4:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )      
        ]
        );
        break;
      case 5:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )      
        ]
        );
        break;
      case 6:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )      
        ]
        );
        break;
      case 7:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Update Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )      
        ]
        );
        break;
      default:
        return Column(
            children : [
            searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Tambah Pengadaan"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonAddPengadaan()));
            
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
                      builder: (context) => MonPengadaan()));
            
                  },)
                  ]
            )
              
        ]);
    }
  }
}

