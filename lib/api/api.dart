import 'dart:convert';
import 'package:easy_blood/constant/constant.dart' as constant;
import 'package:http/http.dart' as http;

class Api{

  postData(data, apiURL) async{
    var fullURL = constant.apiURL + apiURL;
    return await http.post(
      fullURL,
      headers: _reqHeader(),
      body: jsonEncode(data),
    );
  }

  updateData(data, apiURL) async{
    var fullURL = constant.apiURL + apiURL;
    return await http.put(
      fullURL,
      headers: _reqHeader(),
      body: jsonEncode(data),
    );
  }

  getData(apiURL) async {
    var fullURL = constant.apiURL + apiURL;
    return await http.get(
      fullURL,
      headers: _reqHeader()
    );
  }

  deleteData(apiURL) async{
    var fullURL = constant.apiURL + apiURL;
    return await http.delete(
      fullURL,
      headers: _reqHeader(),
    );
  }
   _reqHeader() =>{
     'Content-Type': 'application/json',
     'Accept' : 'application/json',
   };
}