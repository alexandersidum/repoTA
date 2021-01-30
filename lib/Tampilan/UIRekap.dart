import 'dart:ffi';


import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';


class UIRekap extends StatefulWidget {
  UIRekap():super();
  final String title = 'Rekap Pengadaan';
  @override
  _UIRekapState createState() => _UIRekapState();
}


class _UIRekapState extends State<UIRekap> {

  GlobalKey<ScaffoldState> _scaffoldKey;
 String _titleProgress;
 
 String a ; // pengadaan langsung
 String b; // penunjukkan langsung
 String c ;// Tender Cepat
 String d ;// Tender
 var selectedYears  
  = DateTime.now().year.toString();
  @override
  void initState() {
  super.initState();
  // getrekaps();
  getPengadaanLangsung();
  getPenunjukkanLangsung();
  getTenderCepat();
  getTender();
  _titleProgress = widget.title;
  _scaffoldKey = GlobalKey();
  }



//  Future<Void> getrekaps()async {

//  await ServiceEkat.getRekap().then((value) =>z = value);
//  setState(() {
//  });
// }


Future<void> getPengadaanLangsung()async {

 await ServicePengadaan.getPro1(
   tahun: selectedYears
 ).then((value) =>a = value);
 setState(() {
 });
}

Future<void> getPenunjukkanLangsung()async {

 await ServicePengadaan.getPro2(
   tahun: selectedYears
 ).then((value) =>b = value);
 setState(() {
 });
}

Future<Void> getTenderCepat()async {

 await ServicePengadaan.getPro3(
   tahun: selectedYears
 ).then((value) =>c = value);
 setState(() {
 });
}

Future<Void> getTender()async {

 await ServicePengadaan.getPro4(
   tahun: selectedYears
 ).then((value) =>d = value);
 setState(() {
 });
}

  SingleChildScrollView _databody(){
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
   columns: [
     DataColumn(
       label: Text('No'),
     ),
     DataColumn(
       label: Text('Pengadaan'),
     ),
     DataColumn(
       label: Text('Rekap Transaksi'),
     ),
     
   ],
   rows:  <DataRow>[
     DataRow(
       cells: <DataCell>[
         DataCell(Text('1')),
         DataCell(Text('Pengadaan Langsung')),
         DataCell(a!=null?
           Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(int.parse(a)
                          )
                          ): Text(
                          "0"
                          ),
                          )
        
       ],
     ),
     DataRow(
       cells: <DataCell>[
         DataCell(Text('2')),
         DataCell(Text('Penunjukkan Langsung')),
         DataCell(b!=null?
           Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(int.parse(b)
                          )
                          ): Text(
                          "0"
                          ),
                          )
        
       ],
     ),
     DataRow(
       cells: <DataCell>[
         DataCell(Text('3')),
         DataCell(Text('Tender Cepat')),
         DataCell(c!=null?
           
           Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(int.parse(c)
                          )
                          ): Text(
                          "0"
                          ),
                          )
        
       ],
     ),
     DataRow(
       cells: <DataCell>[
         DataCell(Text('4')),
         DataCell(Text('Tender')),
         DataCell(d!=null?
           Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(int.parse(d)
                          )
                          ): Text(
                          "0"
                          ),
                          )
        
       ],
     ),
    //  DataRow(
    //    cells: <DataCell>[
    //      DataCell(Text('5')),
    //      DataCell(Text('Ekatalog')),
    //      DataCell(z!=null?
    //        Text(
    //          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
    //                           .format(int.parse(z))
    //                       ):Text(
    //                       "0"),
    //                       )
                          
        
    //    ],
    //  ),
    ]
   ),
    
      

  ));

}


  @override
  Widget build(BuildContext context) {
    print(a);
    print(b);
    print(c);
    print(d);
    
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
          
        ),
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : <Widget>[
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                Text("Tahun"),   
                DropdownButtonHideUnderline(
                       child: DropdownButton(
                         hint: Text("Tahun"),
                           
                           dropdownColor: Colors.white,
                           value: selectedYears,
                           items: Proses.listYear
                               .map((e) => DropdownMenuItem<String>(
                                     child: Text(e),
                                    value: e,
                                   ))
                               .toList(),
                           onChanged: (value) {
                             setState(() {
                               selectedYears= value;
                             getPengadaanLangsung();
                             getPenunjukkanLangsung();
                             getTenderCepat();
                             getTender();
                            });
                          }),
                    ),
              ]),
              
              Expanded(child: 
              _databody()),
      
              
        ])
          ),
        );
  }
}