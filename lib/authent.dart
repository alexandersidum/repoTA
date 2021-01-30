import 'dart:io';
import 'package:Monitoring/Model/Akun.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Tampilan/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Auth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User _user;
  Akun _userInfo;
  // Akun getUserInfo() =>_userInfo;



  Auth() {
    _auth.authStateChanges().listen((currentUser) {
      _user = currentUser;
    });
  }

   Future<bool> checkAuth() async {
    if (_auth.currentUser != null) {
      await checkUserInfo(_auth.currentUser.uid);
      return true;
    } else {
      return false;
    }
  }


  // void signUp(String _email, String _password, int role, String name, Function onComplete) async{
  //  //ExceptionHandlingnya masih ga work
  //    try {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: _email, password: _password)
  //         .then((result) async {
  //     if (result.user != null){
  //     _firestore.collection('users').doc(result.user.uid).set(
  //       {'uid': result.user.uid,
  //        'registrationDate': FieldValue.serverTimestamp(),
  //        'email':result.user.email,
  //        'name' : name,
  //        'role' : role,
  //       }
  //     ).then((value) => onComplete(AuthResultStatus.successful));
  //   }}
  //   );
  //   }catch (error) {
  //     onComplete(AuthExceptionHandler.handleException(error));
  //   }
    

  //   // catch(error){
  //   //   switch(error){
  //   //     case "ERROR_EMAIL_ALREADY_IN_USE":
  //   //     {
  //   //       //yang dilakukan apa?
  //   //       onComplete('ERROR_EMAIL_ALREADY_IN_USE');
  //   //       break;
  //   //     }
  //   //     case "ERROR_WEAK_PASSWORD":
  //   //     {
  //   //       //yang dilakukan
  //   //       break;
  //   //     }
  //   //     //Case lainnya
  //   //   }

  //   // }
    
  // }
  void createUser(String email, String password, int role, String name, Function onComplete)async{
    FirebaseApp app2 = await Firebase.initializeApp(
        name: 'aiuth2',  options: Firebase.app().options);
      try {
     await FirebaseAuth.instanceFor(app: app2)
        .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
      if (result.user != null){
        print("berhasil");
     await _firestore.collection('users').doc(result.user.uid).set(
        {'uid': result.user.uid,
         'registrationDate': FieldValue.serverTimestamp(),
         'email':result.user.email,
         'name' : name,
         'role' : role,
        }
      ).then((value) => onComplete(AuthResultStatus.successful));
      }  
    }
    );
    }catch (error) {
      onComplete(AuthExceptionHandler.handleException(error));
    }   
    app2.delete();
}

  Future<void> signIn(
      String email, String password, Function onComplete) async {
        if (email.isNotEmpty && password.isNotEmpty) {
      try{
        await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          await checkUserInfo(value.user.uid);
          onComplete(AuthResultStatus.successful);
        } else {
          onComplete(AuthResultStatus.undefined);
        }
      });
      }catch(error){
        onComplete(AuthExceptionHandler.handleException(error));
      }
      
    } else {
      onComplete(AuthResultStatus.undefined);
    }
      }

Future<Akun> checkUserInfo(uid) async{
    await _firestore.collection('users').doc(uid).get().then((value) {
      if(value.exists) {
        int role = value.data()[['role']];
        // print("Rolenya adalah $role");
        switch (role) {
          case 0:
            _userInfo = Akun.fromDb(value.data());
            break;
          case 1:
            _userInfo = Admin.fromDb(value.data());
            break;  
          case 2:
            _userInfo = Unit.fromDb(value.data());
            break;
          case 3:
            _userInfo = Dp.fromDb(value.data());
            break;
          case 4:
            _userInfo = UKPBJ.fromDb(value.data()); 
            break;
          case 5:
            _userInfo = PPK.fromDb(value.data());
            break;
          case 6:
            _userInfo = PP.fromDb(value.data()); 
            break;
          case 7:
            _userInfo = Pokja.fromDb(value.data()); 
            break;
             
          default:
            _userInfo = Akun.fromDb(value.data());
        }
        }
        
    } 
    );
    return _userInfo;
  }


  
  Future<void> signOut(BuildContext context) async {
    await _auth
        .signOut()
        .whenComplete(() => Navigator.pushNamedAndRemoveUntil(context, Login.routeId, (Route<dynamic> route)=>false ));
  }





  User get getUser => _user;
   Akun get getUserInfo => _userInfo;

   
}
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}
class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }
    static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Email yang dimasukkan tidak valid.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Username/Password Salah.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User tidak ditemukan.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User telah dinonaktifkan.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "Email telah digunakan pada akun lain.";
        break;
      default:
        errorMessage = "Terjadi kesalahan dalam proses.";
    }

    return errorMessage;
  }
}
  
  
  