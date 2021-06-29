import 'dart:convert';
import 'package:exemplo_dmii/filme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

const URL = 'lpiv-maruyama-backend.herokuapp.com';

Future<Filme> buscarFilmePorId(int id) async{
  final response = await http.get(Uri.https(URL, 'ws/filme/$id'));
  if(response.statusCode == 200){
    final utf8Json = utf8.decode(response.bodyBytes);
    Map<String, dynamic> mapFilme = jsonDecode(utf8Json);
    Filme filme = Filme.fromJson(mapFilme);
    return filme;
  }else{
    throw Exception(response.body);
  }
}

Future<List<Filme>> listarFilmes() async{
  final response = await http.get(Uri.https(URL, 'ws/filme'));
  if(response.statusCode == 200){
    final utf8Json = utf8.decode(response.bodyBytes);
    return compute(parseFilmes, utf8Json);
  }else{
    throw Exception(response.body);
  }
}

List<Filme> parseFilmes(String responseBody){
  final mapFilmes = jsonDecode(responseBody);
  return mapFilmes.map<Filme>((mapJson){
    return Filme.fromJson(mapJson);
  }).toList();
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