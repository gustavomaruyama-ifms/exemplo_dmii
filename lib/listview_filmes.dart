import 'package:exemplo_dmii/filme_services.dart';
import 'package:flutter/material.dart';

import 'filme.dart';

class ListViewFilmes extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _ListViewFilmesState();
  }
}

class _ListViewFilmesState extends State<ListViewFilmes>{
  List<Filme> _filmes = [];

  Widget build(context){
    return Scaffold(
        appBar: AppBar(title: Text("Filmes")),
        body: _buildFuture(),
        floatingActionButton: _buildBotaoAdd()
    );
  }

  Widget _buildFuture() {
    return FutureBuilder(
        future: listarFilmes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this._filmes = snapshot.data as List<Filme>;
            return _listViewBuilder();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget _buildBotaoAdd(){
    return FloatingActionButton(
      child:Icon(Icons.add),
      onPressed: () async{
        await Navigator.pushNamed(this.context,'/novo-filme');
        setState((){});
      },
    );
  }

  Widget _listViewBuilder(){
    return ListView.separated(
      itemCount: _filmes.length,
      itemBuilder: _itemBuilder,
      separatorBuilder: _separatorBuilder,
    );
  }

  Widget _itemBuilder(context, index){
    Filme filme = _filmes[index];
    return ListTile(
        title: Text(filme.titulo),
        subtitle: Text(filme.genero),
    );
  }

  Widget _separatorBuilder(context, index){
    return Divider();
  }
}