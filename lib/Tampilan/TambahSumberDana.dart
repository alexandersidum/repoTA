import 'package:Monitoring/Komponen/kustom_button.dart';
import 'package:Monitoring/Model/ServiceSumberDana.dart';
import 'package:Monitoring/konstan.dart';
import 'package:flutter/material.dart';
class TambahSumberDana extends StatefulWidget {
  TambahSumberDana():super();
  final String title = 'Tambah Unit';
  @override
  _TambahSumberDanaState createState() => _TambahSumberDanaState();
}

class _TambahSumberDanaState extends State<TambahSumberDana> {
    GlobalKey<ScaffoldState> _scaffoldKey;
    TextEditingController _sumberDanaController;
    String _titleProgress;


  @override
  void initState() {
    super.initState();  
    
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _sumberDanaController = TextEditingController();
    
    
  }
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Ditambahkan"),
    ));
  }
  _showProgress(String message){
      setState(() {
      _titleProgress = message;
    });
  }
   _clearValue(){
     _sumberDanaController.text = '';
  }
   _addSumberDana() {
       if (_sumberDanaController.text.trim().isEmpty 
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Rekap...');
      ServiceSumberDana.addDana(_sumberDanaController.text).then((result){ 
         if  ('success' == result){
           _showSnackBar(context, result);
         }
         _clearValue();

     });


  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
        ),
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child:CustomScrollView(
            slivers: [
              
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 16),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                     Text(
                  'Sumber Dana',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  TextField(
                   controller: _sumberDanaController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Isi Nama Sumber Dana...',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                
                CustomRaisedButton(
                  color: Colors.blue[300],
                  buttonHeight: size.height / 10,
                  text: 'Unit Ditambahkan',
                  callback: () {
                   _addSumberDana();
                  },
                  buttonChild: Text("Tambahkan Unit",
                      textAlign: TextAlign.center,
                      style:
                          kMavenBold.copyWith(fontSize: size.height * 0.028)),
                ),
                ])),
              )
            ],
          ),
        )
    );
  }
}