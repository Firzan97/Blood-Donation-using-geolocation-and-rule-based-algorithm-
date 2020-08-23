import 'dart:convert';

import 'package:http/http.dart' as http;

class Api{
  final String apiLink = "http://192.168.1.2:8000/api/";

  postData(data, apiURL) async{
    var fullURL = apiLink + apiURL;
    return await http.post(
      fullURL,
      headers: _reqHeader(),
      body: jsonEncode(data),
    );
  }

  getData() async {
    var fullURL = "http://192.168.1.2:8000/api/";
    return await http.get(
      fullURL,
      headers: _reqHeader()
    );
  }

   _reqHeader() =>{
     'Content-Type': 'application/json',
     'Accept' : 'application/json',
   };
}