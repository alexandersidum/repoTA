class Ekatalog {

  String id;
  String namaUnit;
  String jumlahTransaksi;
  
//monitoring pengadaan



  Ekatalog({this.id, this.namaUnit, this.jumlahTransaksi});


  factory Ekatalog.fromJson(Map<String, dynamic> json){
    return(
      Ekatalog(
        id: json['id'] as String,
        namaUnit: json['nama_unit'] ,
        jumlahTransaksi: json['jumlah_transaksi'],
      ));

  }

  // Map<String , dynamic> toMap(){
  //   return{
  //     'id' : this.id,
  //     'nama_unit' : this.namaUnit,
  //     'priceeka'  : this.jumlahTransaksi,

  //   };
 // }

}
