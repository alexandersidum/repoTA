class Laporan {
  String namaUnit;
  int totalPengeluaran;

  Laporan({this.namaUnit, this.totalPengeluaran});


  factory Laporan.fromJson(Map<String, dynamic> json){
    return(
      Laporan(
        namaUnit: json['nama_unit'] as String,
        totalPengeluaran: int.parse( json['COUNT']),
//Sesuaikno ambek jeneng kolom sing dikirim tekan db
      ));
  }
}