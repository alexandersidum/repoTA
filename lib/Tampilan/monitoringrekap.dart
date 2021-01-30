// // import 'dart:developer';

// import 'package:Monitoring/Model/rekap.dart';
// import 'package:Monitoring/Model/ServiceRekap.dart';
// import 'package:Monitoring/Model/ServiceEkatalog.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// class MonRekap extends StatefulWidget {
// MonRekap():super();
// final String title = 'Monitoring Rekap';

//   @override
//   _MonRekapState createState() => _MonRekapState();
// }

// class _MonRekapState extends State<MonRekap> {
//   // List<Rekap> _rekaps;
//   // List<Rekap> _filterRekap;
//   // GlobalKey<ScaffoldState> _scaffoldKey;
//   // TextEditingController _namaPengadaansController;
//   // TextEditingController _totalRekapController;
//   Rekap _selectedRekap;
//   bool _isUpdating;
//   String _titleProgress;
//   bool onSearch = false;
//   // String searchedYear;
//   var selectedYear;
//   var searchYear ;
//  String a = await ServiceEkat.getRekap();

// // List<DropdownMenuItem> dropDownMenu(Map input) {
// //     List<DropdownMenuItem> output = [];
// //     input.forEach((key, value) {
// //       output.add(DropdownMenuItem<int>(
// //         child: Text(value),
// //         value: key,
// //       ));
// //     });
// //     return output;
// //   }


//   @override
//   void initState() {
//     super.initState();
//     // _getRekap();
//     // _rekaps = [];
//     // _filterRekap = [];
//     _isUpdating = false;
//     _titleProgress = widget.title;
//     // _scaffoldKey = GlobalKey();
//     // _namaPengadaansController = TextEditingController();
//     // _totalRekapController = TextEditingController();
//   }
//   // _showSnackBar(context,message){
//   //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);

//   // }
// //   _showProgress(String message){
// //     setState(() {
// //       _titleProgress = message;
// //     });
// //   }

// //   _createRekap() {
// //     _showProgress('Creating Table...');
// //     ServiceRekap.createTable().then((result){
// //       if  ('success' == result){
// //         _showSnackBar(context, result);

// //       }
// //     });
// //   }
// //  _showSnackBar(context, message) {
// //     _scaffoldKey.currentState.showSnackBar(SnackBar(
// //       content: Text("Ditambahkan"),
// //     ));
// //   }
  
// // _getRekap() {
// //   _showProgress('Loading Rekap...');
// //     ServiceRekap.getRekap().then((rekaps) {
// //       setState(() {
// //         _rekaps = rekaps;
// //       });
// //       _showProgress(widget.title);
// //       print("Length: ${rekaps.length}");
// //     });
// //   }



//   // _updateRekap(Rekap rekap) {
//   //   _showProgress('Updating Ekatalog...');
//   //   ServiceRekap.updateRekap(
//   //           rekap.id,selectedYear, _namaPengadaansController.text,  _totalRekapController.text) 
//   //       .then((result) {
//   //     if ('success' == result) {
//   //       setState(() {
//   //         _isUpdating = false;
//   //       });
//   //      _namaPengadaansController.text = '';
//   //       _totalRekapController.text = '';


//   //     }
//   //   });

//   // }
//   // _deleteRekap(Rekap rekap) {
//   //   _showProgress('Deleting Employee...');
//   //   ServiceRekap.deleteRekap(rekap.id).then((result) {
//   //     if ('success' == result) {
//   //       setState(() {
//   //         _rekaps.remove(rekap);
//   //       });
//   //       _getRekap();
//   //     }
//   //   });
//   // }
//   //  _showValues(Rekap rekap) {
//   //    selectedYear = rekap.tahun;
//   //   _namaPengadaansController.text = rekap.namaPengadaans;
//   //   _totalRekapController.text = rekap.totalPengadaan; 
//   //   setState(() {
//   //     _isUpdating = true;
//   //   });
//   // }

//   // _clearValue(){
//   //   _namaPengadaansController.text = '';
//   //   _totalRekapController.text = '';
//   // }


// SingleChildScrollView _databody(){
//   // _filterRekap.forEach((Rekap e) { 
//   //     print(e.id);
//   //     print(e.namaPengadaans);
//   //     print(e.totalPengadaan);
//   //     print(e.tahun);

//   //   });
//   return SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(columns: [

//          DataColumn(
//           label: Text('Nama Pengadaan'),
        
//         ),
//          DataColumn(
//           label: Text('Total Rekap'),
        
//         ),
//          DataColumn(
//           label: Text('Hapus'),
        
//         ),
//       ],
//       rows: _rekaps
//       .map(
//         (rekap) => DataRow(cells: [
 
//             DataCell(
//             Text(rekap.namaPengadaans.toUpperCase()),
//             onTap: (){
//               _showValues(rekap);
//               _selectedRekap = rekap;
//             }
//             ),
//             DataCell(
//             Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(rekap.totalPengadaan)),
//               ),
//             onTap: (){
//               _showValues(rekap);
//               _selectedRekap = rekap;

//             }
//             ),
//             DataCell(IconButton(icon: Icon(Icons.delete),
//             onPressed: (){
//               _deleteRekap(rekap);
//             },
//             ))
//         ]

//       )).toList(),
//       ),
//     ),
      

//   );

// }

// Widget searchedYear(){
// return
// Padding( padding : EdgeInsets.all(20.0),

// child: DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                         hint: Text("Year"),
//                           isExpanded: true,
//                           dropdownColor: Colors.white,
//                           value: searchYear,
//                           items: Rekap.listTahun
//                               .map((e) => DropdownMenuItem<String>(
//                                     child: Text(e),
//                                     value: e,
//                                   ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               searchYear = value;
                              
//                             });
//                           }),
//                     )
//                     );

// }

// // void filterYear() {
  
// //     var initialList = _rekaps;
// //     if(onSearch){
// //       initialList = _filterRekap;
// //     }
// //     switch (searchYear) {
// //       case '2018':
// //         _filterRekap = initialList
// //             .where((element) => element.tahun
// //                 .toLowerCase()
// //                 .trim()
// //                 .contains('2018'.toLowerCase()))
// //             .toList();
// //         break;
// //       case '2019':
// //         _filterRekap= initialList
// //             .where((element) => element.tahun
// //                 .toLowerCase()
// //                 .trim()
// //                 .contains('2019'.toLowerCase()))
// //             .toList();
// //         break;
// //       case '2020':
// //         _filterRekap = initialList
// //             .where((element) => element.tahun
// //                 .toLowerCase()
// //                 .trim()
// //                 .contains('2020'.toLowerCase()))
// //             .toList();
// //         break;
// //       case '2021':
// //         _filterRekap = initialList
// //             .where((element) =>
// //                 element.tahun.toLowerCase().trim() ==
// //                 ('2021'.toLowerCase())
// //                 )
// //             .toList();
// //         break;
// //       default:
// //         _filterRekap = initialList;
// //     }
// //   }


//   @override
//   Widget build(BuildContext context) {
//        return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text(_titleProgress),
//           actions: <Widget>[
//             // IconButton(
//             //     icon: Icon(Icons.add),
//             //     onPressed: () {
//             //      _createRekap();
//             //     }),
//                 IconButton(
//                 icon: Icon(Icons.refresh),
//                 onPressed: () {
//                   _getRekap();
//                 }),
//           ],
//         ),
//         body: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget> [
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: TextField(
//                   controller: _namaPengadaansController,
//                   decoration: InputDecoration.collapsed(hintText: 'Nama Pengadaan',

//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: TextField(
//                   controller: _totalRekapController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration.collapsed(hintText: 'Total Rekap',

//                   ),
//                 ),
//               ),

//               _isUpdating? 
//               Row(children: <Widget>[
//                 OutlineButton(
//                   child: Text('Update'),
//                   onPressed: (){
//                     _updateRekap(_selectedRekap);
//                   },
//                   ),
//                   OutlineButton(
//                     child: Text('Cancel'),
//                     onPressed: (){
//                       setState((){
//                         _isUpdating = false;
//                       });
//                       _clearValue();
//                   },
//                   )
//               ],
//               )
//               :Container(),
//               searchedYear(),
//               Expanded(child: 
              
//               _databody(),
//               ),
              
              
//             ],
//           ),
//         ),
//           // floatingActionButton: FloatingActionButton(
//           //   onPressed: (){
//           //     _addRekap();
//           // } ,
//           // child: Icon(Icons.add),
//           // ),
//         );
//   }
// }

