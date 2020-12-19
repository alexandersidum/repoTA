//import 'package:Monitoring/Model/item.dart';
//import 'package:Monitoring/Model/Ekatalog.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Model/Akun.dart';
import 'package:provider/provider.dart';

import '../authent.dart';
//import 'package:provider/provider.dart';
//import 'package:Monitoring/konstan.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    SizedBox(
                      width: 310.0,
                      height: 120.0,
                      child: Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Login Sebagai",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:22.0
                                ),
                              ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Role :",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0
                              ),
                            ),
                            
                            Text(
                              Provider.of<Auth>(context).getUserInfo.getRole(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:17.0
                                ),

                            )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 130.0,
                      child: Card(
                        color: Colors.green[600],
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Jumlah Transaksi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:18.0
                                ),
                              ),
                            SizedBox(
                              height: 70.0,
                            ),  
                            Text(
                              "20 Pengadaan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:14.0
                                ),
                            )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 130.0,
                      child: Card(
                        color: Color.fromARGB(196, 196, 196, 196),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Jumlah Paket",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:18.0
                                ),
                              ),
                            SizedBox(
                              height: 70.0,
                            ),  
                            Text(
                              "20 Paket",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:14.0
                                ),
                            )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
