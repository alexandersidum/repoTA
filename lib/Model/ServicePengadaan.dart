import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:Monitoring/Model/laporan.dart';
import 'package:http/http.dart'
  as http;
import 'prosesKegiatan.dart';

class ServicePengadaan{
  static const ROOT = 'http://192.168.100.170/EkatalogDB/pengadaan_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_PRO_ACTION = 'GET_PRO';
  static const _GET_FILTER = 'GET_FILTER';
  static const _ADD_PRO_ACTION = 'ADD_PRO';
  static const _UPDATE_PRO_ACTION = 'UPDATE_PRO';
  static const _DELETE_PRO_ACTION = 'DELETE_PRO';
  static const _GET_PENGADAAN_LANGSUNG = 'GET_PRO1';
  static const _GET_PENUNJUKAN_LANGSUNG ='GET_PRO2';
  static const _GET_TENDER_CEPAT ='GET_PRO3';
  static const _GET_TENDER ='GET_PRO4';
  static const _GET_EKATALOG ='GET_PRO5';
  static const _GET_TOT_PENGADAAN_LANGSUNG ='GET_PROTOT1';
  static const _GET_TOT_PENUNJUKAN_LANGSUNG ='GET_PROTOT2';
  static const _GET_TOT_TENDER_CEPAT ='GET_PROTOT3';
  static const _GET_TOT_TENDER ='GET_PROTOT4';
  static const _GET_TOT_EKAT ='GET_PROTOT5';
  static const _GET_REKAP = 'REKAP';


static Future<String> createTable() async {
  try{
    var map = Map<String, dynamic>();
    map["action"] = _CREATE_TABLE_ACTION;
    final response = await http.post(ROOT, body: map);
    print("Create Table Response : ${response.body}");
    // if(200 == response.statusCode){
      return response.body;
    // } else {
      // return "error";
    // }
  }catch (e){
   return "error";
  }
}
static Future<void> getProses(Function callback) async {
    var map = Map<String, dynamic>();
    map["action"] = _GET_PRO_ACTION;
    final response = await http.post(ROOT, body:map);
    print ("getProses Response: ${response.body}");
    if (200 == response.statusCode){
      List<Proses> list = parseResponse(response.body);
      callback(list);
    }else{
      callback(List());
    }
}
static Future<void> getFilter({String usulanStatus,Function callback}) async {
    String newUrl = ROOT+"?usulan_status="+usulanStatus;
    var map = Map<String, dynamic>();
    map["action"] = _GET_FILTER;
    map["usulan_status"] = usulanStatus;
    final response = await http.post(newUrl, body:map);
    print ("getFilter Response: ${response.body}");
    if (200 == response.statusCode){
      List<Proses> list = parseResponse(response.body);
      print(list);
      callback(list);
      
    }else{
      callback(List());
    }
}
static List<Proses> parseResponse(String responseBody) {
  print("Masuk ke parsed Response");
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  print(parsed);
  return parsed.map<Proses>((json) =>Proses.fromJson(json)).toList();
 
}
static List<Laporan> parseResponse1(String responseBody1) {
  print("Masuk ke parsed Response Laporan");
  final parsed = json.decode(responseBody1).cast<Map<String, dynamic>>();
  print(parsed);
  return parsed.map<Laporan>((json) =>Laporan.fromJson(json)).toList();

}

static Future<String> addProses(String namaUnit,String namaPengadaan, String volume,String sumberDana,String pemilihanAwal,String pemilihanAkhir,String pekerjaanAwal,String pekerjaanAkhir,String namaPenyedia,String metodePengadaan, String paguPengadaan, String hpsPengadaan, String nilaiKontrak, String sisaAnggaran, String usulanStatus,{String jenisPengadaan,String tanggal,String bulan, String tahun}) async{
   try{
     print(namaUnit);
     print(namaPengadaan);
     print(jenisPengadaan);
     print(tanggal);
     print(bulan);
     print(tahun);
     print(volume);
     print(sumberDana);
     print(pemilihanAwal);
     print(pemilihanAkhir);
     print(pekerjaanAwal);
     print(pekerjaanAkhir);
     print(namaPenyedia);
     print(metodePengadaan);
     print(paguPengadaan);
     print(hpsPengadaan);
     print(nilaiKontrak);
     print(sisaAnggaran);
     print(usulanStatus);
    var map = Map<String, dynamic>();
    map['action'] = _ADD_PRO_ACTION;
    map['nama_unit'] = namaUnit;
    map['nama_pengadaan'] = namaPengadaan;
    map['jenis_pengadaan'] = jenisPengadaan != null ? jenisPengadaan : " ";
    map['tanggal'] =  tanggal != null ? tanggal : " ";
    map['bulan'] =  bulan != null ? bulan : " ";
    map['tahun'] =  tahun != null ? tahun : " ";
    map['volume'] = volume;
    map['sumber_dana'] = sumberDana;
    map['pemilihan_awal'] = pemilihanAwal;
    map['pemilihan_akhir'] = pemilihanAkhir;
    map['pekerjaan_awal'] = pekerjaanAwal;
    map['pekerjaan_akhir'] = pekerjaanAkhir;
    map['nama_penyedia'] = namaPenyedia;
    map['metode_pengadaan'] = metodePengadaan;
    map['pagu_pengadaan'] = paguPengadaan;
    map['hps_pengadaan'] = hpsPengadaan!= null ? hpsPengadaan : " ";
    map['nilai_kontrak'] = nilaiKontrak!= null ? nilaiKontrak : " ";
    map['sisa_anggaran'] = sisaAnggaran;
    map['usulan_status'] = usulanStatus; 
    final response = await http.post(ROOT, body:map);
    print ("addProses Response: ${response.body}");
    if(200 == response.statusCode){
      // return response.body;
     return "success";
     
    }else{
      print('else error');
      return "error";
     
    }
  }catch(e){
   print('catchr error');
    return "catch error";
    
  }
}


static Future<String> updateProses(String proId,
  String namaUnit, 
  String namaPengadaan,
  String jenisPengadaan, 
  String tanggal,
  String bulan,
  String tahun,
  String volume,
  String sumberDana,
  String pemilihanAwal,
  String pemilihanAkhir,
  String pekerjaanAwal,
  String pekerjaanAkhir,
  String namaPenyedia,
  String metodePengadaan,
  String paguPengadaan,
  String hpsPengadaan,
  String nilaiKontrak,
  String sisaAnggaran,
  String usulanStatus,
  ) async{
  try{
    print(namaUnit);
     print(namaPengadaan);
     print(jenisPengadaan);
     print(tanggal);
     print(bulan);
     print(tahun);
     print(volume);
     print(sumberDana);
     print(pemilihanAwal);
     print(pemilihanAkhir);
     print(pekerjaanAwal);
     print(pekerjaanAkhir);
     print(namaPenyedia);
     print(metodePengadaan);
     print(paguPengadaan);
     print(hpsPengadaan);
     print(nilaiKontrak);
     print(sisaAnggaran);
     print(usulanStatus);
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_PRO_ACTION;
    map['pro_id'] = proId;
    map['nama_unit'] = namaUnit;
    map['nama_pengadaan'] = namaPengadaan;
    map['jenis_pengadaan'] = jenisPengadaan != null ? jenisPengadaan : " ";
    map['tanggal'] = tanggal != null ? tanggal : " ";
    map['bulan'] = bulan != null ? bulan : " ";
    map['tahun'] = tahun != null ? tahun : " ";
    map['volume'] = volume;
    map['sumber_dana'] = sumberDana;
    map['pemilihan_awal'] = pemilihanAwal;
    map['pemilihan_akhir'] = pemilihanAkhir;
    map['pekerjaan_awal'] = pekerjaanAwal;
    map['pekerjaan_akhir'] = pekerjaanAkhir;
    map['nama_penyedia'] = namaPenyedia;
    map['metode_pengadaan'] = metodePengadaan!= null ? metodePengadaan : " ";
    map['pagu_pengadaan'] = paguPengadaan;
    map['hps_pengadaan'] = hpsPengadaan!= null ? hpsPengadaan : " ";
    map['nilai_kontrak'] = nilaiKontrak!= null ? nilaiKontrak : " ";
    map['sisa_anggaran'] =  sisaAnggaran;
    map['usulan_status'] = usulanStatus;
    
    final response = await http.post(ROOT, body: map);
    print("updateProses Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> updateProsesPPK(String proId,
  String namaUnit, 
  String namaPengadaan,
  String jenisPengadaan, 
  String tanggal,
  String bulan,
  String tahun,
  String volume,
  String sumberDana,
  String pemilihanAwal,
  String pemilihanAkhir,
  String pekerjaanAwal,
  String pekerjaanAkhir,
  String namaPenyedia,
  String metodePengadaan,
  String paguPengadaan,
  String hpsPengadaan,
  String nilaiKontrak,
  String sisaAnggaran,
  String usulanStatus,
  ) async{
  try{
    print(namaUnit);
     print(namaPengadaan);
     print(jenisPengadaan);
     print(tanggal);
     print(bulan);
     print(tahun);
     print(volume);
     print(sumberDana);
     print(pemilihanAwal);
     print(pemilihanAkhir);
     print(pekerjaanAwal);
     print(pekerjaanAkhir);
     print(namaPenyedia);
     print(metodePengadaan);
     print(paguPengadaan);
     print(hpsPengadaan);
     print(nilaiKontrak);
     print(sisaAnggaran);
     print(usulanStatus);
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_PRO_ACTION;
    map['pro_id'] = proId;
    map['nama_unit'] = namaUnit;
    map['nama_pengadaan'] = namaPengadaan;
    map['jenis_pengadaan'] = jenisPengadaan != null ? jenisPengadaan : " ";
    map['tanggal'] = tanggal != null ? tanggal : " ";
    map['bulan'] = bulan != null ? bulan : " ";
    map['tahun'] = tahun != null ? tahun : " ";
    map['volume'] = volume;
    map['sumber_dana'] = sumberDana;
    map['pemilihan_awal'] = pemilihanAwal;
    map['pemilihan_akhir'] = pemilihanAkhir;
    map['pekerjaan_awal'] = pekerjaanAwal;
    map['pekerjaan_akhir'] = pekerjaanAkhir;
    map['nama_penyedia'] = namaPenyedia;
    map['metode_pengadaan'] = metodePengadaan!= null ? metodePengadaan : " ";
    map['pagu_pengadaan'] = paguPengadaan;
    map['hps_pengadaan'] = hpsPengadaan;
    map['nilai_kontrak'] = nilaiKontrak;
    map['sisa_anggaran'] =  sisaAnggaran;
    map['usulan_status'] = usulanStatus;
    
    final response = await http.post(ROOT, body: map);
    print("updateProses Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      
      return "error";
    }
  }catch(e){
    return "error";
  }
}


static Future<String> deleteProses(String proId) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _DELETE_PRO_ACTION;
    map['pro_id'] = proId;
    final response = await http.post(ROOT, body: map);
    print("deleteProses Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> getPro1({String tahun}) async {
  
    String newUrl = ROOT+"?tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_PENGADAAN_LANGSUNG;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("getPengadaanLangsung Response: ${response.body}");
     if (response.statusCode == 200){
       final parsed = json.decode(response.body);
      String pro1 = parsed.toString();
      print(pro1);
      return pro1.toString();
    }
    
  }
static Future<String> getPro2({String tahun}) async {
  
    String newUrl = ROOT+"?tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_PENUNJUKAN_LANGSUNG;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Penunjukkan Langsung Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String pro2 = parsed.toString();
    print(pro2);
    return pro2.toString();
    }
    
  }
static Future<String> getPro3({String tahun}) async {
  
    String newUrl = ROOT+"?tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TENDER_CEPAT;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Cepat Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String pro3 = parsed.toString();
    print(pro3);
    return pro3.toString();
    }
    
  }      
static Future<String> getPro4({String tahun}) async {
  
    String newUrl = ROOT+"?tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TENDER;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String pro4 = parsed.toString();
    print(pro4);
    return pro4.toString();
    }
    
  }
  static Future<String> getPro5({String tahun}) async {
  
    String newUrl = ROOT+"?tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_EKATALOG;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String pro4 = parsed.toString();
    print(pro4);
    return pro4.toString();
    }
    
  }
//total perbulan dan tahun
static Future<String> getProTot1({String bulan,String tahun}) async {
  
    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TOT_PENGADAAN_LANGSUNG;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String protot1 = parsed.toString();
    print(protot1);
    return protot1.toString();
    }
    
  }  
  static Future<String> getProTot2({String bulan,String tahun}) async {
  
    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TOT_PENUNJUKAN_LANGSUNG;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String protot2 = parsed.toString();
    print(protot2);
    return protot2.toString();
    }
    
  }  
  static Future<String> getProTot3({String bulan,String tahun}) async {
  
    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TOT_TENDER_CEPAT;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String protot3 = parsed.toString();
    print(protot3);
    return protot3.toString();
    }
    
  }  
  static Future<String> getProTot4({String bulan,String tahun}) async {
  
    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TOT_TENDER;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get Tender Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String protot4 = parsed.toString();
    print(protot4);
    return protot4.toString();
    }
    
  } 
  static Future<String> getProTot5({String bulan,String tahun}) async {
  
    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map['action'] = _GET_TOT_EKAT;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print("get EKATPROTOT Response: ${response.body}");
    if (response.statusCode == 200){
    final parsed = json.decode(response.body);
    String protot5 = parsed.toString();
    print(protot5);
    return protot5.toString();
    }
    
  }   


//total keseluruhan
static Future<void> getRekapPengadaan({String bulan, String tahun, String metodePengadaan ,Function callback}) async {

    String newUrl = ROOT+"?metode_pengadaan="+metodePengadaan+"&bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map["action"] = _GET_REKAP;
    map["metode_pengadaan"] = metodePengadaan;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print ("getRekap Response: ${response.body}");
    if (200 == response.statusCode){
      List<Laporan> list = parseResponse1(response.body);
      callback(list);
    }else{
      callback(List());
    }
}
static Future<void> getRekapEkatalog({String bulan, String tahun, Function callback}) async {

    String newUrl = ROOT+"?bulan="+bulan+"&tahun="+tahun;
    var map = Map<String, dynamic>();
    map["action"] = _GET_REKAP;
    map["bulan"] = bulan;
    map["tahun"] = tahun;
    final response = await http.post(newUrl, body:map);
    print ("getRekap Response: ${response.body}");
    if (200 == response.statusCode){
      List<Laporan> list = parseResponse1(response.body);
      callback(list);
    }else{
      callback(List());
    }
}

//EKATALOG_ACTION.PH
}