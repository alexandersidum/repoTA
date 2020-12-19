class Item {


  String judul;
  String isi;
  String namaunit;
  
//monitoring pengadaan



  Item({this.judul, this.isi, this.namaunit,});


  factory Item.fromDb(Map<String, dynamic> parsedData){
    return(
      Item(
        judul: parsedData['judul'],
        isi: parsedData['isi'],
        namaunit : parsedData['namaunit'],
      ));

  }

  Map<String , dynamic> toMap(){
    return{
      'judul' : this.judul,
      'isi' : this.isi,
      'namaunit' : this.namaunit,

    };
  }

}