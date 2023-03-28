import 'package:http/http.dart' as http;
import 'package:frontend/singlequery.dart';
import 'dart:convert';

class Queryservice {
  List<Singlequery> _queriesml = [];
  List<Singlequery> temp = [];
  Future<List<Singlequery>> fetchjson() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var res = await http.get("http://localhost:8080/queriesml");
    // print(res.body);
    List<Singlequery> queriesml = [];
    _queriesml = [];
    if (res.statusCode == 200) {
      var queriesjson = json.decode(res.body);
      for (var Singlequeryjson in queriesjson) {
        queriesml.add(Singlequery.fromJson(Singlequeryjson));
      }
    }
    return queriesml;
  }
}
