import 'dart:convert';
import 'package:http/http.dart'
  as http;
import 'ekatalog.dart';

class ServiceEkatalog{
  static const ROOT = 'http://monitoringpengadaam.000webhostapp.com/EkatalogDB/ekatalog_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_LPSE_ACTION = 'GET_LPSE';
  static const _ADD_CATALOG = 'ADD_CAT';


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
// static Future<List<Lpse>> getLpse() async {
//   try{
//     var map = Map<String, dynamic>();
//     map["action"] = _GET_LPSE_ACTION;
//     final response = await http.post(ROOT, body:map);
//     print ("getLpse Response: ${response.body}");
//     if(200 == response.statusCode){
//       List<Lpse> list = parseResponse(response.body);
//       return list;
//     }else{
//       return List<Lpse>();
//     }
//   }catch(e){
//     return List<Lpse>();
//   }

// }
// static List<Lpse> parseResponse(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Lpse>((json) =>Lpse.fromJson(json)).toList();
// }


}