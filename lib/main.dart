import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Tampilan/login.dart';
import 'Tampilan/SignUp.dart';
import 'Tampilan/Home.dart';
import 'package:flutter/services.dart';
import 'authent.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Auth())
      ],
      child: MaterialApp(
        theme: ThemeData.light(
          // primarySwatch: Colors.blue,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 
        // Home.routeId,
         Login.routeId,
        routes: {
          Login.routeId : (context)=>Login(),
          SignUp.routeId : (context)=>SignUp(),
          Home.routeId : (context)=>Home(),
        },
      ),
    );
  }
}