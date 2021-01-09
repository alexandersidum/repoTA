class Rekap {

  String id;
  String tahun;
  String namaPengadaans;
  String totalPengadaan;
  
//monitoring rekap
  static  List<String> listTahun =  ['2018', '2019', '2020', '2021'];


  Rekap({this.id, this.tahun, this.namaPengadaans, this.totalPengadaan});


  factory Rekap.fromJson(Map<String, dynamic> json){
    return(
      Rekap(
        id: json['id'] as String,
        tahun: json['tahun'],
        namaPengadaans: json['nama_pengadaans'],
        totalPengadaan: json['total_pengadaan'],
       
      ));

  }
}