
import 'dart:async';
//eror selected value null saat memilih kolom kosong

import 'package:Monitoring/Komponen/datePicker.dart';
import 'package:Monitoring/Model/Akun.dart';
import 'package:Monitoring/Model/ServiceUsulan.dart';
import 'package:Monitoring/Model/UsulanStatus.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/Model/ServicePengadaan.dart';
import 'package:Monitoring/authent.dart';
import 'package:Monitoring/konstan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';


class MonPengadaan extends StatefulWidget {
MonPengadaan():super();
final String title = 'Monitoring Pengadaan';

  @override
  _MonPengadaanState createState() => _MonPengadaanState();
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


class _MonPengadaanState extends State<MonPengadaan> {
  List<Proses> _prosess;
  List<UsulanStatus> _status;
  List<Proses> _filterProses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaUnitController;
  TextEditingController _namaPengadaanController;
  TextEditingController _jenisPengadaanController;
  TextEditingController _namaPenyediaController;
  TextEditingController _nilaiKontrakController;
  TextEditingController _paguPengadaanController;
  TextEditingController _hpsPengadaanController;
  TextEditingController _usulanStatusController;
  TextEditingController volumeController;
  TextEditingController sumberDanaController;

  var pemilihanAwal;
  var pemilihanAkhir;
  var pekerjaanAwal;
  var pekerjaanAkhir;

  Proses _selectedProses;
  bool _isUpdating;
  String _titleProgress;
  final _debouncer = Debouncerr(milliseconds: 1000);
  var selectedUnit;
  var selectedMethod;
  var selectedJenisPengadaan;
  var searchMethod;
  var selectedDay;
  var selectedMonth;
  var selectedYears;
  bool onSearch = false;
  String searchedText;


  var selectedStatus;
  var searchStatus;

  





  @override
  void initState() {
    super.initState();
    
    _status = [];
    var roles = Provider.of<Auth>(context,listen:false).getUserInfo.getRole();
    _getProses();
     listStat(roles);
    _prosess = [];
    _isUpdating = false;
    _filterProses =[];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaUnitController = TextEditingController();
    _namaPengadaanController = TextEditingController();
    _jenisPengadaanController = TextEditingController();
    _namaPenyediaController = TextEditingController();
    _paguPengadaanController = TextEditingController();
    _hpsPengadaanController = TextEditingController();
    _nilaiKontrakController = TextEditingController();
    _usulanStatusController = TextEditingController();
    volumeController = TextEditingController();
    sumberDanaController = TextEditingController();
    // pemilihanAwalController = TextEditingController();
    // pemilihanAkhirController = TextEditingController();
    // pekerjaanAwalController = TextEditingController();
    // pekerjaanAkhirController = TextEditingController();

    // _tahapController = TextEditingController();
  }

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
// Future<void> getList()async {

//  await ServicePengadaan.getPro1(
//    tahun: selectedYears
//  ).then((value) =>a = value);
//  setState(() {
//  });
// }

 _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Ditambahkan"),
    ));
  }
   _showSnackBarField(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Isikan Status"),
    ));
  }
_getProses() {
    _showProgress('Loading Pengadaan...');
    ServicePengadaan.getProses((List<Proses> listProses) {
      if (listProses.isNotEmpty) {
        setState(() {
          _prosess = listProses;
          _filterProses = listProses??[];
        });
        _showProgress(widget.title);
        print("Length: ${listProses.length}");
      }
    });
  }


Future<void>listStat(roles)async{

  await ServiceUsulan.getUsulan(role: roles,callback : (a){
   setState(() {
     _status = a??[];
   });
   print("dalam callback");
  }

  );
}
Future<void>filter()async{
  
  await ServicePengadaan. getFilter(usulanStatus: searchStatus, callback :(List<Proses> listProses){
   setState(() {
     _filterProses = listProses??[];
     print(listProses);
   print('a');
   });
  })
  ;}
 
    _updateProsesPPK(Proses proses) async {
      if (selectedStatus==null         
        ) {
        print("Empty fields");
         _showSnackBarField(context,"result");
       return;
    }
    _showProgress('Updating Ekatalog...');
    // var sisaAnggaran = int.parse(proses.paguPengadaan) - int.parse(_nilaiKontrakController.text);
    var sisaAnggaran = int.parse(proses.paguPengadaan);
    if(_nilaiKontrakController.text.isNotEmpty){
      sisaAnggaran = int.parse(proses.paguPengadaan) - int.parse(_nilaiKontrakController.text);
    }
    await ServicePengadaan.updateProsesPPK(
            proses.id, selectedUnit, _namaPengadaanController.text, selectedJenisPengadaan , selectedDay,  selectedMonth, selectedYears ,volumeController.text , sumberDanaController.text, pemilihanAwal , pemilihanAkhir , pekerjaanAwal, pekerjaanAkhir, _namaPenyediaController.text,  selectedMethod, _paguPengadaanController.text, _hpsPengadaanController.text, _nilaiKontrakController.text, sisaAnggaran.toString(), selectedStatus) 
        .then((result) {
      if ('success' == result) {
        _showSnackBar(context, result);
        _getProses();
        setState(() {
          _isUpdating = false;
        });
         _paguPengadaanController.text = '';
        _hpsPengadaanController.text = '';  
        _usulanStatusController.text = '';
      }
    });

  }
  
  void _deleteProses(Proses proses) {
    _showProgress('Deleting Employee...');
    ServicePengadaan.deleteProses(proses.id).then((result) {
      if ('success' == result) {
        setState(() {
          _prosess.remove(proses);
        });
        _getProses();
      }
    });
  }

   _showValues(Proses proses) {//memunculkan value yang nantinya ditunjukkan
   _namaUnitController.text = proses.namaUnit;
    _namaPengadaanController.text = proses.namaPengadaan;
    selectedJenisPengadaan = proses.jenisPengadaan;
    _namaPenyediaController.text = proses.namaPenyedia;
    selectedMethod = proses.metodePengadaan;
    volumeController.text = proses.volume;
    sumberDanaController.text = proses.sumberDana;
    selectedDay = proses.tanggal;
    selectedMonth = proses.bulan;
    selectedYears = proses.tahun;
    // tgl = DateTime.parse((proses.tanggalPengadaan));
    pemilihanAwal = proses.pemilihanAwal;
    pemilihanAkhir = proses.pemilihanAkhir;
    pekerjaanAwal = proses.pekerjaanAwal;
    pekerjaanAkhir = proses.pekerjaanAkhir;
    _paguPengadaanController.text = proses.paguPengadaan;
    _hpsPengadaanController.text = proses.hpsPengadaan;
    _nilaiKontrakController.text = proses.nilaiKontrak;
    _jenisPengadaanController.text = proses.jenisPengadaan;
    

    setState(() {
      _isUpdating = true;
    });
  }
  _showValuesPPK(Proses proses) {//memunculkan value yang nantinya ditunjukkan
    selectedUnit = proses.namaUnit;
    _namaPengadaanController.text = proses.namaPengadaan;
    selectedJenisPengadaan = proses.jenisPengadaan;
    _namaPenyediaController.text = proses.namaPenyedia;
    selectedMethod = proses.metodePengadaan;
    volumeController.text = proses.volume;
    sumberDanaController.text = proses.sumberDana;

    
    pemilihanAwal = proses.pemilihanAwal;
    pemilihanAkhir = proses.pemilihanAkhir;
    pekerjaanAwal = proses.pekerjaanAwal;
    pekerjaanAkhir = proses.pekerjaanAkhir;
    _paguPengadaanController.text = proses.paguPengadaan;
    _hpsPengadaanController.text = proses.hpsPengadaan;
    _nilaiKontrakController.text = proses.nilaiKontrak;
    _usulanStatusController.text = proses.usulanStatus;
    setState(() {
      _isUpdating = true;
    });
  }
  _showValuesDp(Proses proses) {//memunculkan value yang nantinya ditunjukkan
   selectedUnit = proses.namaUnit;
    _namaPengadaanController.text = proses.namaPengadaan;
    // selectedJenisPengadaan = proses.jenisPengadaan;
    _namaPenyediaController.text = proses.namaPenyedia;
    selectedMethod = proses.metodePengadaan;
    volumeController.text = proses.volume;
    sumberDanaController.text = proses.sumberDana;
    // tgl = DateTime.parse((proses.tanggalPengadaan));
    pemilihanAwal = proses.pemilihanAwal;
    pemilihanAkhir = proses.pemilihanAkhir;
    selectedDay = proses.tanggal;
    selectedMonth = proses.bulan;
    selectedYears = proses.tahun;
    pekerjaanAwal = proses.pekerjaanAwal;
    pekerjaanAkhir = proses.pekerjaanAkhir;
    _paguPengadaanController.text = proses.paguPengadaan;
    _hpsPengadaanController.text = proses.hpsPengadaan;
    _nilaiKontrakController.text = proses.nilaiKontrak;
    
    

    setState(() {
      _isUpdating = true;
    });
  }
 void _clearValues(){
      
        _namaPengadaanController.text = '';
        _namaPenyediaController.text = '';   
        _paguPengadaanController.text = '';
        _hpsPengadaanController.text = '';
        _nilaiKontrakController.text = '';
        _usulanStatusController.text = '';   
  }


SingleChildScrollView _databody(){
Akun account = Provider.of<Auth>(context).getUserInfo; 
if (account.role == 1) {
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
          label: Text('Jenis Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

        ),
        DataColumn(
          label: Text('Sisa Anggaran'),
        
        ),
         DataColumn(
          label: Text('Status'),
        
        ),
         DataColumn(
          label: Text('Hapus'),
        
        ),
      ],
      rows: _filterProses.map(
        (proses){
//  var tanggal = "";
// if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
// DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
// tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
// print(proses.tanggalPengadaan);
// }
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValues(proses);
              _selectedProses = proses;
          }),
          DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.jenisPengadaan.toString()),
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
          }),
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
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              _deleteProses(proses);
            },
            ))
        ]

      );}).toList(),
      ),
    ),
      

  );}else if(account.role == 3){
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
          label: Text('Jenis Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

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
//       var tanggal = "";
//       if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
//       DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
//       tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
//       print(proses.tanggalPengadaan);
// }
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValuesDp(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValuesDp(proses);
              _selectedProses = proses;
          }),
          DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
            onTap: (){
              _showValuesDp(proses);
              _selectedProses = proses;
            }),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValuesDp(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.jenisPengadaan.toString()),
          onTap: (){
            _showValuesDp(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValuesDp(proses);
            _selectedProses = proses;
          }),
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
                        , onTap: () {
                      _showValuesDp(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValuesDp(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),

        ]

      )
      ;}
      ).toList(),
      ),
    ),
      

  );
  }else if(account.role == 5){
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
          label: Text('Jenis Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

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
//       var tanggal = "";
//       if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
//       DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
//       tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
//       print(proses.tanggalPengadaan);
// }
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValuesPPK(proses);
              _selectedProses = proses;
          }),
          DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
           ),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.jenisPengadaan.toString()),
          onTap: (){
            _showValuesPPK(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValuesPPK(proses);
            _selectedProses = proses;
          }),
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
                        , onTap: () {
                      _showValuesPPK(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValuesPPK(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),

        ]

      )
      ;}
      ).toList(),
      ),
    ),
      

  );
  }
  else if(account.role == 4){
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
          label: Text('Jenis Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

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
//       var tanggal = "";
//       if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
//       DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
//       tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
//       print(proses.tanggalPengadaan);
// }
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValuesPPK(proses);
              _selectedProses = proses;
          }),
          DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
           ),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.jenisPengadaan.toString()),
          onTap: (){
            _showValuesPPK(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValuesPPK(proses);
            _selectedProses = proses;
          }),
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
                        , onTap: () {
                      _showValuesPPK(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValuesPPK(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValuesPPK(proses);
              _selectedProses = proses;
            }),

        ]

      )
      ;}
      ).toList(),
      ),
    ),
      

  );
  }else{
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
          label: Text('Jenis Pengadan'),
        
        ),
         DataColumn(
          label: Text('Pagu'),
        
        ),
         DataColumn(
          label: Text('HPS'),
        
        ),
        DataColumn(
          label: Text('Nilai Kontrak')

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
//       var tanggal = "";
//       if(proses.tanggalPengadaan.isNotEmpty&&proses.tanggalPengadaan.trim().length>1){
//       DateTime tgl = DateTime.parse(proses.tanggalPengadaan);
//       tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
//       print(proses.tanggalPengadaan);
// }
          
           return DataRow(cells: [
              DataCell(
            
            Text(proses.namaUnit.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Container(
            width: 200,
            child : Text(proses.namaPengadaan.toString()),    
            ),
               onTap: (){
               _showValues(proses);
              _selectedProses = proses;
          }),
          DataCell(
            
            Text(
              '${proses.tanggal.toString()} - ${proses.bulan.toString()} - ${proses.tahun.toString()}'
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          // DataCell(
          //     proses.tanggalPengadaan.isNotEmpty && proses.tanggalPengadaan!=null?
          //   Text(tanggal):
          //   Text(""),
          //   onTap: (){
          //     _showValues(proses);
          //     _selectedProses = proses;
          //   }),
          DataCell(
            
            Text(proses.namaPenyedia.toString()
            ),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
          DataCell(
          Text(proses.jenisPengadaan.toString()),
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
            }),
          DataCell(
          Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(int.parse(proses.paguPengadaan)
          ),),    
        
          onTap: (){
            _showValues(proses);
            _selectedProses = proses;
          }),
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
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
                    DataCell(
                      proses.nilaiKontrak.isNotEmpty && proses.nilaiKontrak != null?
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.nilaiKontrak),
                          ),
                        ):
                        Text(
                          "0"
                          )
                        , onTap: () {
                      _showValues(proses);
                      _selectedProses = proses;
                    }),
            
            DataCell(
            proses.sisaAnggaran.isNotEmpty && proses.sisaAnggaran!=null?
            Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                              .format(
                            int.parse(proses.sisaAnggaran),),): 
                            Text(
                          "0"
                          )
                        ,//erorr
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),
            DataCell(
            Text(proses.usulanStatus.toString()),
            onTap: (){
              _showValues(proses);
              _selectedProses = proses;
            }),

        ]

      )
      ;}
      ).toList(),
      ),
    ),
      

  );
  }

  

}

// searchField() {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
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
Widget searchedMethod(){
return Padding( padding : EdgeInsets.all(10.0),

child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Filter Metode"),
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
                    )
                    );

}
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
                ('Tender'.toLowerCase())
                )
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
          ],
        ),
        body: Container(
          child: roleMenuList(role, context, account)
        ),       
        );
  }
  Widget roleMenuList(int role, BuildContext context, Akun account) {
    // var size = MediaQuery.of(context).size;
    switch (role) {
      case 0:
        return ListView(
            
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nilaiKontrakController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Nilai Kontrak',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _usulanStatusController,
                  decoration: InputDecoration.collapsed(hintText: 'Status',

                  ),
                ),
              ),



              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
        break;
      case 1:
        return Column(
           children :[
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),           
            ],   
          );
        break;
      case 2:
       return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _paguPengadaanController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Pagu',
                  ),
                ),
              ),
              
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
        break;
      case 3:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(padding: EdgeInsets.all(10.0),
              child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Status"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                              
                            });
                          }),
                    ),
                    ),
              Padding(padding: EdgeInsets.all(10.0),
              child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Jenis Pengadaan"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedJenisPengadaan,
                          items: Proses.listPengadaan
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedJenisPengadaan= value;
                              
                            });
                          }),
                    ),
                    ),
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
        break;
      case 4:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _namaPenyediaController,
                  decoration: InputDecoration.collapsed(hintText: 'Nama Penyedia',

                  ),
                ),
              ),
             DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Status"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                               
                            });
                          }),
                    ),
                    
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
        break;
      case 5:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
               Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _hpsPengadaanController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'HPS',

                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Tanggal"),
                          
                          dropdownColor: Colors.white,
                          value: selectedDay,
                          items: Proses.listDay
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDay= value;
                              
                            });
                          }),
                    ),
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Bulan"),
                          
                          dropdownColor: Colors.white,
                          value: selectedMonth,
                          items: Proses.listMonth
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth= value;
                              
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
                              
                            });
                          }),
                    ),

            ],),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nilaiKontrakController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Nilai Kontrak',

                  ),
                ),
              ),
             Padding(padding: EdgeInsets.all(10.0),
              child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Status"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                               
                            });
                          }),
                    ),
                    ),
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
        break;
      case 6:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Status"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                               
                            });
                          }),
                    ),
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),           
            ],
          );
        break;
      case 7:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Status"),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedStatus,
                          items: _status
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.usulanStatus),
                                    value: e.usulanStatus,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                               
                            });
                          }),
                    ),
              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),           
            ],
          );
        break;   
      default:
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nilaiKontrakController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Nilai Kontrak',

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _usulanStatusController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(hintText: 'Status',

                  ),
                ),
              ),



              _isUpdating? 
              Row(children: <Widget>[
                OutlineButton(
                  child: Text('Update'),
                  onPressed: (){
                    _updateProsesPPK(_selectedProses);
                  },
                  ),
                  
                  OutlineButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      setState((){
                        _isUpdating = false;
                      });
                      _clearValues();
                  },
                  )
              ],
              )
              :Container(),
              searchedMethod(),
              // searchField(),
              searchFilter(),
              Expanded(child: 
              _databody(),
              ),
              
            ],
            
          );
    }
  }
}


