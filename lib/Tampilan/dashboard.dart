
import 'package:Monitoring/Komponen/kustom_button.dart';
// import 'package:Monitoring/Model/ServiceEkatalog.dart';
// import 'package:Monitoring/Model/ServiceEntryUnit.dart';
// import 'package:Monitoring/Model/ServicePengadaan.dart';
// import 'package:Monitoring/Model/ServiceUsulan.dart';
import 'package:Monitoring/Tampilan/SignUp.dart';
import 'package:Monitoring/Tampilan/TambahStatus.dart';
import 'package:Monitoring/Tampilan/TambahUnit.dart';
import 'package:Monitoring/Tampilan/TambahSumberDana.dart';
import 'package:Monitoring/konstan.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../authent.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  
//   _createEkatalog() {
    
//     ServiceEkatalog.createTable().then((result){
 
//     });
//   }
//  _createStatus() {
    
//     ServiceUsulan.createTable().then((result){
 
//     });
//   }
//   _createUnit() {
    
//     ServiceUnit.createTable().then((result){
 
//     });
//   }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var account = Provider.of<Auth>(context).getUserInfo;
    if (account.role == 1) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(1),
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "HALAMAN UTAMA APLIKASI MONITORING",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
            ,elevation: 2,
              child: Column(children: [
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(
                                "Login Sebagai",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:22.0
                                ),
                              ),
                  SizedBox(
                              height: 5.0,
                            ),
                  Text(
                              Provider.of<Auth>(context).getUserInfo.getRole(),
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize:20.0
                                ),

                            )

            ],
            )

            ,),Container(
                
                constraints: BoxConstraints(
                  maxHeight: size.height*0.01
                ),
                padding: EdgeInsets.all(1),
                width: double.infinity,
              ),
              
            
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children : [
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Menambah Unit"),
                  onPressed: (){
                     Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TambahUnit()));
            
                  },),
                  SizedBox(
                    width: 10),

                  RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Menambah Status"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TambahStatus()));
                   
                    
            
                  },)
                  ]
                
                  ),
                  RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Menambah Sumber Dana"),
                  onPressed: (){
                     Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TambahSumberDana()));
            
                  },),
            
            

          
              ]
              ),
          ),SizedBox(
                              height: 100.0,
                            ),            CustomRaisedButton(
                                buttonHeight: size.height / 10,
                                callback: () {
                                  Navigator.pushNamed(context, SignUp.routeId);
                                },
                                color: kLightBlueButtonColor,
                                buttonChild: Text("Buatkan Akun",
                                    textAlign: TextAlign.center,
                                    style: kMavenBold.copyWith(
                                        fontSize: size.height * 0.028)),
                              ),
                              Text(
              
                                "*Membuat Akun Untuk Setiap Aktor",
                                textAlign: TextAlign.center,
                                style: kMaven.copyWith(
                                      color: Colors.grey,
                                        fontSize: size.height * 0.015)
                              ),
              ])
              )
              );
    }else{
      return Scaffold(
      body:Container(
        padding: EdgeInsets.all(1),
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "HALAMAN UTAMA APLIKASI MONITORING",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
            ,elevation: 1,
              child: Column(children: [
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(
                                "Login Sebagai",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:22.0
                                ),
                              ),
                  SizedBox(
                              height: 5.0,
                            ),
                  Text(
                              Provider.of<Auth>(context).getUserInfo.getRole(),
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize:20.0
                                ),

                            ) ],
            )

            ,),Container(
                
                constraints: BoxConstraints(
                  maxHeight: size.height*0.04
                ),
                padding: EdgeInsets.all(1),
                width: double.infinity,
            )

            ]
            )
              )
              ])));
    
    }
  }
}
