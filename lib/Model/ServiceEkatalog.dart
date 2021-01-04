import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Ekatalog.dart';


class ServiceEkat {
  static const ROOT = 'http://192.168.100.170/EkatalogDB/ekatalog_action.php';
  static const _CREATE_TABLE = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_CAT';
  static const _ADD_CAT_ACTION = 'ADD_CAT';
  static const _UPDATE_CAT_ACTION = 'UPDATE_CAT';
  static const _DELETE_CAT_ACTION = 'DELETE_CAT';



static Future<String> createTable1() async {
  try{
    // print(ROOT);
    var map = Map<String, dynamic>();
    map["action"] = _CREATE_TABLE;
    final response = await http.post(ROOT, body: map);
    print('Create Table >> Response : ${response.body}');
      if (200 == response.statusCode){
      return response.body;
     }else{
       return "error";
     }
  }catch (e){
   return "error";
  }
}

static Future<List<Ekatalog>> getEkatalog() async {
  try{
    var map = Map<String, dynamic>();
    map['action'] = _GET_ALL_ACTION;
    final response = await http.post(ROOT, body:map);
    print("getEkatalog Response: ${response.body}");
     if (response.statusCode == 200){
      List<Ekatalog> list = parseResponse(response.body);
      return list;
    }else{
      throw List<Ekatalog>();
    }
  }catch(e){
    return List<Ekatalog>();
  }

}


static List<Ekatalog> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Ekatalog>((json) =>Ekatalog.fromJson(json)).toList();
}

static Future<String> addEkatalog(String namaUnit, String jumlahTransaksi) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_CAT_ACTION;
    map['nama_unit'] = namaUnit;
    map['jumlah_transaksi'] = jumlahTransaksi;
    final response = await http.post(ROOT, body:map);
    print("berhasil");
    print("addEkatalog Response: ${response.body}");
     if (response.statusCode == 200){
     return response.body;
     
    }else{
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> updateEkatalog(String catId, String namaUnit, String jumlahTransaksi ) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _UPDATE_CAT_ACTION;
    map['cat_id'] = catId;
    map['nama_unit'] = namaUnit;
    map['jumlah_transaksi'] = jumlahTransaksi;
    final response = await http.post(ROOT, body: map);
    print("updateEkatalog Response : ${response.body}");
    if(200 == response.statusCode){
      return response.body;
    } else {
      return "error";
    }
  }catch(e){
    return "error";
  }
}
static Future<String> deleteEkatalog(String catId) async{
  try{
    var map = Map<String,dynamic>();
    map['action'] = _DELETE_CAT_ACTION;
    map['cat_id'] = catId;
    final response = await http.post(ROOT, body: map);
    print("deleteEkatalog Response : ${response.body}");
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