class  Proses{

  String id;
  String namaUnit;
  String namaPengadaan;
  String jenisPengadaan;
  String tanggal;
  String bulan;
  String tahun;
  String volume;
  String sumberDana;
  String pemilihanAwal;
  String pemilihanAkhir;
  String pekerjaanAwal;
  String pekerjaanAkhir;
  String namaPenyedia;
  String metodePengadaan;
  String paguPengadaan;
  String hpsPengadaan;
  String nilaiKontrak;
  String sisaAnggaran;
  String usulanStatus;

 //belumterlaksana
  static  List<String> listMethod =  ['Pengadaan Langsung', 'Penunjukan Langsung', 'Tender Cepat', 'Tender'];
  static  List<String> listPengadaan = ['Pengadaan Barang', 'Pengadaan Konstruksi'];
  static  List<String> listUnit =['Sistem informasi'];//nanti
  static  List<String> listDay=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
  static  List<String> listMonth=['Januari','Februari','Maret', 'April','Mei','Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
  static  List<String> listYear=['2019','2020','2021','2022','2023','2024','2025','2026'];
  static  List<int> listMonthRekap=[1,2,3,4,5,6,7,8,9,10,11,12];
  Proses({this.id, this.namaUnit, this.namaPengadaan, this.jenisPengadaan, this.tanggal, this.bulan, this.tahun, this.volume,this.sumberDana,this.pemilihanAwal,this.pemilihanAkhir,this.pekerjaanAwal,this.pekerjaanAkhir, this.namaPenyedia, this.metodePengadaan, this.paguPengadaan, this.hpsPengadaan, this.nilaiKontrak, this.sisaAnggaran, this.usulanStatus});
  static  List<String> listMethodRekap =  ['Pengadaan Langsung', 'Penunjukan Langsung', 'Tender Cepat', 'Tender', 'Ekatalog'];
  static  List<String> listRole =  ['Unit' ,'Direktorat Perencanaan', 'UKPBJ', 'PPK', 'Pejabat Pengadaan', 'Pokja'];
  
  factory Proses.fromJson(Map<String, dynamic> json){
    return(
      Proses(
        id: json['id'] as String,
        namaUnit: json['nama_unit'],
        namaPengadaan: json['nama_pengadaan'],
        jenisPengadaan: json['jenis_pengadaan'],
        tanggal : json['tanggal'],
        bulan : json['bulan'],
        tahun : json['tahun'],
        volume: json['volume'],
        sumberDana: json['sumber_dana'],
        pemilihanAwal: json['pemilihan_awal'],
        pemilihanAkhir: json['pemilihan_akhir'],
        pekerjaanAwal: json['pekerjaan_awal'],
        pekerjaanAkhir: json['pekerjaan_akhir'],
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