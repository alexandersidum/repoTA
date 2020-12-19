import 'package:flutter/material.dart';
import 'package:Monitoring/Tampilan/monitoringekatalog.dart';
import 'package:Monitoring/Tampilan/monitoringpengadaan.dart';
import 'package:Monitoring/Tampilan/monitoringLpse.dart';
import 'package:Monitoring/Tampilan/monitoringrekap.dart';
//import 'package:Monitoring/Komponen/kustom_button.dart';
//import 'package:provider/provider.dart';
//import 'package:Monitoring/Database/database.dart';

class Monitoring extends StatefulWidget {
  Monitoring({Key key}) : super(key: key);

  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          
            child: Column(
              
              
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 310,
          height: 120,
                
        child: RaisedButton(
          child: Text("Monitoring Pengadaan"),
          color: Colors.yellowAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonPengadaan()
            )
          );
          },
        ),
        ),
        SizedBox(
          height: 10,
        ),
         SizedBox(
          width: 310,
          height: 120,
              
        child: RaisedButton(
          child: Text("Monitoring Ekatalog"),
          color: Colors.green[400],
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonEkatalog()
            )
          );
          },
        ),
         ),
         SizedBox(
          height: 10,
        ),
         SizedBox(
          width: 310,
          height: 120,
              
        child: RaisedButton(
          child: Text("Monitoring LPSE"),
          color: Color.fromARGB(196, 196, 196, 196),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonLpse()
            )
          );
          },
        ),
         ),
         SizedBox(
          height: 10,
        ),
                 SizedBox(
          width: 310,
          height: 120,
              
        child: RaisedButton(
          child: Text("Rekap"),
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MonRekap()
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
