import 'package:cloud_firestore/cloud_firestore.dart';

class Akun {


  String getRole() {
  switch(this.role){
    case 0:
      return"Akun";
      break;
    case 1:
      return"Unit";
      break;
    case 2:
      return"Direktorat Perencanaan";
      break;
    case 3:
      return"UKPBJ";
      break;
    case 4:
      return"PPK";
      break;
    case 5:
      return"Pejabat Pengadaan";
      break;
    case 6:
      return"Pokja";
      break;
  }

}

  Akun({this.name, this.email,  this.registrationDate, this.role, this.uid});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name;
  String email;
  String registrationDate;
  String uid;
  int role;

  factory Akun.fromDb(Map<String, dynamic> parsedData){
    return Akun(
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}



class Dp extends Akun{

  Dp({String name, String email,  String registrationDate, String uid, int role})
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory Dp.fromDb(Map<String, dynamic> parsedData){
    return Dp(
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  } 
}

class UKPBJ extends Akun{
  
  UKPBJ({String name, String email,  String registrationDate, String uid, int role,})
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory UKPBJ.fromDb(Map<String, dynamic> parsedData){
    return UKPBJ(
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}
class Unit extends Akun{
  String unit;

  Unit({String name, String email,  String registrationDate, String uid, int role, })
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory Unit.fromDb(Map<String, dynamic> parsedData){
    return Unit(
      
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}

class PPK extends Akun{


  PPK({String name, String email,  String registrationDate, String uid, int role, })
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory PPK.fromDb(Map<String, dynamic> parsedData){
    return PPK(
      
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}
class PP extends Akun{
  String unit;

  PP({String name, String email,  String registrationDate, String uid, int role, })
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory PP.fromDb(Map<String, dynamic> parsedData){
    return PP(
      
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}
class Pokja extends Akun{


  Pokja({String name, String email,  String registrationDate, String uid, int role, })
  :super(name: name, email: email, registrationDate: registrationDate, uid: uid, role: role);

  factory Pokja.fromDb(Map<String, dynamic> parsedData){
    return Pokja(
      
      email: parsedData['email'],
      name:parsedData['name'],
      registrationDate:parsedData['registrationDate'].toString(),
      role:parsedData['role'],
      uid:parsedData['uid'],
    );
  }
}