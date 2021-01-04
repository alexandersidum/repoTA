import 'dart:convert';
import 'package:http/http.dart'
  as http;
import 'lpse.dart';

class ServiceLpse{
  static const ROOT = 'http://192.168.100.170/EkatalogDB/lpse_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_LPSE_ACTION = 'GET_LPSE';
  static const _ADD_LPSE_ACTION = 'ADD_LPSE';
  static const _UPDATE_LPSE_ACTION = 'UPDATE_LPSE';
  static const _DELETE_LPSE_ACTION = 'DELETE_LPSE';

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
static Future<List<Lpse>> getLpse() async {
  try{
    var map = Map<String, dynamic>();
    map["action"] = _GET_LPSE_ACTION;
    final response = await http.post(ROOT, body:map);
    print ("getLpse Response: ${response.body}");
    if(200 == response.statusCode){
      List<Lpse> list = parseResponse(response.body);
      return list;
    }else{
      return List<Lpse>();
    }
  }catch(e){
    return List<Lpse>();
  }

}
static List<Lpse> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Lpse>((json) =>Lpse.fromJson(json)).toList();
}

static Future<String> addLpse(String namaPaket, String jenisPengadaan, String statusPengadaan) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_LPSE_ACTION;
    map['nama_paket'] = namaPaket;
    map['jenis_pengadaan'] = jenisPengadaan;
    map['status_pengadaan'] = statusPengadaan;
    final response = await http.post(ROOT, body:map);
    print ("addLpse Response: ${response.body}");
    if(200 == response.statusCode){
     return response.body;
    }else{
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> updateLpse(String lpseId, String namaPaket, String jenisPengadaan, String statusPengadaan) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_LPSE_ACTION;
    map['lpse_id'] = lpseId;
    map['nama_paket'] = namaPaket;
    map['jenis_pengadaan'] = jenisPengadaan;
    map['status_pengadaan'] = statusPengadaan;
    final response = await http.post(ROOT, body: map);
    print("updateLpse Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> deleteLpse(String lpseId) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _DELETE_LPSE_ACTION;
    map['lpse_id'] = lpseId;
    final response = await http.post(ROOT, body: map);
    print("deleteLpse Response : ${response.body}");
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