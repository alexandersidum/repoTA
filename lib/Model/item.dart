class Item {

  String id;
  String judul;
  String unit;
  String tanggal;
  
//monitoring pengadaan

  Item({this.id,this.judul, this.unit,this.tanggal});


  factory Item.fromDb(Map<String, dynamic> parsedData, String docId){
    return(
      Item(
        id : docId,
        judul: parsedData.isNotEmpty&&parsedData['judul']!=null?parsedData['judul']:"",
        unit :  parsedData.isNotEmpty&&parsedData['unit']!=null?parsedData['unit']:"",
        tanggal: parsedData.isNotEmpty&&parsedData['tanggal']!=null?parsedData['tanggal']:"",
      ));

  }

  Map<String , dynamic> toMap(){
    return{
      'judul' : this.judul,
      'unit' : this.unit,

    };
  }

}