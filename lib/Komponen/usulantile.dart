import 'package:flutter/material.dart';
import 'package:Monitoring/Model/item.dart';
import 'package:Monitoring/Model/itemService.dart';

class UsulanTile extends StatelessWidget {
  
  final Item item;
  final Size size;
 
  
  UsulanTile({this.item,this.size});



  @override
  Widget build(BuildContext context) {
    DateTime.parse((item.tanggal));
    DateTime tgl = DateTime.parse(item.tanggal);
    var tanggal =  "${tgl.day} - ${tgl.month} - ${tgl.year}";
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
                    Container(
                      alignment : Alignment.centerRight,
                      child:TextButton(
                      onPressed:(){ ItemService().deleteProps(id: item.id);},
                      child: const Text("Delete",
                      style: TextStyle(fontSize: 13,color: Colors.red
                      ))
                    )
                    )], )
                    
                ),
            
            ],
    )));

  }
}