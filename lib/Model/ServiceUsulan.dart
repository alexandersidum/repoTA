import 'dart:convert';
import 'package:Monitoring/Model/UsulanStatus.dart';
import 'package:http/http.dart'
  as http;
// import 'UsulanStatus.dart';

class ServiceUsulan{
  static const ROOT = 'http://monitoringpengadaam.000webhostapp.com/EkatalogDB/usulan_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_STAT = 'GET_STAT';
  static const _ADD_STAT = 'ADD_STAT';
  // static const _UPDATE_REK_ACTION = 'UPDATE_REK';
  // static const _DELETE_REK_ACTION = 'DELETE_REK';

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
static Future<void> getUsulan({String role, Function callback}) async {
  
    String newUrl = ROOT+"?rolee="+role;
    var map = Map<String, dynamic>();
    map['action'] = _GET_STAT;
    map['rolee'] = role;
    final response = await http.post(newUrl, body:map);
    print("getUsulan Response: ${response.body}");
    if(200 == response.statusCode){
      List<UsulanStatus> list = parseResponse(response.body);
      callback(list);
    }else{
      callback(List());
    }
}
static List<UsulanStatus> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<UsulanStatus>((json) =>UsulanStatus.fromJson(json)).toList();
}

static Future<String> addStatus(String role, String usulanStatus) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_STAT;
    map['rolee'] = role;
    map['usulan_status'] = usulanStatus;
    
  
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

}