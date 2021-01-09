class  Proses{

  String id;
  String namaUnit;
  String namaPengadaan;
  String tanggalPengadaan;
  String namaPenyedia;
  String metodePengadaan;
  String paguPengadaan;
  String hpsPengadaan;
  String nilaiKontrak;
  String sisaAnggaran;
  String usulanStatus;

 //belumterlaksana
  static  List<String> listMethod =  ['Pengadaan Langsung', 'Penunjukan Langsung', 'Tender Cepat', 'Tender'];
  // static  List<String> listStatus = ['proses pengumpulan dokumen', 'Diproses secara manual','Diproses melalui Lpse selesai di ukpbj', 
  // 'tender gagal'];
//monitoring proeses pengadaan



  Proses({this.id, this.namaUnit, this.namaPengadaan, this.tanggalPengadaan, this.namaPenyedia, this.metodePengadaan, this.paguPengadaan, this.hpsPengadaan, this.nilaiKontrak, this.sisaAnggaran, this.usulanStatus});


  factory Proses.fromJson(Map<String, dynamic> json){
    return(
      Proses(
        id: json['id'] as String,
        namaUnit: json['nama_unit'],
        namaPengadaan: json['nama_pengadaan'],
        tanggalPengadaan : json['tanggal_pengadaan'],
        namaPenyedia: json['nama_penyedia'],
        metodePengadaan : json['metode_pengadaan'],
        paguPengadaan: json['pagu_pengadaan'],
        hpsPengadaan : json['hps_pengadaan'],
        nilaiKontrak: json['nilai_kontrak'],
        sisaAnggaran : json['sisa_anggaran'],
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