import 'package:Monitoring/authent.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/item.dart';
import 'package:Monitoring/Model/itemService.dart';
import 'package:provider/provider.dart';

class UsulanTile extends StatelessWidget {
  
  final Item item;
  final Size size;
 
  
  UsulanTile({this.item,this.size});
//   String tanggalAkhir;//akhir pelaksanaan pemilihan
//   String tanggalAwalPek;//awal pelaksanaan pekerjaan
//   String tanggalAkPek;// akhir pelaksanaan pekerjaan
//   String volume;
//   String sumberDana;
//   String metodePemilihan;


  @override
  Widget build(BuildContext context) {
    DateTime.parse((item.tanggal));
    DateTime tgl = DateTime.parse(item.tanggal);
    var tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";

    // DateTime.parse((item.tanggalAkhir));
    // DateTime tgl1 = DateTime.parse(item.tanggalAkhir);
    // var tanggal1 =  "${tgl1.day} - ${tgl1.month} - ${tgl1.year}";

    // DateTime.parse((item.tanggalAwalPek));
    // DateTime tgl2 = DateTime.parse(item.tanggalAwalPek);
    // var tanggal2 =  "${tgl2.day} - ${tgl2.month} - ${tgl2.year}";

    // DateTime.parse((item.tanggalAkPek));
    // DateTime tgl3 = DateTime.parse(item.tanggalAkPek);
    // var tanggal3 =  "${tgl3.day} - ${tgl3.month} - ${tgl3.year}";
    var account = Provider.of<Auth>(context).getUserInfo;
    if (account.role == 3) {
    return Container(
      padding: EdgeInsets.all(1),
        child: Card(
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),elevation: 1,
          child: Column(
            children: [
              Container(
                
                constraints: BoxConstraints(
                  maxHeight: size.height*0.04
                ),
                padding: EdgeInsets.all(1),
                width: double.infinity,
              ),
              Container(
                
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usulan : ${item.judul}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                    Text(
                     'Nama Unit : ${item.unit}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                    Text('Tanggal Pelaksanaan Pemilihan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ) ,
                    SizedBox(
                              height: 5.0,
                            ),
                    Text(
                     'Awal : $tanggal',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),     
                    ),
                    // SizedBox(
                    //           height: 5.0,
                    //         ),
                    // Text(
                    //  'Akhir : $tanggal1',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black
                    //   ),  
                    // ),
                    // SizedBox(
                    //           height: 5.0,
                    //         ),
                    //  Text('Tanggal Pelaksanaan Pekerjaan',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black
                    //   ),
                    // ),
                    // SizedBox(
                    //           height: 5.0,
                    //         ),
                    // Text(
                    //  'Awal : $tanggal2',
                    
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black
                    //   ),
                      
                    // ),
                    // SizedBox(
                    //           height: 5.0,
                    //         ),
                    // Text(
                    //  'Akhir : $tanggal3',
                    
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black
                    //   ),  
                    // ),
                    // SizedBox(
                    //           height: 5.0,
                    //         ),
                     Text(
                      'Usulan : ${item.volume}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                    Text(
                      'Usulan : ${item.sumberDana}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                     Text(
                      'Usulan : ${item.metodePemilihan}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),

                    Container(
                      alignment : Alignment.centerRight,
                      child:TextButton(
                      onPressed:(){ ItemService().deleteProps(id: item.id);},
                      child: const Text("Finish",
                      style: TextStyle(fontSize: 14,color: Colors.red
                      ))
                    )
                    )], )
                    
                ),
            
            ],
    )
    )
    );
    }else{
      return Container(
      padding: EdgeInsets.all(1),
        child: Card(
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),elevation: 1,
          child: Column(
            children: [
              Container(
                
                constraints: BoxConstraints(
                  maxHeight: size.height*0.04
                ),
                padding: EdgeInsets.all(1),
                width: double.infinity,
              ),
              Container(
                
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usulan : ${item.judul}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                    Text(
                     'Nama Unit : ${item.unit}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      
                    ),
                    SizedBox(
                              height: 5.0,
                            ),
                    Text(
                     'Tanggal : $tanggal',
                    
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),                      
                    ),
                    ], 
                    )  
                ),
            ],
    )
    )
    );
    }
  }
}