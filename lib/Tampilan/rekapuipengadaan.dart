import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:Monitoring/Model/laporan.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RekapUIPengadaan extends StatefulWidget {
  RekapUIPengadaan():super();
  final String title = 'Monitoring Rekap';
  @override
  _RekapUIPengadaanState createState() => _RekapUIPengadaanState();
}

class _RekapUIPengadaanState extends State<RekapUIPengadaan> {
  List<Laporan> _laporans;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  var selectedYears  
  = DateTime.now().year.toString();
  var selectedMonth 
  = DateTime.now().month;
  var selectedPengadaan = "Pengadaan Langsung";

 String x ; // pengadaan langsung
 String b; // penunjukkan langsung
 String c ;// Tender Cepat
 String d ;// Tender
 String e; //ekatalog


  @override
  void initState() {
    super.initState();
    getrekaps();
    getTotal();
    _laporans = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
  }


Future<void> getrekaps()async {
if(selectedPengadaan== "Ekatalog"){
 await ServicePengadaan.getRekapEkatalog(bulan: 
 monthConverter(
   selectedMonth
   )
   , tahun: selectedYears
 , callback : (a){
   setState(() {
     _laporans = a??[];
   });
   });
}else{
  await ServicePengadaan.getRekapPengadaan(bulan: 
 monthConverter(
   selectedMonth
   )
   , tahun: selectedYears, metodePengadaan: selectedPengadaan
 , callback : (y){
   setState(() {
     _laporans = y??[];
   });
   });
}  
}
Future<void> getTotal()async{
  if(selectedPengadaan=="Pengadaan Langsung"){
    await ServicePengadaan.getProTot1(bulan: 
 monthConverter(
   selectedMonth
   )
   ,
   tahun: selectedYears
 ).then((value) =>x = value);
 setState(() {
 });
  }else if(selectedPengadaan=="Penunjukan Langsung"){
await ServicePengadaan.getProTot2(bulan: 
 monthConverter(
   selectedMonth
   )
   ,
   tahun: selectedYears
 ).then((value) =>b = value);
 setState(() {
 });
  }else if(selectedPengadaan=="Tender Cepat"){
await ServicePengadaan.getProTot3(bulan: 
 monthConverter(
   selectedMonth
   )
   ,
   tahun: selectedYears
 ).then((value) =>c = value);
 setState(() {
 });
  }else if(selectedPengadaan=="Tender"){
    await ServicePengadaan.getProTot4(bulan: 
 monthConverter(
   selectedMonth
   )
   ,
   tahun: selectedYears
 ).then((value) =>d = value);
 setState(() {
 });
  }else if(selectedPengadaan=="Ekatalog"){
    await ServicePengadaan.getProTot5(bulan: 
 monthConverter(
   selectedMonth
   )
   ,
   tahun: selectedYears
 ).then((value) =>e = value);
 setState(() {
 });
  }

}

Widget  column(){
  switch(selectedPengadaan){
    case 'Pengadaan Langsung':
      return x!=null?Text(
        (NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                               .format(int.parse(x)
      )
     )
     ): Text(
                          "0"
                          );
    break;
    case 'Penunjukan Langsung':
      return b!=null?Text(
        (NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                               .format(int.parse(b)
      )
     )
     ): Text(
                          "0"
                          );
     break;
     case 'Tender Cepat':
      return  c!=null?Text(
        (NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                               .format(int.parse(c)
      )
     )
     ): Text(
                          "0"
                          );
     
     break;
     case 'Tender':
       return d!=null?Text(
        (NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                               .format(int.parse(d)
      )
     )
     ): Text(
                          "0"
                          );
     break;
     case 'Ekatalog':
       return e!=null?Text(
        (NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                               .format(int.parse(e)
      )
     )
     ): Text(
                          "0"
                          );
     break;
  }
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
          label: Text('Unit/ Departemen/Fakultas'),
        
        ),
         DataColumn(
          label: Text('Total Rekap'),
        
        ),
        
      ],
      rows: List.generate(_laporans.length,(index)
      => DataRow(cells: [
        DataCell(Text(
             (index+1).toString()
             )),
 
            DataCell(
            Text(_laporans[index].namaUnit.toUpperCase()),
           
            ),
            DataCell(
            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(_laporans[index].totalPengeluaran),
              ),
            ),
            
        ]

      )).toList(),
      ),
    ),
      

  );

}
// ignore: missing_return
String monthConverter(int bulan) {
switch(bulan){
  case 1:
    return "Januari";
    break;
  case 2:
    return "Februari";
    break;
  case 3:
    return "Maret";
    break;
  case 4:
    return "April";
    break;
  case 5:
    return "Mei";
    break;
  case 6:
    return "Juni";
    break;
  case 7:
    return "Juli";
    break;
  case 8:
    return "Agustus";
    break;
  case 9:
    return "September";
    break;
  case 10:
    return "Oktober";
    break;
  case 11:
    return "November";
    break;
  case 12:
    return "Desember";
    break;
} 
}

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
         
          ),
          body:Container(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Pilih Metode"),
                          
                          dropdownColor: Colors.white,
                          value: selectedPengadaan,
                          items: Proses.listMethodRekap
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPengadaan = value;
                              getrekaps();
                              getTotal();
                            });
                          }),
                    ),
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Bulan"),
                          
                          dropdownColor: Colors.white,
                          value: 
                          
                            selectedMonth
                            
                          ,
                          items: Proses.listMonthRekap
                              .map((e) => DropdownMenuItem<int>(
                                    child: Text(monthConverter(e)),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value;
                              getrekaps();
                              getTotal();
                            });
                          }),
                    ),      
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
                              getrekaps();
                              getTotal();
                            });
                          }),
                    ),
              ]),
            
              Expanded(child: 
              _databody()),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  
                  Text('Total Transaksi:'),
                  SizedBox(width: 10),
                  column(),
              ],)
      
            ])
            )
            );
  }
}