import 'package:Monitoring/Komponen/kustom_button.dart';
import 'package:Monitoring/Model/ServiceUsulan.dart';
import 'package:Monitoring/Model/prosesKegiatan.dart';
import 'package:Monitoring/konstan.dart';
import 'package:flutter/material.dart';
class TambahStatus extends StatefulWidget {
   TambahStatus():super();
  final String title = 'Tambah Status';
  @override
  _TambahStatusState createState() => _TambahStatusState();
}

class _TambahStatusState extends State<TambahStatus> {
    GlobalKey<ScaffoldState> _scaffoldKey;
    TextEditingController _namaStatusController;
    String _titleProgress;
    var selectedRole;

  @override
  void initState() {
    super.initState();  
    
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaStatusController = TextEditingController();
    
    
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
     _namaStatusController.text = '';
  }
   _addUnit() {
       if (_namaStatusController.text.trim().isEmpty 
        ) {
        print("Empty fields");
       return;
    }
    _showProgress('Adding Rekap...');
      ServiceUsulan.addStatus(selectedRole,_namaStatusController.text).then((result){ 
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
                  'Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  TextField(
                   controller: _namaStatusController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Isi Status..',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                   Text(
                  'Pilih Role',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Role"),
                          
                          dropdownColor: Colors.white,
                          value: selectedRole,
                          items: Proses.listRole
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  )
                                  )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedRole= value;
                              
                            });
                          }),
                    ),  
                  
                
                CustomRaisedButton(
                  color: Colors.blue[300],
                  buttonHeight: size.height / 10,
                  text: 'Status Ditambahkan',
                  callback: () {
                   _addUnit();
                  },
                  buttonChild: Text("Tambah Status",
                      textAlign: TextAlign.center,
                      style:
                          kMavenBold.copyWith(fontSize: size.height * 0.028)),
                ),
                ])),
              )
            ],
          ),





          // child:Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget> [
          //    Padding(

          //       padding: EdgeInsets.all(20.0),         
          //      child: TextField(
          //         controller: _namaStatusController,
          //         decoration: InputDecoration.collapsed(hintText: 'Isi Status',

          //         ),
          //       )),
                //  Padding(

                // padding: EdgeInsets.all(20.0),
                // child: DropdownButtonHideUnderline(
                //       child: DropdownButton(
                //         hint: Text("Role"),
                          
                //           dropdownColor: Colors.white,
                //           value: selectedRole,
                //           items: Proses.listRole
                //               .map((e) => DropdownMenuItem<String>(
                //                     child: Text(e),
                //                     value: e,
                //                   )
                //                   )
                //               .toList(),
                //           onChanged: (value) {
                //             setState(() {
                //               selectedRole= value;
                              
                //             });
          //                 }),
          //           ),  ),
              
            
               
              
              
          //            Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //     children : [
               
          //     SizedBox(width: 20),
          //       RaisedButton(
          //         color: Colors.greenAccent,
          //         child: Text("Tambah Unit"),
          //         onPressed: (){
          //           _addUnit();
            
          //         },)
          //         ]
          //   )

              
              
          //   ],
          // ),
        )
    );
  }
}