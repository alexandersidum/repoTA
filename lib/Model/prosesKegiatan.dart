class  Proses{

  String id;
  String namaPengadaan;
  String metodePengadaan;
  String paguPengadaan;
  String hpsPengadaan;
  String tanggalPengadaan;
  String usulanStatus;
 //belumterlaksana
  
//monitoring proeses pengadaan



  Proses({this.id, this.namaPengadaan, this.metodePengadaan, this.paguPengadaan, this.hpsPengadaan, this.tanggalPengadaan, this.usulanStatus});


  factory Proses.fromJson(Map<String, dynamic> json){
    return(
      Proses(
        id: json['id'] as String,
        namaPengadaan: json['nama_pengadaan'],
        metodePengadaan : json['metode_pengadaan'],
        paguPengadaan: json['pagu_pengadaan'],
        hpsPengadaan: json['hps_pengadaan'],
        tanggalPengadaan : json['tanggal_pengadaan'],
        usulanStatus: json['usulan_status'],
      ));
  }

  // Map<String , dynamic> toMap(){
  //   return{
  //     'namausulan' : this.namausulan,
  //     'statustahap' : this.statustahap,
  //     'finish' : this.finish
  //   };
  // }
}