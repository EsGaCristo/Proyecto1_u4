import 'package:dam_u4_proyecto1/firebase_options.dart';
import 'package:dam_u4_proyecto1/pages/addBitacora.dart';
import 'package:dam_u4_proyecto1/pages/addVehiculo.dart';
import 'package:dam_u4_proyecto1/pages/getBitacoraVehiculo.dart';
import 'package:dam_u4_proyecto1/pages/updateBitacora.dart';
import 'package:dam_u4_proyecto1/pages/updateVehiculo.dart';
import 'package:dam_u4_proyecto1/programa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Programa(),
        '/add': (context)=> AddVehiculo(),
        '/update': (context) => UpdateVehiculo(),
        '/bitacora':(context) => GetBitacoraVehiculo(),
        '/addBitacora':(context) => AddBitacora(),
        '/updateBitacora': (context) => UpdateBitacora(),
      },
    );
  }
}
