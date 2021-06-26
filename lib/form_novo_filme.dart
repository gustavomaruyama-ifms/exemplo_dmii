import 'package:exemplo_dmii/filme_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filme.dart';

class FormNovoFilme extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _FormNovoFilmeState();
  }
}

class _FormNovoFilmeState extends State<FormNovoFilme>{
  TextEditingController nomeController = TextEditingController();
  TextEditingController generoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool criando = false;

  Widget build(context){
    return Scaffold(
      appBar: AppBar(title:Text("Novo Filme")),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: criando? Center(child: CircularProgressIndicator()): _buildForm()
      ),
      floatingActionButton: criando? null:_buildBotaoSalvar(),
    );
  }

  Widget _buildForm(){
    return Form(
        key: _formKey,
        child: Column(
            children:[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                    labelText:"Título"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o título do Filme';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextFormField(
                controller: generoController,
                decoration: InputDecoration(
                    labelText:"Gênero"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o Gênero do Filme';
                  }
                  return null;
                },
              )
            ]
        )
    );
  }

  Widget _buildBotaoSalvar(){
    return FloatingActionButton(
        child:Icon(Icons.check),
        onPressed:() async{
          if (_formKey.currentState!.validate()) {
            setState(() {
              criando = true;
            });

            var filme = Filme();
            filme.titulo = nomeController.text.toString();
            filme.genero= generoController.text.toString();

            await salvarFilme(filme);
            _mostrarSnackBar();

            setState(() {
              criando = false;
            });
            Navigator.pop(this.context);
          }
        }
    );
  }

  void _mostrarSnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Filme adicionado!"),
      ),
    );
  }
}