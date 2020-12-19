class Rekap {

  String id;
  String namaPengadaans;
  String totalPengadaan;
  
//monitoring rekap



  Rekap({this.id, this.namaPengadaans, this.totalPengadaan});


  factory Rekap.fromJson(Map<String, dynamic> json){
    return(
      Rekap(
        id: json['id'] as String,
        namaPengadaans: json['nama_pengadaans'],
        totalPengadaan: json['total_pengadaan'],
       
      ));

  }
}