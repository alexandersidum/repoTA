import 'dart:async';
import 'package:Monitoring/Model/Akun.dart';
import 'package:Monitoring/Tampilan/monitoringTambahPengadaan.dart';
import 'package:Monitoring/authent.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'monitoringpengadaan.dart';


class UsulanUIBaru extends StatefulWidget {
UsulanUIBaru({Key key}) : super(key: key);
final String title = 'Usulan Unit';

  @override
  _UsulanUIBaruState createState() => _UsulanUIBaruState();
}


class _UsulanUIBaruState extends State<UsulanUIBaru> {
  List<Proses> _prosess;
  List<Proses> _filterProses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // Proses _selectedProses;
  String _titleProgress;
  // final _debouncer = Debouncerr(milliseconds: 1000);
  // var selectedMethod;
  var searchMethod;
  bool onSearch = false;
  String searchedText;

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
    getrekaps();
    _getProses();
    _prosess = [];
    _filterProses =[];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); 

  }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
  // // _createProses() {
  // //   _showProgress('Creating Table...');
  // //   ServicePengadaan.createTable().then((result){
  // //     if  ('success' == result){
  // //       _showSnackBar(context, result);

  // //     }
  // //   });
  // // }
  // _showSnackBar(context, message) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }
 Future<void> getrekaps()async {

 await ServicePengadaan.getRekapPengadaan(bulan: "September", tahun: "2025", metodePengadaan: "Tender Cepat", callback : (a){
   });
 
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

SingleChildScrollView _databody(){


  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
         DataColumn(
          label: Text('No'),
        
        ),
         DataColumn(
          label: Text('Nama Unit'),
        
        ),
         DataColumn(
          label: Text('Nama Pengadaan'),
        
        ),
          DataColumn(
          label: Text('Volume'),
        
        ),
          DataColumn(
          label: Text('Sumber Dana'),
        
        ),
          DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('Metode Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pemilihan Awal'),
        
        ),
        DataColumn(
          label: Text('Pemilihan Akhir'),
        
        ),
        DataColumn(
          label: Text('Pekerjaan Awal'),
        
        ),
        DataColumn(
          label: Text('Pekerjaan Akhir'),
        
        ),

    
        
         DataColumn(
          label: Text('Status'),
        
        ),
      ],
      rows:List.generate(_filterProses.length,(index){

 var tanggal = "";
 var tanggal2 ="";
 var tanggal3 ="";
 var tanggal4 ="";
if(_filterProses[index].pemilihanAwal.isNotEmpty&&_filterProses[index].pemilihanAwal.trim().length>1){
DateTime tgl = DateTime.parse(_filterProses[index].pemilihanAwal);
tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
print(_filterProses[index].pemilihanAwal);
}
if(_filterProses[index].pemilihanAkhir.isNotEmpty&&_filterProses[index].pemilihanAkhir.trim().length>1){
DateTime tgl2 = DateTime.parse(_filterProses[index].pemilihanAkhir);
tanggal2 =  "${tgl2.day} - ${tgl2.month} - ${tgl2.year}";
print(_filterProses[index].pemilihanAkhir);
}
if(_filterProses[index].pekerjaanAwal.isNotEmpty&&_filterProses[index].pekerjaanAwal.trim().length>1){
DateTime tgl3 = DateTime.parse(_filterProses[index].pekerjaanAwal);
tanggal3 =  "${tgl3.day} - ${tgl3.month} - ${tgl3.year}";
print(_filterProses[index].pekerjaanAwal);
}
if(_filterProses[index].pekerjaanAkhir.isNotEmpty&&_filterProses[index].pekerjaanAkhir.trim().length>1){
DateTime tgl4 = DateTime.parse(_filterProses[index].pekerjaanAkhir);
tanggal4 =  "${tgl4.day} - ${tgl4.month} - ${tgl4.year}";
print(_filterProses[index].pekerjaanAkhir);
}
          
           return DataRow(cells: [
             DataCell(Text(
             (index+1).toString()
             )),
             DataCell(
            
            Text(_filterProses[index].namaUnit.toString()
            ),
            ),
            DataCell(
            Container(
            width: 200,
            child : Text(_filterProses[index].namaPengadaan.toString()),    
            ),
            ),
            DataCell(
            Text(
              '${_filterProses[index].volume.toString()} Paket'
            ),
            ),
            DataCell(
            Text(_filterProses[index].sumberDana.toString()
            ),
            ),
            DataCell(
            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(_filterProses[index].paguPengadaan)
            ),),    
            ),
            DataCell(
            Text(_filterProses[index].metodePengadaan.toString()),
            ),
            DataCell(
            _filterProses[index].pemilihanAwal.isNotEmpty && _filterProses[index].pemilihanAwal!=null?
            Text(tanggal):
            Text(""),
            ),
            DataCell(
            _filterProses[index].pemilihanAkhir.isNotEmpty && _filterProses[index].pemilihanAkhir!=null?
            Text(tanggal2):
            Text(""),
            ),
            DataCell(
            _filterProses[index].pekerjaanAwal.isNotEmpty && _filterProses[index].pekerjaanAwal!=null?
            Text(tanggal3):
            Text(""),
            ),
            DataCell(
            _filterProses[index].pekerjaanAkhir.isNotEmpty && _filterProses[index].pekerjaanAkhir!=null?
            Text(tanggal4):
            Text(""),
            ),
        
            
            DataCell(
            Text(_filterProses[index].usulanStatus.toString()),
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
// Widget searchedMethod(){
// return Padding( padding : EdgeInsets.all(20.0),

// child: DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                         hint: Text("Metode Pengadaan"),
//                           isExpanded: true,
//                           dropdownColor: Colors.white,
//                           value: searchMethod,
//                           items: Proses.listMethod
//                               .map((e) => DropdownMenuItem<String>(
//                                     child: Text(e),
//                                     value: e,
//                                   ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               searchMethod = value;
                              
//                             });
//                           }),
//                     ));

// }

// void filterMethod() {
//   print(searchMethod);
//     var initialList = _prosess;
//     if(onSearch){
//       initialList = _filterProses;
//     }
//     switch (searchMethod) {
//       case 'Pengadaan Langsung':
//         _filterProses = initialList
//             .where((element) => element.metodePengadaan
//                 .toLowerCase()
//                 .trim()
//                 .contains('Pengadaan Langsung'.toLowerCase()))
//             .toList();
//         break;
//       case 'Penunjukan Langsung':
//         _filterProses = initialList
//             .where((element) => element.metodePengadaan
//                 .toLowerCase()
//                 .trim()
//                 .contains('Penunjukan Langsung'.toLowerCase()))
//             .toList();
//         break;
//       case 'Tender Cepat':
//         _filterProses = initialList
//             .where((element) => element.metodePengadaan
//                 .toLowerCase()
//                 .trim()
//                 .contains('Tender Cepat'.toLowerCase()))
//             .toList();
//         break;
//       case 'Tender':
//         _filterProses = initialList
//             .where((element) =>
//                 element.metodePengadaan.toLowerCase().trim() ==
//                 ('Tender'.toLowerCase()))
//             .toList();
//         break;
//       default:
//         _filterProses = initialList;
//     }
//   }

  @override
  Widget build(BuildContext context) {
  Akun account = Provider.of<Auth>(context).getUserInfo;
    int role = Provider.of<Auth>(context).getUserInfo.role;  
      // filterMethod();
  if (account.role == 1) {
       return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          actions: <Widget>[
            // IconButton(
            //     icon: Icon(Icons.add),
            //     onPressed: () {
            //       _createProses();
            //     }),
            
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
            // searchedMethod(),
            //   searchField(),
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
            // searchedMethod(),
            //   searchField(),
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
            // searchedMethod(),
            //   searchField(),
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
      case 3:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
              Expanded(child: 
              _databody()),
                  
        ]
        )
        ;
        break;
      case 4:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
              Expanded(child: 
              _databody()),
                   
        ]
        );
        break;
      case 5:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
              Expanded(child: 
              _databody()),
                 
        ]
        );
        break;
      case 6:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
              Expanded(child: 
              _databody()),
                
        ]
        );
        break;
      case 7:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
              Expanded(child: 
              _databody()),
                   
        ]
        );
        break;
      default:
        return Column(
            children : [
            // searchedMethod(),
            //   searchField(),
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

