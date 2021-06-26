import 'dart:convert';
import 'package:exemplo_dmii/filme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

const URL = 'lpiv-maruyama-backend.herokuapp.com';

Future<Filme> buscarFilmePorId(int id) async{
  final response = await http.get(Uri.https(URL, 'ws/filme/$id'));
  if(response.statusCode == 200){
    return Filme.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }else{
    throw Exception(response.body);
  }
}

Future<List<Filme>> listFilmes() async{
  final response = await http.get(Uri.https(URL, 'ws/filme'));
  if(response.statusCode == 200){
    return compute(parseFilme, utf8.decode(response.bodyBytes));
  }else{
    throw Exception(response.body);
  }
}

List<Filme> parseFilme(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<Filme>((json) => Filme.fromJson(json)).toList();
}

Future<void> salvarFilme(filme) async{
  final response = await http.post(Uri.https(URL, 'ws/filme'),
      headers: <String,String>{
        'Content-Type':'application/json'
      },
      body: jsonEncode(filme.toJson())
  );

  if (response.statusCode != 200){
    throw Exception(response.body);
  }
}