class Ekatalog {

  String id;
  String namaUnit;
  String tanggal;
  String jumlahTransaksi;
  
//monitoring pengadaan

  static  List<String> listYear =  ['2018', '2019', '2020', '2021'];

  Ekatalog({this.id, this.namaUnit,this.tanggal, this.jumlahTransaksi});


  factory Ekatalog.fromJson(Map<String, dynamic> json){
    return(
      Ekatalog(
        id: json['id'] as String,
        namaUnit: json['nama_unit'] ,
        tanggal: json['tanggal'] ,
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
