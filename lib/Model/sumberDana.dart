class SumberDana{

  String id;
  String sumberDana;
  
  SumberDana({this.id ,this.sumberDana});


  factory SumberDana.fromJson(Map<String, dynamic> json){
    return(
      SumberDana(
        id: json['id'] as String,
        sumberDana: json['sumber_dana'] 
      ));

  }

}