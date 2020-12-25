class  Proses{

  String id;
  String namaPengadaan;
  String namaPenyedia;
  String metodePengadaan;
  String paguPengadaan;
  String hpsPengadaan;
  String tanggalPengadaan;
  String total;
  String usulanStatus;

 //belumterlaksana
  
//monitoring proeses pengadaan



  Proses({this.id, this.namaPengadaan, this.namaPenyedia, this.metodePengadaan, this.paguPengadaan, this.hpsPengadaan, this.tanggalPengadaan, this.total, this.usulanStatus});


  factory Proses.fromJson(Map<String, dynamic> json){
    return(
      Proses(
        id: json['id'] as String,
        namaPengadaan: json['nama_pengadaan'],
        namaPenyedia: json['nama_penyedia'],
        metodePengadaan : json['metode_pengadaan'],
        paguPengadaan: json['pagu_pengadaan'],
        tanggalPengadaan : json['tanggal_pengadaan'],
        hpsPengadaan : json['hps_pengadaan'],
        total : json['total'],
        usulanStatus: json['usulan_status'],
      ));
  }
// !=null? json['total'] : 0
  // Map<String , dynamic> toMap(){
  //   return{
  //     'namausulan' : this.namausulan,
  //     'statustahap' : this.statustahap,
  //     'finish' : this.finish
  //   };
  // }
}