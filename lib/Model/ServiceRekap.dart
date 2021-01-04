import 'dart:convert';
import 'package:http/http.dart'
  as http;
import 'rekap.dart';

class ServiceRekap{
  static const ROOT = 'http://192.168.100.170/EkatalogDB/rekap_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_REK_ACTION = 'GET_REK';
  static const _ADD_REK_ACTION = 'ADD_REK';
  static const _UPDATE_REK_ACTION = 'UPDATE_REK';
  static const _DELETE_REK_ACTION = 'DELETE_REK';

static Future<String> createTable() async {
  try{
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(ROOT, body: map);
    print("Create Table Response : ${response.body}");
    // if(200 == response.statusCode){
      return response.body;
    // } else {
    //   return "error";
    // }
  }catch (e){
   return "error";
  }
}
static Future<List<Rekap>> getRekap() async {
  try{
    var map = Map<String, dynamic>();
    map['action'] = _GET_REK_ACTION;
    final response = await http.post(ROOT, body:map);
    print("getRekap Response: ${response.body}");
    if(200 == response.statusCode){
      List<Rekap> list = parseResponse(response.body);
      return list;
    }else{
      return List<Rekap>();
    }
  }catch(e){
    return List<Rekap>();
  }

}
static List<Rekap> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Rekap>((json) =>Rekap.fromJson(json)).toList();
}

static Future<String> addRekap(String namaPengadaans, String totalPengadaan) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_REK_ACTION;
    map['nama_pengadaans'] = namaPengadaans;
    map['total_pengadaan'] = totalPengadaan;
    final response = await http.post(ROOT, body:map);
    print("addRekap Response: ${response.body}");
    if(200 == response.statusCode){
     return response.body;
    }else{
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> updateRekap(String rekId, String namaPengadaans, String totalPengadaan) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_REK_ACTION;
    map['rek_id'] = rekId;
    map['nama_pengadaans'] = namaPengadaans;
    map['total_pengadaan'] = totalPengadaan;
    final response = await http.post(ROOT, body: map);
    print("updateRekap Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> deleteRekap(String rekId) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _DELETE_REK_ACTION;
    map['rek_id'] = rekId;
    final response = await http.post(ROOT, body: map);
    print("deleteRekap Response : ${response.body}");
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