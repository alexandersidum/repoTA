class Lpse {

  String id;
  String namaPaket;
  String jenisPengadaan;
  String statusPengadaan;
  
//monitoring Lpse



  Lpse({this.id, this.namaPaket, this.jenisPengadaan, this.statusPengadaan});


  factory Lpse.fromJson(Map<String, dynamic> json){
    return(
      Lpse(
        id: json['id'] as String,
        namaPaket: json['nama_paket'],
        jenisPengadaan: json['jenis_pengadaan'],
        statusPengadaan: json['status_pengadaan'],
      ));

  }
}