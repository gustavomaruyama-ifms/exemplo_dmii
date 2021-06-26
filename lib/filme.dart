class Filme{
  int id;
  String titulo;
  String genero;
  Filme({this.id = 0, this.titulo ="",this.genero=""});

  factory Filme.fromJson(Map<String, dynamic> json){
    return Filme(
      id: json['id'],
      titulo: json['titulo'],
      genero: json['genero']
    );
  }

  Map<String, String> toJson(){
    return{
      'id': this.id.toString(),
      'titulo': this.titulo,
      'genero': this.genero
    };
  }
}