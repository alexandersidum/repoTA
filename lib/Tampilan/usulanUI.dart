import 'package:Monitoring/Komponen/usulantile.dart';
import 'package:Monitoring/Model/item.dart';
import 'package:Monitoring/Tampilan/usulanUnit.dart';
import 'package:Monitoring/authent.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class UsulanUI extends StatefulWidget {
 UsulanUI({Key key}) : super(key: key);
  @override
  _UsulanUIState createState() => _UsulanUIState();
  
}

class _UsulanUIState extends State<UsulanUI> { 

  @override
  Widget build(BuildContext context) {
    List<Item> listUsulan = Provider.of<List<Item>>(context);
    Size size = MediaQuery.of(context).size;
    var account = Provider.of<Auth>(context).getUserInfo;
     if (account.role == 2) {
    return Scaffold(
       appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Text("Add"),
                // icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProposalScreen()
            )
          );
                }),
          ],
        ),

     body:Container(
      child: ListView.builder(
        itemCount : listUsulan!=null? listUsulan.length: 0,
        itemBuilder:(context, index){ return UsulanTile(item:listUsulan[index], size : size);
        
        
        },
        
        )
    ),
    );}else{
     return Scaffold(
      body:Container(
      child: ListView.builder(
        itemCount : listUsulan!=null? listUsulan.length: 0,
        itemBuilder:(context, index){ return UsulanTile(item:listUsulan[index], size : size);              
        },   
        )
    ),
    );
    }
}
}