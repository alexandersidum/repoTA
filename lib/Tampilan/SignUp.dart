//import 'dart:io';
//import 'package:Monitoring/Tampilan/Home.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Komponen/kustom_button.dart';
import 'package:Monitoring/Komponen/kustom_text_field.dart';
import 'package:Monitoring/Tampilan/login.dart';
import 'package:provider/provider.dart';
import 'package:Monitoring/authent.dart';
import 'package:Monitoring/konstan.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';


//Register sebagai seller screen belum
class SignUp extends StatefulWidget {

  static const routeId = 'signup';

  @override
  _SignUpScreen createState() => _SignUpScreen();

  //Testing belum diapa2in

}

class _SignUpScreen extends State<SignUp>{

  TextEditingController _nameController = TextEditingController();
 // TextEditingController _roleController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  String validationText = '';
  var roles = ['Direktorat Perencana', 'UKPBJ', 'PPK', 'Unit'];
  var selectedRolesDesc;
  //var selectedRoles = null;

  void onCompleteRegis(AuthResultStatus status){
    setState(() {
     validationText = AuthExceptionHandler.generateExceptionMessage(status);
    });
    if(status==AuthResultStatus.successful){
      Navigator.of(context).pushNamedAndRemoveUntil(Login.routeId,(Route<dynamic> route) => false);
      }
  }

  void signUp()async{
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    var role = roles.indexOf(selectedRolesDesc)+1;
    var name = _nameController.text.toString();
    Provider.of<Auth>(context, listen: false).signUp(email, password, role, name, onCompleteRegis);
  }

  List<DropdownMenuItem> dropDownMenu(Map input) {
    List<DropdownMenuItem> output = [];
    input.forEach((key, value) {
      output.add(DropdownMenuItem<int>(
        child: Text(value),
        value: key,
      ));
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBlueMainColor,
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: kBlueMainColor,
                elevation: 0,
                title: Text(''),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Menu Registrasi',
                      style: kMavenBold.copyWith(
                          color: kOrangeButtonColor,
                          fontSize: size.height / 30),
                    ),
                  )
                ],
              ),
              SliverPersistentHeader(
                  pinned: false,
                  floating: false,
                  delegate:
                      TopContainer(size: size, minExtent: 25, maxExtent: 50)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 16),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Text('Email',
                      style: kCalibriBold.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.025,
                      )),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  Text('Password',
                      style: kCalibriBold.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.027,
                      )),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: true,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  Text('Konfirmasi Password',
                      style: kCalibriBold.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.027,
                      )),
                  CustomTextField(
                    hintText: 'Masukkan ulang password',
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: true,
                    color: Colors.white,
                    // callback: ,
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  Text('Nama',
                      style: kCalibriBold.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.025,
                      )),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Nama',
                    keyboardType: TextInputType.text,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  Text('Mendaftar Sebagai',
                      style: kCalibriBold.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.025,
                      )),
                  Container(
                    margin: EdgeInsets.only(right: size.width / 2.5),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: size.width / 20, right: size.width / 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: selectedRolesDesc,
                          items: roles
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedRolesDesc = value;
                              //selectedRoles = value;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 30),
                    child: Text(
                      '*Akun akan memiliki status sebagai pengunjungselama admin belum memverifikasi data registrasi',
                      style: kMaven.copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 100),
                    child: Text(
                      '*Hubungi admin jika terdapat masalah atau waktu verifikasi yang terlalu lama',
                      style: kMaven.copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 100),
                    child: Text(
                      validationText,
                      style: kMavenBold.copyWith(
                        color: Colors.red,
                      fontSize: size.height/40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 100,
                        vertical: size.height / 100),
                    child: CustomRaisedButton(
                      buttonHeight: size.height / 10,
                      callback: () {
                        signUp();
                      },
                      color: kOrangeButtonColor,
                      buttonChild: Text("Submit Registrasi",
                          textAlign: TextAlign.center,
                          style: kMavenBold.copyWith(
                              fontSize: size.height * 0.028)),
                    ),
                  ),
                ])),
              )
            ],
          ),
        ));
  }
}
class TopContainer extends SliverPersistentHeaderDelegate {
  double maxExtent;
  double minExtent;
  Size size;

  TopContainer({this.maxExtent, this.minExtent, this.size});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      height: size.height / 10,
      child: Text(
        'Masukkan data sesuai dengan identitas asli anda, dan hubungi admin jika memiliki kendala',
        style: kMaven.copyWith(
          color: Colors.white,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}