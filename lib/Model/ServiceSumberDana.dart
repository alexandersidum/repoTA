import 'dart:convert';
import 'package:Monitoring/Model/sumberDana.dart';
import 'package:http/http.dart'
  as http;
// import 'UsulanStatus.dart';

class ServiceSumberDana{
  static const ROOT = 'http://monitoringpengadaam.000webhostapp.com/EkatalogDB/sumberDana_action.php';
  static const _GET_DANA = 'GET_DANA';
  static const _ADD_DANA = 'ADD_DANA';
  // static const _UPDATE_REK_ACTION = 'UPDATE_REK';
  // static const _DELETE_REK_ACTION = 'DELETE_REK';

static Future<void> getDana(Function callback) async {
  
    
    var map = Map<String, dynamic>();
    map['action'] = _GET_DANA;
    final response = await http.post(ROOT, body:map);
    print("getUsulan Response: ${response.body}");
    if(200 == response.statusCode){
      List<SumberDana> list = parseResponse(response.body);
      callback(list);
    }else{
      callback(List());
    }
}
static List<SumberDana> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<SumberDana>((json) =>SumberDana.fromJson(json)).toList();
}

static Future<String> addDana( String sumberDana) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_DANA;
    map['sumber_dana'] = sumberDana;
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