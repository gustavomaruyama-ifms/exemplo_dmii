import 'package:flutter/material.dart';
import 'form_novo_filme.dart';
import 'listview_filmes.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(context) => ListViewFilmes(),
          '/novo-filme': (context) => FormNovoFilme(),
        }
    );
  }
}


