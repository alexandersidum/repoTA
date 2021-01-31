import 'dart:convert';
import 'package:Monitoring/Model/UnitEntry.dart';
import 'package:http/http.dart'
  as http;
// import 'UsulanStatus.dart';

class ServiceUnit{
  static const ROOT = 'http://monitoringpengadaam.000webhostapp.com/EkatalogDB/entryUnit_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_UNIT = 'GET_UNIT';
  static const _ADD_UNIT = 'ADD_UNIT';


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
static Future<void>getUnit(Function callback) async {
 
    var map = Map<String, dynamic>();
    map['action'] = _GET_UNIT;
    final response = await http.post(ROOT, body:map);
    print("getRekap Response: ${response.body}");
    if(200 == response.statusCode){
      List<Unit> list = parseResponse(response.body);
      callback(list);
    }else{
      callback(List());
    }  
  }


static List<Unit> parseResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Unit>((json) =>Unit.fromJson(json)).toList();
}

static Future<String> addUnit(String unit) async{
   try{
    var map = Map<String, dynamic>();
    map['action'] = _ADD_UNIT;
    map['unit'] = unit;
  
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