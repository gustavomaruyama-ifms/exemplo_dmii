import 'package:exemplo_dmii/filme_services.dart';
import 'package:flutter/material.dart';

import 'filme.dart';

class ListTileFilmes extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _ListTileFilmesState();
  }
}

class _ListTileFilmesState extends State<ListTileFilmes>{
  Widget build(context){
    return Scaffold(
        appBar: AppBar(title: Text("Filme")),
        body: _buildFuture(),
    );
  }

  Widget _buildFuture() {
    return FutureBuilder(
        future: buscarFilmePorId(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Filme filme = snapshot.data as Filme;
            return ListTile(
              title: Text(filme.titulo),
              subtitle: Text(filme.genero),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}