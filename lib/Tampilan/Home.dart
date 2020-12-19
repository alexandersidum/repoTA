import 'package:Monitoring/Tampilan/dashboard.dart';
import 'package:Monitoring/Tampilan/usulanUnit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Monitoring/authent.dart';
//import 'package:Monitoring/Database/database';
import 'package:Monitoring/Tampilan/Monitoring.dart';
//import 'package:Monitoring/Tampilan/usulanUI.dart';
//import 'package:Monitoring/Tampilan/usulanWR.dart';
//import 'package:Monitoring/Tampilan/usulanPPK.dart';
//import 'package:Monitoring/konstan.dart';



class Home extends StatefulWidget {
  static const routeId = 'Home';

  @override
  State<StatefulWidget> createState() => _HomeState();

}

 class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> _bottomNavBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('Dashboard')),
    BottomNavigationBarItem(icon: Icon(Icons.monitor), title: Text('Monitoring')),
    BottomNavigationBarItem(icon: Icon(Icons.all_inbox), title: Text('Usulan')),
    BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), title: Text('SignOut')),
  ];
 
List<Widget> _listPage = [
    Dashboard(
      key: PageStorageKey('dashboard'),),
    Monitoring(
      key: PageStorageKey('monitoring')),
    ProposalScreen(
      key: PageStorageKey('usulan')),

  ];

 
int selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();

    AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueAccent,
     
      centerTitle: true,

        );
} 
@override
 Widget build(BuildContext context) {
  
      return Scaffold(
          appBar:AppBar(
            title: Text("Monitoring App"),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
            elevation: 0,
          ),
          body: PageStorage(bucket: bucket, child: _listPage[selectedIndex]),


            bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amberAccent[400],
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.blue[900],
            items: _bottomNavBarItem,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {if(index==3) Provider.of<Auth>(context, listen: false).signOut(context);
              else selectedIndex = index;
              });
              
            },
          )
          
    );
  }
 
}
    