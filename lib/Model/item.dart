class Item {

  String id;
  String judul;
  String unit;
  String tanggal;//awal pelaksanaan pemilihan
  // String tanggalAkhir;//akhir pelaksanaan pemilihan
  // String tanggalAwalPek;//awal pelaksanaan pekerjaan
  // String tanggalAkPek;// akhir pelaksanaan pekerjaan
  String volume;
  String sumberDana;
  String metodePemilihan;

  
//monitoring pengadaan

  Item({this.id,this.judul, this.unit,this.tanggal,
  // this.tanggalAkhir,
  // this.tanggalAwalPek,
  // this.tanggalAkPek,
   this.volume, this.sumberDana, this.metodePemilihan});


  factory Item.fromDb(Map<String, dynamic> parsedData, String docId){
    return(
      Item(
        id : docId,
        judul: parsedData.isNotEmpty&&parsedData['judul']!=null?parsedData['judul']:"",
        unit :  parsedData.isNotEmpty&&parsedData['unit']!=null?parsedData['unit']:"",
        tanggal: parsedData.isNotEmpty&&parsedData['tanggal']!=null?parsedData['tanggal']:"",
        // tanggalAkhir: parsedData.isNotEmpty&&parsedData['tanggalAkhir']!=null?parsedData['tanggalAkhir']:"",
        // tanggalAwalPek: parsedData.isNotEmpty&&parsedData['tanggalAwalPek']!=null?parsedData['tanggalAwalPek']:"",
        // tanggalAkPek: parsedData.isNotEmpty&&parsedData['tanggalAkPek']!=null?parsedData['tanggalAkPek']:"",
        volume: parsedData.isNotEmpty&&parsedData['volume']!=null?parsedData['volume']:"",
        sumberDana: parsedData.isNotEmpty&&parsedData['sumberDana']!=null?parsedData['sumberDana']:"",
        metodePemilihan: parsedData.isNotEmpty&&parsedData['metodePemilihan']!=null?parsedData['metodePemilihan']:"",
      ));

  }

  Map<String , dynamic> toMap(){
    return{
      'judul' : this.judul,
      'unit' : this.unit,

    };
  }

}