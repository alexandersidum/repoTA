import 'package:Monitoring/Tampilan/Home.dart';
import 'package:flutter/material.dart';
import 'package:Monitoring/Tampilan/SignUp.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../authent.dart';
import '../Komponen/kustom_button.dart';
import 'package:Monitoring/komponen/kustom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Monitoring/konstan.dart';

class Login extends StatefulWidget {
  static const routeId = 'Login';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String validationText = '';

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void loginCallback() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false)
        .signIn(emailController.text, passwordController.text,
            (AuthResultStatus status) {
      if (status == AuthResultStatus.successful) {
        Navigator.pushReplacementNamed(context, Home.routeId);
      }
      validationText = AuthExceptionHandler.generateExceptionMessage(status);
      isLoading = false;
      setState(() {});
    });
  }

  void checkLogin() async {
    await Provider.of<Auth>(context, listen: false).checkAuth().then((value) {
      if (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Home.routeId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundMainColor,
      body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: Text('Welcome to Login',
                      style: kMavenBold.copyWith(
                        color: kBlueDarkColor,
                        fontSize: size.height * 0.035,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.01,
                      right: size.width * 0.2),
                  child: Text(
                    'Silahkan Masuk dengan menggunakan E-mail dan Password yang sesuai',
                    style: TextStyle(
                        color: kBlueDarkColor, fontFamily: 'MavenPro'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40)),
                        color: kBlueMainColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.08),
                          child: Text('LOGIN FORM',
                              style: kMavenBold.copyWith(
                                color: Colors.white,
                                fontSize: size.height * 0.03,
                              )),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Email',
                                  style: kCalibriBold.copyWith(
                                    color: Colors.white,
                                    fontSize: size.height * 0.027,
                                  )),
                              CustomTextField(
                                controller: emailController,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text('Password',
                                  style: kCalibriBold.copyWith(
                                    color: Colors.white,
                                    fontSize: size.height * 0.027,
                                  )),
                              CustomTextField(
                                controller: passwordController,
                                hintText: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                isObscure: true,
                                color: Colors.white,
                              ),
                              Container(
                                child: Text(validationText),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              CustomRaisedButton(
                                buttonHeight: size.height / 10,
                                callback: () {
                                  loginCallback();
                                },
                                color: kOrangeButtonColor,
                                buttonChild: Text("Login Now",
                                    textAlign: TextAlign.center,
                                    style: kMavenBold.copyWith(
                                        fontSize: size.height * 0.028)),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              CustomRaisedButton(
                                buttonHeight: size.height / 13,
                                callback: () {
                                  Navigator.pushNamed(context, SignUp.routeId);
                                },
                                color: kLightBlueButtonColor,
                                buttonChild: Text("Register",
                                    textAlign: TextAlign.center,
                                    style: kMavenBold.copyWith(
                                        fontSize: size.height * 0.028)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
