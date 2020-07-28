import 'dart:convert';

import 'package:http/http.dart' as http;

class Api{
  final String apiLink = "http://192.168.1.8:8000/";

  postData(data, apiURL) async{
    var fullURL = apiLink + apiURL;
    return await http.post(
      fullURL,
      headers: _reqHeader(),
      body: jsonEncode(<String, String>{
        'title': "jejeje",
      }),

    );
  }

  getData() async {
    var fullURL = "http://192.168.1.8:8000/event";
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