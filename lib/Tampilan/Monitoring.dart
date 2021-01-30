
import 'package:Monitoring/Tampilan/UIRekap.dart';
import 'package:Monitoring/Tampilan/rekapuipengadaan.dart';
import 'package:flutter/material.dart';

import 'monitorinUI.dart';

class Monitoring extends StatefulWidget {
  Monitoring({Key key}) : super(key: key);

  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          
          padding: EdgeInsets.all(1),
            child: Column(
              
              
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
                 padding: EdgeInsets.all(5),
                 width: double.infinity,
                 height: 120,
        child: RaisedButton(
          child: Text("Monitoring Pengadaan"),
          color: Colors.yellowAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonitoringPUI()
            )
          );
          },
        ),
        
         ), Container(
          padding: EdgeInsets.all(5),
                 width: double.infinity,
                 height: 120,
              
        child: RaisedButton(
          child: Text("Rekap Pengadaan"),
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RekapUIPengadaan()
            )
          );
          },
        ),
         ),

                 Container(
          padding: EdgeInsets.all(5),
                 width: double.infinity,
                 height: 120,
              
        child: RaisedButton(
          child: Text("Rekap"),
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => UIRekap()
            )
          );
          },
        ),
         ),
         
        // RaisedButton(
        //   onPressed:(){
        //     Navigator.push(context, MaterialPageRoute(
        //               builder: (context) => MonEkatalog()));
        //   }
        // )
      ],
    )));
  }
}
