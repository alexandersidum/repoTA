class Unit{

  String id;
  String unit;
  
  Unit({this.id ,this.unit});


  factory Unit.fromJson(Map<String, dynamic> json){
    return(
      Unit(
        id: json['id'] as String,
        unit: json['unit'] 
      ));

  }

}
