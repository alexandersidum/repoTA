import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'
  as http;
import 'prosesKegiatan.dart';

class ServicePengadaan{
  static const ROOT = 'http://192.168.100.168/EkatalogDB/pengadaan_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_PRO_ACTION = 'GET_PRO';
  static const _ADD_PRO_ACTION = 'ADD_PRO';
  static const _UPDATE_PRO_ACTION = 'UPDATE_PRO';
  static const _DELETE_PRO_ACTION = 'DELETE_PRO';


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
static Future<List<Proses>> getProses() async {
  try{
    var map = Map<String, dynamic>();
    map["action"] = _GET_PRO_ACTION;
    final response = await http.post(ROOT, body:map);
    print ("getProses Response: ${response.body}");
    if (200 == response.statusCode){
      List<Proses> list = parseResponse(response.body);
      return list;
    }else{
      return List<Proses>();
    }
  }catch(e){
    return List<Proses>();
  }

}
static List<Proses> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Proses>((json) =>Proses.fromJson(json)).toList();
}

static Future<String> addProses(String namaPengadaan,  String metodePengadaan, String paguPengadaan, String hpsPengadaan, String tanggalPengadaan, String usulanStatus) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_PRO_ACTION;
    map['nama_pengadaan'] = namaPengadaan;
    map['metode_pengadaan'] = metodePengadaan;
    map['pagu_pengadaan'] = paguPengadaan;
    map['hps_pengadaan'] = hpsPengadaan;
    map['tanggal_pengadaan'] = tanggalPengadaan;
    map['usulan_status'] = usulanStatus; 
    final response = await http.post(ROOT, body:map);
    print ("addProses Response: ${response.body}");
    if(200 == response.statusCode){
     return response.body;
    }else{
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> updateProses(String proId, String namaPengadaan, String metodePengadaan, String paguPengadaan, String  hpsPengadaan, String tanggalPengadaan, String usulanStatus) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_PRO_ACTION;
    map['pro_id'] = proId;
    map['nama_pengadaan'] = namaPengadaan;
    map['metode_pengadaan'] = metodePengadaan;
    map['pagu_pengadaan'] = paguPengadaan;
    map['hps_pengadaan'] = hpsPengadaan;
    map['tanggal_pengadaan'] = tanggalPengadaan;
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

}